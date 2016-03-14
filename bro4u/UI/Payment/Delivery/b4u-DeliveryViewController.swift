//
//  b4u-DeliveryViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_DeliveryViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,calendarDelegate,timeSlotDelegate ,UIPopoverPresentationControllerDelegate{

    
    var dateBtn:UIButton?
    var timeBtn:UIButton?
    var dateAndTimeSelectImgView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            return cell
            
        case 2 :
            let cellIdentifier = "commentsCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_CommentTableViewCell
            
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
            return 50.0

            
        default:
            return 0.0
        }
    }
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        
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
    @IBAction func proceedToPaymetnBtnClicked(sender: AnyObject) {
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
}
