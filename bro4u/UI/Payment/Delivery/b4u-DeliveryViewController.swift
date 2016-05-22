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
    
    func kbUP(notification:NSNotification)
    func kbDown(notification:NSNotification)
}
class b4u_DeliveryViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,calendarDelegate,timeSlotDelegate ,UIPopoverPresentationControllerDelegate ,UITextViewDelegate{

    @IBOutlet weak var lblAmount: UILabel!
    
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
        
        
        
        if let selectedPartner = bro4u_DataManager.sharedInstance.selectedSuggestedPatner
        {
            
            if let quantity = bro4u_DataManager.sharedInstance.selectedQualtity
            {
                let price = Int(selectedPartner.offerPrice!)! * Int(quantity)!
                self.lblAmount.text = " Rs.\(price)"
                
            }else
            {
                self.lblAmount.text = "  Rs. \( selectedPartner.offerPrice!)  "
                
            }
            
        }else if let selectedReorderModel = bro4u_DataManager.sharedInstance.selectedReorderModel
       {
          //TODO - to check actual field
           self.lblAmount.text = "  Rs. \( selectedReorderModel.subTotal!)  "

        }
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keybShow:",
            name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keybHide:",
            name: UIKeyboardWillHideNotification, object: nil)
        
       self.addLoadingIndicator()

        self.getData()

    }

    
    func keybShow(notification: NSNotification) {
        print("kb show")
        
        self.delegate?.kbUP(notification)
    }
    
    
    func keybHide(notification: NSNotification) {
        print("kb hide")
        
        self.delegate?.kbDown(notification)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func  viewWillAppear(animated: Bool) {
     super.viewWillAppear(animated)
        
        self.getData()


    }

    
    
    func getData()
    {
        
        bro4u_DataManager.sharedInstance.address.removeAll()

      b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        var user_id = ""
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            user_id = loginInfoData.userId! //Need to use later
        }

//        let user_id = "1"
        let params = "?user_id=\(user_id)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kGetAddress, params:params, result:{(resultObject) -> Void in
            
            print("address Received")
       
            
            self.tableView.reloadData()
          b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

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
            
            
            cell.btnSelectDate.layer.cornerRadius = 2.0
            cell.btnSelectDate.layer.borderColor = UIColor(red:193.0/255, green:195.0/255, blue: 193.0/255, alpha:1.0).CGColor
            cell.btnSelectDate.layer.borderWidth = 1.0
            
            
            
            cell.btnSelectTime.layer.cornerRadius = 2.0
            cell.btnSelectTime.layer.borderColor = UIColor(red:193.0/255, green:195.0/255, blue: 193.0/255, alpha:1.0).CGColor
            
            cell.btnSelectTime.layer.borderWidth = 1.0
            
            
            b4u_Utility.shadowEffectToView(cell)

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

                 if bro4u_DataManager.sharedInstance.address.count >= 2
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
                    }else
                    {
                        cell.imgViewSelecteAddress2.image = UIImage(named:"radioGray")
                        cell.imgViewSelectAddress1.image = UIImage(named:"radioGray")
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
            
            b4u_Utility.shadowEffectToView(cell)
            return cell
            
        case 2 :
            let cellIdentifier = "commentsCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_CommentTableViewCell
            
           //  self.textViewComment = cell.textViewComment
            
              cell.textViewComment.delegate = self
            
         
            b4u_Utility.shadowEffectToView(cell)

            return cell
            
        default:
            
            let cellIdentifier = "commentsCell"

            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
            
            b4u_Utility.shadowEffectToView(cell)

            return cell
        }

        
    }
    
  
    
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch indexPath.section
        {
        case 0 :
            return 105.0

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
        self.deleteAddressApiCall(bro4u_DataManager.sharedInstance.address[1])

        
        bro4u_DataManager.sharedInstance.address.removeAtIndex(1)
        
        self.tableView.reloadData()
    }
    func deleteAddress1()
    {
        self.deleteAddressApiCall(bro4u_DataManager.sharedInstance.address[0])

        bro4u_DataManager.sharedInstance.address.removeAtIndex(0)
        self.tableView.reloadData()

    }
    
    func deleteAddressApiCall(address:b4u_AddressDetails)
    {
        
        var user_id = ""
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            user_id = loginInfoData.userId! //Need to use later
        }
        
        //        let user_id = "1"
        let params = "?user_id=\(user_id)&address_id=\(address.addressId!)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kDeleteAddress, params:params, result:{(resultObject) -> Void in
            
            print("address deleted")
            

        })
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
        popoverMenuViewController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.bounds),
            y: CGRectGetMidY(self.view.bounds),
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
            
            let height =  (bro4u_DataManager.sharedInstance.timeSlots?.timeSlots?.count)! * 44
            timeSlotController.preferredContentSize = CGSizeMake(150, CGFloat(height) )
            
            timeSlotController.delegate = self
            //  timeSlotController.delegate = self
            
            let popoverMenuViewController = timeSlotController.popoverPresentationController
            popoverMenuViewController?.permittedArrowDirections = .Up
            popoverMenuViewController?.delegate = self
            popoverMenuViewController?.sourceView = btn
            popoverMenuViewController?.sourceRect = CGRect(
                x: CGRectGetMidX(btn.bounds),
                y: CGRectGetMidY(btn.bounds),
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
        
    
        guard self.currentSelectedAddress != nil else {
            
            self.view.makeToast(message: "Please Select Address", duration:1.0, position: HRToastPositionDefault)
            return
        }
        
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
     
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
  
  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }

   

}
