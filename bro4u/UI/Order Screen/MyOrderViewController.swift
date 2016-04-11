//
//  MyOrderViewController.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyOrderViewController: UIViewController,UIPopoverPresentationControllerDelegate ,orderResheduleDelegate{

    @IBOutlet weak var viewUserNotLoggedIn: UIView!
    @IBOutlet weak var orderTableView: UITableView!
  
    var onGoingOrderArray:[b4u_OrdersModel]?
    var pastOrdersArray:[b4u_OrdersModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loginDismissed", name:kUserDataReceived, object:nil);
     
        self.validateUser()
    }
    
    func validateUser()
    {
        orderTableView.hidden = true
        
        let isUserLoggedIn =   NSUserDefaults.standardUserDefaults().objectForKey("isUserLogined")
        
        if let hasLogin:Bool = isUserLoggedIn as? Bool
        {
            if hasLogin
            {
                self.viewUserNotLoggedIn.hidden = true
                
                self.addLoadingIndicator()
                
                self.getData()
            }
        }else
        {
            self.viewUserNotLoggedIn.hidden = false
            orderTableView.hidden = true
        }
        
    }
  
    func getData()
    {
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        var user_id = ""
        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            user_id = loginInfoData.userId! //Need to use later
            
        }
        
        //user_id = "1"
        
        let params = "?user_id=\(user_id)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyOrdersIndex , params:params, result:{(resultObject) -> Void in
            
            print(" Orders Data Received")
            
            print(resultObject)
            
            self.congigureUI()
            
        })
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        self.view.alpha = 1.0
    }
    
    func congigureUI()
    {
        orderTableView.hidden = false

        
        self.onGoingOrderArray = self.filterContent("yes", orderType:orderTypes.kOnGoingOrders)

        self.pastOrdersArray = self.filterContent("no", orderType:orderTypes.kCompetedOrders)

     //   self.onGoingOrderArray = self.filterContent("Completed", scope:"")
        
        orderTableView.reloadData()
        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

    }
  
    private func filterContent(searchText:String , orderType:orderTypes)->[b4u_OrdersModel]?
        
    {
        let allOreders =  bro4u_DataManager.sharedInstance.orderData
        
        var filteredItems:[b4u_OrdersModel]?
        if ( allOreders.count > 0)
        {
            
            filteredItems =   allOreders.filter({m in
                
                if let orderDesc = m.onGoing
                    
                {
                    switch orderType
                    {
                    case .kOnGoingOrders:
                        return orderDesc.contains(searchText)
                    case .kCompetedOrders:
                        return orderDesc.contains(searchText)

                    }
                    
                }else
                    
                {
                    return false
                }
                
            })
            
        }
        
        return filteredItems
    }
    
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/

//Tableview Data Source

  func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 2
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    if section == 0 && self.onGoingOrderArray?.count>0 {
        return (self.onGoingOrderArray?.count)!

    }
    else if section == 1 && self.pastOrdersArray?.count>0{
        return (self.pastOrdersArray?.count)!
    }
    
    return 0
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cellIdentifier = ""
    
    if indexPath.section == 0
    {
      cellIdentifier = "OngoingOrdersTableViewCellID"
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! OngoingOrdersTableViewCell
        
        
        cell.btnCancel.tag = indexPath.row
        cell.btnReshedule.tag = indexPath.row
        cell.btnTrack.tag = indexPath.row
        
        cell.configureData(self.onGoingOrderArray![indexPath.row])
  
    
        
      return cell
    }
    else{
        cellIdentifier = "PastOrdersTableViewCellID"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PastOrdersTableViewCell
        
        cell.configureData(self.pastOrdersArray![indexPath.row])

        return cell

    }
  }
  
  
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        if indexPath.section == 0
        {
            return 300;
        }
        else if indexPath.section == 1
        {
            return 160;
        }
        
        return 0
    }
    
    internal func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
