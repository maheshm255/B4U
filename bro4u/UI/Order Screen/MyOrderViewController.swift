//
//  MyOrderViewController.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyOrderViewController: UIViewController,UIPopoverPresentationControllerDelegate ,orderResheduleDelegate ,orderRaiseIssueDelegate ,orderCancelDelegate{

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



// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
    
    
    if segue.identifier == "writeViewSegue"
    {
        let reviewCtrl = segue.destinationViewController as! b4u_ReviewServiceViewController
        
        reviewCtrl.selectedOrder = sender as? b4u_OrdersModel
        
        
    }
}


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
        cell.btnCallBro4u.tag = indexPath.row
        cell.btnPayOnline.tag = indexPath.row

        cell.configureData(self.onGoingOrderArray![indexPath.row])
  
        
        
      return cell
    }
    else{
        cellIdentifier = "PastOrdersTableViewCellID"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PastOrdersTableViewCell

        cell.btnRaiseIssue.tag = indexPath.row
        cell.btnWriteReview.tag = indexPath.row
        
        cell.configureData(self.pastOrdersArray![indexPath.row])

        return cell

    }
  }
  
  
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        if indexPath.section == 0
        {
            return 250;
        }
        else if indexPath.section == 1
        {
            return 186;
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
  
  
  
//  @IBAction func cancelBtnClicked(sender: AnyObject) {
//    self.dismissViewControllerAnimated(true, completion:nil)
//    
//
//  }

  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }
  
  @IBAction func cancelBtnAction(sender: AnyObject) {

    let selectedOrderObj: b4u_OrdersModel  =  self.onGoingOrderArray![sender.tag]
    self.showAlertView("Cancel", selectedOrderObj:selectedOrderObj)

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
    
    let orderDataModel: b4u_OrdersModel  =  self.onGoingOrderArray![sender.tag]

    if orderDataModel.statusCode == "OREQ" || orderDataModel.statusCode == "OTRNF" || orderDataModel.statusCode == "OVREJ"
    {
        b4u_Utility.callAt(b4uNumber)
    }
    
    if orderDataModel.statusCode == "OACC" || orderDataModel.statusCode == "OPRC" || orderDataModel.statusCode == "OACL"
    {
        b4u_Utility.callAt(orderDataModel.vendorMobile!)

       // vendor_mobile
        
    }
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
        
        alertViewCtrl.selectedOrder = selectedOrderObj
        alertViewCtrl.delegate = self

        self.pressentAlertPopUP(alertViewCtrl, size:CGSizeMake(300, 250))
    }
    else if btnTapped == "Track"{
    
      let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("TrackOrderViewControllerID") as! b4u_TrackOrderViewController
        
        alertViewCtrl.selectedOrder = selectedOrderObj
        self.pressentAlertPopUP(alertViewCtrl, size:CGSizeMake(300, 230))

    }
    else if btnTapped == "Reschedule"{
      
        let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("RescheduleOrderViewControllerID") as! b4u_RescheduleOrderViewController
        
        alertViewCtrl.selectedOrder = selectedOrderObj
        alertViewCtrl.delegate = self
        self.pressentAlertPopUP(alertViewCtrl, size:CGSizeMake(300, 190))

    }
    else if btnTapped == "RaiseIssue"{
        
        let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("b4uRasiseIssueController") as! b4u_RasiseIssueController
        
        alertViewCtrl.selectedOrder = selectedOrderObj
        alertViewCtrl.delegate = self
        self.pressentAlertPopUP(alertViewCtrl, size:CGSizeMake(300, 250))
        
    }
    else if btnTapped == "PayOnline"{
      
      let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("PayOnlineOrderViewControllerID") as! b4u_PayOnlineOrderViewController
        self.pressentAlertPopUP(alertViewCtrl, size: CGSizeMake(300, 250))

    }
    
  }
    
    func pressentAlertPopUP(alertViewCtrl:UIViewController? , size:CGSize)
    {
     //   self.view.alpha = 0.5
        
        
        alertViewCtrl!.modalPresentationStyle = .Popover
        alertViewCtrl!.preferredContentSize = size
        
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

        
        guard let selectedDate = selectedData else{
            return
        }
        
        guard let aSelectedTiemSlot = selectedTimeSlot else{
            return
        }
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        let params = "?order_id=\(order.orderID!) &user_id=\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)&date=\(selectedDate)&service_time=\(aSelectedTiemSlot)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReScheduleOrderApi, params:params, result:{(resultObject) -> Void in
            
            
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
    
    
    // Raise issue delegates
    
    func raiseIssue(order:b4u_OrdersModel , selectedIssue:String , reason:String)
    {
        
        //?order_id=29686&issue_type=no_response&message=jasdfl%20alskfj%20lskdf

        self.view.alpha = 1.0
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        let params = "?order_id=\(order.orderID!) &user_id=\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)&issue_type=\(orderRaiseIssueReasons[selectedIssue]!)&message=\(reason)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kOrderRaiseIssueApi, params:params, result:{(resultObject) -> Void in
            
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            
        })

    }
    func didCloseRaiseIssue()
    {
        self.view.alpha = 1.0
    }
    
    // Cancel Order Delegates
    func cancelOrder(order:b4u_OrdersModel , selectedIssue:String , reason:String)
    {
        //?order_id=29686&issue_type=no_response&message=jasdfl%20alskfj%20lskdf
        
        self.view.alpha = 1.0
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        let params = "?order_id=\(order.orderID!) &user_id=\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)&vendor_id=\(order.vendorID!)&issue_type=\(orderCancelReasons[selectedIssue]!)&cancel_message=\(reason)&cancel_reason=\(selectedIssue)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kCancelOrderIndex, params:params, result:{(resultObject) -> Void in
            
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            
        })
    }
    @IBAction func btnPastOrdersRaiseIssuePressed(sender: AnyObject)
    {
        let selectedOrderObj: b4u_OrdersModel  =  self.pastOrdersArray![sender.tag]
        self.showAlertView("RaiseIssue", selectedOrderObj:selectedOrderObj)

    }
    @IBAction func btnWriteReivewPressed(sender: AnyObject) {
        
        let selectedOrderObj: b4u_OrdersModel  =  self.pastOrdersArray![sender.tag]

        self.performSegueWithIdentifier("writeViewSegue", sender:selectedOrderObj)
    }
    func didCloseCancelIssue()
    {
        self.view.alpha = 1.0
 
    }
}
