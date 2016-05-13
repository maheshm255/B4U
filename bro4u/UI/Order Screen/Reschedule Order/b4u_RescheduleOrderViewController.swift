//
//  b4u_RescheduleOrderViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 22/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

protocol orderResheduleDelegate: NSObjectProtocol
{
    func updateOreder(order:b4u_OrdersModel ,selectedData:String? ,selectedTimeSlot:String?)
     func didCloseReshedule()
}

class b4u_RescheduleOrderViewController: UIViewController,
     UIPopoverPresentationControllerDelegate,calendarDelegate ,timeSlotDelegate{

    @IBOutlet weak var btnSelectTime: UIButton!
    @IBOutlet weak var btnSelectDate: UIButton!
    
    @IBOutlet weak var updateBtnClicked: UIButton!

    var delegate:orderResheduleDelegate?
    
    var selectedOrder:b4u_OrdersModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addLoadingIndicator()

        btnSelectDate.layer.cornerRadius = 5
        btnSelectDate.layer.borderColor = UIColor.grayColor().CGColor
        btnSelectDate.layer.borderWidth = 1
        
        
        btnSelectTime.layer.cornerRadius = 5
        btnSelectTime.layer.borderColor = UIColor.grayColor().CGColor
        btnSelectTime.layer.borderWidth = 1
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
    @IBAction func selectTime(sender: AnyObject)
    {
        
        if  bro4u_DataManager.sharedInstance.timeSlots?.timeSlots?.count > 0
        {
            let btn = sender as! UIButton
            
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
                y: CGRectGetMidY(btn.bounds),
                width: 1,
                height: 1)
            presentViewController(
                timeSlotController,
                animated: true,
                completion: nil)
            
        }

    }
    
    
    @IBAction func btnCloseClicked(sender: AnyObject) {
        
        delegate?.didCloseReshedule()
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func selectDate(sender: AnyObject) {
        
      //  self.dateBtn = btn
        let storyboard : UIStoryboard = self.storyboard!
        
        let calendarController:b4u_CalendarViewCtrl = storyboard.instantiateViewControllerWithIdentifier("b4uCalendarViewCtrl") as! b4u_CalendarViewCtrl
        
        calendarController.modalPresentationStyle = .Popover
        calendarController.preferredContentSize = CGSizeMake(300, 400)
        calendarController.delegate = self
        
        let popoverMenuViewController = calendarController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.frame),
            y: CGRectGetMidY(self.view.frame),
            width: 1,
            height: 1)
        presentViewController(
            calendarController,
            animated: true,
            completion: nil)

    }
    
    @IBAction func updateBtnClicked(sender: AnyObject)
    {
      
      guard let selectedDate = self.btnSelectDate.titleLabel?.text where  selectedDate != "Select Date" else
      {
        self.view.makeToast(message:"Please Select Date", duration:1.0, position: HRToastPositionDefault)
        return
      }
      
      guard let selectedTime = self.btnSelectTime.titleLabel?.text where selectedTime != "Select Time" else
      {
        self.view.makeToast(message:"Please Select Time", duration:1.0, position: HRToastPositionDefault)
        return
      }

      
        delegate?.updateOreder(selectedOrder!, selectedData:self.btnSelectDate.titleLabel?.text, selectedTimeSlot:self.btnSelectTime.titleLabel?.text)
        
        self.dismissViewControllerAnimated(true, completion:nil)

    }
    
    

    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    func didSelectDate(date:NSDate)
    {
        
        let dateFormat = NSDate.dateFormat() as NSDateFormatter
        let currentDate =  dateFormat.stringFromDate(date)
        
        self.btnSelectDate!.setTitle(currentDate, forState:UIControlState.Normal)
        
        self.callTimeSlotApi(currentDate)
        
        if let tiemBtn = self.btnSelectTime
        {
            tiemBtn.setTitle("Select Time", forState:UIControlState.Normal)
        }
    }

    
    func callTimeSlotApi(selectedDateStr:String)
    {
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        let params = "?date=\(selectedDateStr)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kTimeSlotApi, params:params, result:{(resultObject) -> Void in
            
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
        })
    }
    
    func didSelectTimeSlot(tiemSlot:String)
    {
        self.btnSelectTime!.setTitle(tiemSlot, forState:UIControlState.Normal)

    }
    

    @IBAction func callB4uBtnAction(sender: AnyObject) {
        
        b4u_Utility.callAt(b4uNumber)
    }
    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
}
