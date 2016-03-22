//
//  MyOrderViewController.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyOrderViewController: UIViewController,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var orderTableView: UITableView!
  
    var onGoingOrderArray:[b4u_OrdersModel]?
    var pastOrdersArray:[b4u_OrdersModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
      self.addLoadingIndicator()

        self.getData()
        
    }
    
    func getData()
    {
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            var filedName = loginInfoData.userId! //Need to use later
            
        }
        
        let params = "?user_id=\(1)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyOrdersIndex , params:params, result:{(resultObject) -> Void in
            
            print(" Orders Data Received")
            
            print(resultObject)
            
            self.congigureUI()
            
        })
    }
    
    
    func congigureUI()
    {
        
        self.onGoingOrderArray = self.filterContent("Completed", orderType:orderTypes.kOnGoingOrders)

        self.pastOrdersArray = self.filterContent("Completed", orderType:orderTypes.kCompetedOrders)

     //   self.onGoingOrderArray = self.filterContent("Completed", scope:"")
        
        print(onGoingOrderArray)
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
                
                if let orderDesc = m.statusDesc
                    
                {
                    switch orderType
                    {
                    case .kOnGoingOrders:
                        return orderDesc.contains(searchText)
                    case .kCompetedOrders:
                        return !orderDesc.contains(searchText)

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
            return 285;
        }
        else if indexPath.section == 1
        {
            return 160;
        }
        
        return 0
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
    self.showAlertView("Cancel")

    
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
  
  @IBAction func trackBtnAction(sender: AnyObject) {
 
    self.showAlertView("Track")

  
  }
  
  
  @IBAction func rescheduledBtnAction(sender: AnyObject) {
  
    self.showAlertView("Reschedule")

  }
  
  
  @IBAction func callBro4uAction(sender: AnyObject) {
  }
  
  
  @IBAction func payOnlineAction(sender: AnyObject) {
  
    self.showAlertView("PayOnline")

  }
  

  func showAlertView(btnTapped: String)
  {
    let storyboard : UIStoryboard = self.storyboard!
    var alertViewCtrl:UIViewController  = UIViewController()
    
    if btnTapped == "Cancel"{
      alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("CancelOrderViewControllerID") as! b4u_CancelOrderViewController

    }
    else if btnTapped == "Track"{
    
      alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("TrackOrderViewControllerID") as! b4u_TrackOrderViewController

    }
    else if btnTapped == "Reschedule"{
      
      alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("RescheduleOrderViewControllerID") as! b4u_RescheduleOrderViewController
      
    }
    else if btnTapped == "PayOnline"{
      
      alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("PayOnlineOrderViewControllerID") as! b4u_PayOnlineOrderViewController
      
    }


    
    
    alertViewCtrl.modalPresentationStyle = .Popover
    alertViewCtrl.preferredContentSize = CGSizeMake(300, 250)
    // quickBookViewCtrl.delegate = self
    
    let popoverMenuViewController = alertViewCtrl.popoverPresentationController
    popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
    popoverMenuViewController?.delegate = self
    popoverMenuViewController?.sourceView = self.view
    popoverMenuViewController?.sourceRect = CGRect(
      x: CGRectGetMidX(self.view.frame),
      y: CGRectGetMidY(self.view.frame),
      width: 1,
      height: 1)
    presentViewController(
      alertViewCtrl,
      animated: true,
      completion: nil)
    
  }


}
