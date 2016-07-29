//
//  b4u_ReOrderViewController.swift
//  ThanksScreen
//
//  Created by Rahul on 11/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class b4u_ReOrderViewController: UIViewController,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var reOrderTableView: UITableView!
    
    var myReOrderModelArr:[b4u_ReOrderModel] = Array()
    
    @IBOutlet weak var viewUserNotLoggedIn: UIView!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loginDismissed", name:kUserDataReceived, object:nil);

        self.validateUser()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cleanSelection()
    }
    
    func cleanSelection()
    {
        bro4u_DataManager.sharedInstance.selectedDate = nil
        bro4u_DataManager.sharedInstance.selectedTimeSlot = nil
        bro4u_DataManager.sharedInstance.userSelectedFilterParams = nil
    }

    
    func validateUser()
    {
        reOrderTableView.hidden = true
        
        let isUserLoggedIn =   NSUserDefaults.standardUserDefaults().objectForKey("isUserLogined")
        
        if let hasLogin:Bool = isUserLoggedIn as? Bool
        {
           
            if hasLogin
            {
                self.viewUserNotLoggedIn.hidden = true
                
             
                // Do any additional setup after loading the view.
                self.addLoadingIndicator()
                
                self.getData()
            }
        }else
        {
            self.viewUserNotLoggedIn.hidden = false
            reOrderTableView.hidden = true
        }
        
    }

    
    
//    func getData()
//    {
//        
//        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
//
//        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
//            
//            var filedName = loginInfoData.userId! //Need to use later
//            
//        }
//
//        
//        let params = "?user_id=\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)&\(kAppendURLWithApiToken)"
//        b4u_WebApiCallManager.sharedInstance.getApiCall(kReOrderIndex , params:params, result:{(resultObject) -> Void in
//            
//            print(" ReOrder Data Received")
//            
//            print(resultObject)
//            
//            self.congigureUI()
//
//        })
//    }
  
  
    func getData()
    {
      //2. Checking for Network reachability
      
      if(AFNetworkReachabilityManager.sharedManager().reachable){
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
          
          var filedName = loginInfoData.userId! //Need to use later
          
        }
        
        
        let params = "?user_id=\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)&\(kAppendURLWithApiToken)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReOrderIndex , params:params, result:{(resultObject) -> Void in
          
          print(" ReOrder Data Received")
          
          print(resultObject)
          
          self.congigureUI()
          
        })
        //3.Remove observer if any remain
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
        
      }else{
        //4. First Remove any existing Observer
        //Add Observer for No network Connection
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(b4u_ReOrderViewController.getData), name: "NoNetworkConnectionNotification", object: nil)
        
        //5.Adding View for Retry
        let noNetworkView = NoNetworkConnectionView(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.height))
        self.view.addSubview(noNetworkView)
        
        return
      }
      
      
    }
  
    func congigureUI()
    {
        if bro4u_DataManager.sharedInstance.myReorderData.count > 0
        {
            reOrderTableView.hidden = false
            reOrderTableView.reloadData()

        }
        else
        {
            self.view.makeToast(message:"No Orders found", duration:1.0, position:HRToastPositionDefault)

        }
         b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

    }

  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Tableview Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return bro4u_DataManager.sharedInstance.myReorderData.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
       let cellIdentifier = "ReOrderTableViewCellID"
       let  cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_ReOrderTableViewCell
        
        let reOrderModel:b4u_ReOrderModel = bro4u_DataManager.sharedInstance.myReorderData[indexPath.section]
        
        cell.btnOrderDelete.tag = indexPath.section
        cell.btnReOrder.tag = indexPath.section
        cell.btnViewOrderDetails.tag = indexPath.section

        cell.configureData(reOrderModel)
        
        b4u_Utility.shadowEffectToView(cell)

        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0
        {
            return 1.0;
        }
        else
        {
            return 10.0;
        }
        
    }

    
//    @IBAction func btnCancelClicked(sender:AnyObject)
//    {
//       self.dismissViewControllerAnimated(true, completion:nil)
//    }


    
    @IBAction func orderDeleteBtnPressed(sender: AnyObject)
    {
        let reOrderModel:b4u_ReOrderModel = bro4u_DataManager.sharedInstance.myReorderData[sender.tag]
        
        let filedName = reOrderModel.orderID!
        
        
        let params = "/\(filedName)?\(kAppendURLWithApiToken)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReOrderDeleteIndex, params:params, result:{(resultObject) -> Void in
            
            print(resultObject)
            self.validateUser()
        })
    }
    
    @IBAction func viewDetailsBtnPressed(sender: AnyObject)
    {

        let storyboard : UIStoryboard = self.storyboard!
        
        let reOrderDetailController:b4u_ReOrderDetail = storyboard.instantiateViewControllerWithIdentifier("ReOrderDetailID") as! b4u_ReOrderDetail
        reOrderDetailController.selectedReorderTag = sender.tag
        reOrderDetailController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        reOrderDetailController.preferredContentSize = CGSizeMake(300, 250)
        reOrderDetailController.definesPresentationContext = true
        let popoverMenuViewController = reOrderDetailController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.bounds),
            y: CGRectGetMidY(self.view.bounds),
            width: 1,
            height: 1)
        presentViewController(
            reOrderDetailController,
            animated: true,
            completion: nil)
    }
    
    
    
    @IBAction func reOrderBtnPressed(sender: AnyObject)
    {
        
        let reOrderModel:b4u_ReOrderModel = bro4u_DataManager.sharedInstance.myReorderData[sender.tag]

        bro4u_DataManager.sharedInstance.selectedReorderModel = reOrderModel
        
        self.performSegueWithIdentifier("reOrderSegue", sender:reOrderModel)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "reOrderSegue"
        {
//            let paymetnBaseCtrl =  segue.destinationViewController as! b4u_PaymentBaseViewController
            
            
        }
    }
    

  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }

    @IBAction func okButtonClicked(sender: AnyObject)
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.performSegueWithIdentifier("reOrderloginSegue", sender:nil)
        })
    }
    
    func loginDismissed()
    {
        self.validateUser()
    }
}