//        switch (section) {
//        case 0:
//            if self.onGoingOrderArray?.count>0{
//                
//                return 30;
//            }
//            
//        case 1:
//            if self.onGoingOrderArray?.count>0{
//            }
//            
//        default:
//            break
//            
//        }
        
        return 50.0

    }


  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 50))
    headerView.backgroundColor = UIColor(colorLiteralRed: 255/255.0, green: 231/255.0, blue: 146/255.0, alpha: 1)
    
    let label = UILabel(frame: CGRectMake(10.0, 0.0, tableView.frame.size.width, 50.0)) // Doesn't care about x, y offset
    label.textColor = UIColor.blackColor()
    label.textAlignment = NSTextAlignment.Center
    headerView.addSubview(label)

    switch (section) {
    case 0:
      if self.onGoingOrderArray?.count>0{
        label.text = "ONGOING ORDERS (\(self.onGoingOrderArray!.count))"
      }

    case 1:
      if self.onGoingOrderArray?.count>0{
        label.text = "PAST ORDERS (\(self.pastOrdersArray!.count))"
      }
    
    default:
      break

    }
    
    return headerView
  }
  
  
  
  @IBAction func cancelBtnClicked(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion:nil)
    

  }

  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }
  
  @IBAction func cancelBtnAction(sender: AnyObject) {

    let selectedOrderObj: b4u_OrdersModel  =  self.onGoingOrderArray![sender.tag]
    self.showAlertView("Cancel", selectedOrderObj:selectedOrderObj)

    
    //    let tableView = self.superview?.superview as! UITableView
    //
    //    let indexPath = tableView.indexPathForCell(self)
    //
    //    let orderModel:b4u_OrdersModel = bro4u_DataManager.sharedInstance.orderData[indexPath!.row]
    //    var metaDataModel:b4u_ReOrder_MetaItemModel?
    //    if orderModel.metaItemReOrder?.count > 0{
    //
    //        metaDataModel = orderModel.metaItemReOrder?.first
    //
    //        let params = "?order_id=\(orderModel.orderID!)&user_id=\(metaDataModel!.userID!)&vendor_id=\(orderModel.vendorID!)&cancel_message=\("Text")"//Need to pass the textfield Message from popup
    //
    //        b4u_WebApiCallManager.sharedInstance.getApiCall(kCancelOrderIndex, params:params, result:{(resultObject) -> Void in
    //
    //        })
    //    }
    //
    //
    //    tableView.reloadData()
  }
  
    @IBAction func btnRaiseIssuePressed(sender: AnyObject)
    {
        let selectedOrderObj: b4u_OrdersModel  =  self.onGoingOrderArray![sender.tag]
        self.showAlertView("RaiseIssue", selectedOrderObj:selectedOrderObj)

    }
  @IBAction func trackBtnAction(sender: AnyObject) {
 
    
    let selectedOrderObj: b4u_OrdersModel  =  self.onGoingOrderArray![sender.tag]
    self.showAlertView("Track", selectedOrderObj:selectedOrderObj)

  
  }
  
  
  @IBAction func rescheduledBtnAction(sender: AnyObject) {
  
    let selectedOrderObj: b4u_OrdersModel  =  self.onGoingOrderArray![sender.tag]
    self.showAlertView("Reschedule", selectedOrderObj:selectedOrderObj)

  }
  
  
  @IBAction func callBro4uAction(sender: AnyObject) {
  }
  
  
  @IBAction func payOnlineAction(sender: AnyObject) {
  

    let selectedOrderObj: b4u_OrdersModel  =  self.onGoingOrderArray![sender.tag]
    self.showAlertView("PayOnline", selectedOrderObj:selectedOrderObj)

  }
  

    func showAlertView(btnTapped: String,  selectedOrderObj:b4u_OrdersModel)
  {
    let storyboard : UIStoryboard = self.storyboard!
    
    if btnTapped == "Cancel"
    {
       let  alertViewCtrl:b4u_CancelOrderViewController = storyboard.instantiateViewControllerWithIdentifier("CancelOrderViewControllerID") as! b4u_CancelOrderViewController

        self.pressentAlertPopUP(alertViewCtrl)
    }
    else if btnTapped == "Track"{
    
      let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("TrackOrderViewControllerID") as! b4u_TrackOrderViewController
        
        alertViewCtrl.selectedOrder = selectedOrderObj
        self.pressentAlertPopUP(alertViewCtrl)

    }
    else if btnTapped == "Reschedule"{
      
        let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("RescheduleOrderViewControllerID") as! b4u_RescheduleOrderViewController
        
        alertViewCtrl.selectedOrder = selectedOrderObj
        alertViewCtrl.delegate = self
        self.pressentAlertPopUP(alertViewCtrl)

    }
    else if btnTapped == "RaiseIssue"{
        
        let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("b4uRasiseIssueController") as! b4u_RasiseIssueController
//        
//        alertViewCtrl.selectedOrder = selectedOrderObj
//        alertViewCtrl.delegate = self
        self.pressentAlertPopUP(alertViewCtrl)
        
    }
    else if btnTapped == "PayOnline"{
      
      let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("PayOnlineOrderViewControllerID") as! b4u_PayOnlineOrderViewController
        self.pressentAlertPopUP(alertViewCtrl)

    }
    
  }
    
    func pressentAlertPopUP(alertViewCtrl:UIViewController?)
    {
        self.view.alpha = 0.5
        
        
        alertViewCtrl!.modalPresentationStyle = .Popover
        alertViewCtrl!.preferredContentSize = CGSizeMake(300, 250)
        
        let popoverMenuViewController = alertViewCtrl!.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.frame),
            y: CGRectGetMidY(self.view.bounds),
            width: 1,
            height: 1)
        presentViewController(
            alertViewCtrl!,
            animated: true,
            completion: nil)
    }

    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    //MARKS: OrderReshedule Delegates
    func updateOreder(order:b4u_OrdersModel ,selectedData:String? ,selectedTimeSlot:String?)
    {
        self.view.alpha = 1.0

        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        let params = "?order_id=\(order.orderID!) &user_id=\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)&date=\(selectedData!)&service_time=\(selectedTimeSlot!)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReScheduleOrderApi, params:params!, result:{(resultObject) -> Void in
            
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            
        })
    }
    func didCloseReshedule()
    {
        self.view.alpha = 1.0
    }
    
    @IBAction func okButtonClicked(sender: AnyObject)
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.performSegueWithIdentifier("orderloginSegue", sender:nil)
        })
    }
 
    func loginDismissed()
    {
        self.validateUser()
    }
}
