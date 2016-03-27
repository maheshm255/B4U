//
//  b4u_ReOrderViewController.swift
//  ThanksScreen
//
//  Created by Rahul on 11/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class b4u_ReOrderViewController: UIViewController {

    @IBOutlet weak var reOrderTableView: UITableView!
    
    var myReOrderModelArr:[b4u_ReOrderModel] = Array()
    
    @IBOutlet weak var viewUserNotLoggedIn: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loginDismissed", name:kUserDataReceived, object:nil);

        self.validateUser()
        
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

    
    
    func getData()
    {
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            var filedName = loginInfoData.userId! //Need to use later
            
        }

        
        let params = "?user_id=\(1626)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReOrderIndex , params:params, result:{(resultObject) -> Void in
            
            print(" ReOrder Data Received")
            
            print(resultObject)
            
            self.congigureUI()

        })
    }
    
    
    func congigureUI()
    {
    
        reOrderTableView.hidden = false

    reOrderTableView.reloadData()
    
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
        
        cell.configureData(reOrderModel)
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

    
    @IBAction func btnCancelClicked(sender:AnyObject)
    {
       self.dismissViewControllerAnimated(true, completion:nil)
    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 105.0;
//    }
    
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        cell.contentView.backgroundColor = UIColor.clearColor()
//        let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 90))
//        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
//        whiteRoundedView.layer.masksToBounds = false
//        whiteRoundedView.layer.cornerRadius = 3.0
//        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
//        whiteRoundedView.layer.shadowOpacity = 0.5
//        cell.contentView.addSubview(whiteRoundedView)
//        cell.contentView.sendSubviewToBack(whiteRoundedView)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
