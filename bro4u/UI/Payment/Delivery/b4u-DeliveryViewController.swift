//
//  b4u-DeliveryViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit


protocol deliveryViewDelegate
{
    func proceedToPayment()
}
class b4u_DeliveryViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,calendarDelegate,timeSlotDelegate ,UIPopoverPresentationControllerDelegate ,UITextViewDelegate{

    
    @IBOutlet weak var tableView: UITableView!
    var dateBtn:UIButton?
    var timeBtn:UIButton?
    var dateAndTimeSelectImgView:UIImageView?
    var textViewComment: UITextView!

    
    var currentSelectedAddress:b4u_AddressDetails?
    
    var comments:String?
    
    var delegate:deliveryViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func  viewWillAppear(animated: Bool) {
     super.viewWillAppear(animated)
        self.tableView.reloadData()

    }

    
    
    func getData()
    {
        
        let userId = "1"
        let params = "?user_id=\(userId)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kGetAddress, params:params, result:{(resultObject) -> Void in
            
            print("address Received")
       
            
            self.tableView.reloadData()
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        switch indexPath.section
        {
        case 0 :
            let cellIdentifier = "dateAndTimeCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_DateAndTImeSelectionTblCell
            
            self.dateBtn = cell.btnSelectDate
            self.timeBtn = cell.btnSelectTime
            self.dateAndTimeSelectImgView = cell.imgViewSelection
            dateAndTimeSelectImgView?.image = UIImage(named:"shareGreen")

            if let selectedDate = bro4u_DataManager.sharedInstance.selectedDate
            {
               cell.btnSelectDate.setTitle(NSDate.dateFormat().stringFromDate(selectedDate), forState:UIControlState.Normal)
            }
            
            cell.btnSelectDate.addTarget(self, action:"selectDate:", forControlEvents:UIControlEvents.TouchUpInside)
            
            
            if let selectedTimeSlot = bro4u_DataManager.sharedInstance.selectedTimeSlot
            {
                cell.btnSelectTime.setTitle(selectedTimeSlot, forState:UIControlState.Normal)
            }
            
            cell.btnSelectTime.addTarget(self, action:"selectTimeSlot:", forControlEvents:UIControlEvents.TouchUpInside)
            
            
            return cell
        case 1:
            let cellIdentifier = "addressCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_AddressTblCell
            
            cell.addAddressBtn.addTarget(self, action:"btnAddAddressSelected", forControlEvents:UIControlEvents.TouchUpInside)
            
            let address1Gesture = UITapGestureRecognizer(target:self, action:"address1Selected")
            address1Gesture.numberOfTapsRequired = 1
            cell.viewAddress1.addGestureRecognizer(address1Gesture)
        
            let address2Gesture = UITapGestureRecognizer(target:self, action:"address2Selected")
            address2Gesture.numberOfTapsRequired = 1
            cell.viewAddress2.addGestureRecognizer(address2Gesture)
            
            
            
            if bro4u_DataManager.sharedInstance.address.count > 0
            {
                cell.imgViewSelect?.image = UIImage(named:"shareGreen")

                 if bro4u_DataManager.sharedInstance.address.count == 2
                 {
                    
                    let addressDetailsModel:b4u_AddressDetails = bro4u_DataManager.sharedInstance.address[1]
                    cell.viewAddress2.hidden = false
                    
                    cell.lblAddress2.text = addressDetailsModel.fullAddress!
                    
                    cell.addAddressBtn.enabled = false
                    
                    cell.btnDeleteAddress2.addTarget(self, action:"deleteAddress2", forControlEvents:.TouchUpInside)
                    
                    cell.viewAddress1.hidden = false
                    let addressDetailsModel1:b4u_AddressDetails = bro4u_DataManager.sharedInstance.address[0]
                    cell.lblAddress1.text = addressDetailsModel1.fullAddress!
                    
                    cell.btnDeleteAddress1.addTarget(self, action:"deleteAddress1", forControlEvents:.TouchUpInside)
                    
                    if self.currentSelectedAddress == addressDetailsModel
                    {
                        cell.imgViewSelecteAddress2.image = UIImage(named:"radioBlue")
                        cell.imgViewSelectAddress1.image = UIImage(named:"radioGray")

                    }else if self.currentSelectedAddress == addressDetailsModel1
                    {
                        cell.imgViewSelecteAddress2.image = UIImage(named:"radioGray")
                        cell.imgViewSelectAddress1.image = UIImage(named:"radioBlue")
                    }
                    
                 }else
                 {
                    cell.viewAddress1.hidden = false
                    cell.viewAddress2.hidden = true
                    let addressDetailsModel:b4u_AddressDetails = bro4u_DataManager.sharedInstance.address[0]
                    cell.lblAddress1.text = addressDetailsModel.fullAddress!
                    
                    cell.btnDeleteAddress1.addTarget(self, action:"deleteAddress1", forControlEvents:.TouchUpInside)
                    
                    cell.addAddressBtn.enabled = true
                    
                    self.currentSelectedAddress = addressDetailsModel
                    
                    cell.imgViewSelectAddress1.image = UIImage(named:"radioBlue")
                    

                    //radioGray
                }

            }else
            {
                cell.viewAddress1.hidden = true
                cell.viewAddress2.hidden = true
                cell.addAddressBtn.enabled = true
                
                cell.imgViewSelect?.image = UIImage(named:"shareGray")


            }
            return cell
            
        case 2 :
            let cellIdentifier = "commentsCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_CommentTableViewCell
            
           //  self.textViewComment = cell.textViewComment
            
              cell.textViewComment.delegate = self
            
         
           
            return cell
            
        default:
            
            let cellIdentifier = "commentsCell"

            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
            
            return cell
        }

        
    }
    
  
    
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch indexPath.section
        {
        case 0 :
            return 90.0

        case 1:
            return 150.0

            
        case 2 :
            return 100.0

            
        default:
            return 0.0
        }
    }
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        
    }
    
    
    func address1Selected()
    {
        //let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:0, inSection:1))
        
        self.currentSelectedAddress = bro4u_DataManager.sharedInstance.address[0]
        
        self.tableView.reloadData()
    }
   
    func address2Selected()
    {
        self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:0, inSection:1))
        
        self.currentSelectedAddress = bro4u_DataManager.sharedInstance.address[1]
        self.tableView.reloadData()

    }
    
    func deleteAddress2()
    {
        bro4u_DataManager.sharedInstance.address.removeAtIndex(1)
        self.tableView.reloadData()
    }
    func deleteAddress1()
    {
        bro4u_DataManager.sharedInstance.address.removeAtIndex(0)
        self.tableView.reloadData()

    }
    func selectDate(sender: AnyObject)
    {
        
        let btn = sender as! UIButton
        self.dateBtn = btn
        let storyboard : UIStoryboard = self.storyboard!
        
        let calendarController:b4u_CalendarViewCtrl = storyboard.instantiateViewControllerWithIdentifier("b4uCalendarViewCtrl") as! b4u_CalendarViewCtrl
        
        calendarController.modalPresentationStyle = .Popover
        calendarController.preferredContentSize = CGSizeMake(300, 400)
        calendarController.delegate = self
        
        let popoverMenuViewController = calendarController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Up
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = sender as? UIView
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(btn.frame),
            y: CGRectGetMidY(btn.frame),
            width: 1,
            height: 1)
        presentViewController(
            calendarController,
            animated: true,
            completion: nil)
    }
    func selectTimeSlot(sender: AnyObject)
    {
        if  bro4u_DataManager.sharedInstance.timeSlots?.timeSlots?.count > 0
        {
            let btn = sender as! UIButton
            
            
            self.timeBtn = btn
            let storyboard : UIStoryboard = self.storyboard!
            
            //        UIStoryboard(name:"Main",bundle: nil)
            
            let timeSlotController:b4u_TimeSlotViewCtrl = storyboard.instantiateViewControllerWithIdentifier("b4uTimeSlotCtrl") as! b4u_TimeSlotViewCtrl
            
            timeSlotController.modalPresentationStyle = .Popover
            timeSlotController.preferredContentSize = CGSizeMake(150, 300)
            
            timeSlotController.delegate = self
            //  timeSlotController.delegate = self
            
            let popoverMenuViewController = timeSlotController.popoverPresentationController
            popoverMenuViewController?.permittedArrowDirections = .Up
            popoverMenuViewController?.delegate = self
            popoverMenuViewController?.sourceView = btn
            popoverMenuViewController?.sourceRect = CGRect(
                x: CGRectGetMidX(btn.bounds),
                y: CGRectGetMidY(btn.frame),
                width: 1,
                height: 1)
            presentViewController(
                timeSlotController,
                animated: true,
                completion: nil)
            
        }
        
        

    }
    @IBAction func proceedToPaymetnBtnClicked(sender: AnyObject)
    {
        self.delegate?.proceedToPayment()
    }
    
    
    func btnAddAddressSelected()
    {
        
    }
    
    
    //MARKS: Date selecteion delegate
    func didSelectDate(date:NSDate)
    {
        
        let dateFormat = NSDate.dateFormat() as NSDateFormatter
        
        let currentDate =  dateFormat.stringFromDate(date)
        
        self.dateBtn!.setTitle(currentDate, forState:UIControlState.Normal)
        
        self.callTimeSlotApi(currentDate)
        
        if let tiemBtn = self.timeBtn
        {
            tiemBtn.setTitle("Select Time", forState:UIControlState.Normal)
            dateAndTimeSelectImgView?.image = UIImage(named:"shareGray")
        }
    }
    
    //MARKS: timeSlot selecteion delegate
    func didSelectTimeSlot(tiemSlot:String)
    {
        self.timeBtn!.setTitle(tiemSlot, forState:UIControlState.Normal)
        
        dateAndTimeSelectImgView?.image = UIImage(named:"shareGreen")

    }
    
    func callTimeSlotApi(selectedDateStr:String)
    {
        let params = "?date=\(selectedDateStr)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kTimeSlotApi, params:params, result:{(resultObject) -> Void in
            
            
            
            
        })
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    
    // MARK:  UITextView delegages
    
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool
    {
        
        return true
    }
    func textViewShouldEndEditing(textView: UITextView) -> Bool
    {
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    func textViewDidEndEditing(textView: UITextView)
    {
        if textView.text.isEmpty {
            textView.text = "Special Comments"
            textView.textColor = UIColor.lightGrayColor()
        }
        textView.resignFirstResponder()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
     
            return true
    }
    
    func textViewDidChange(textView: UITextView)
    {
        
    }

}
