//
//  b4u_CalendarViewCtrl.swift
//  bro4u
//
//  Created by Mac on 05/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

protocol calendarDelegate{
    
    func didSelectDate(date:NSDate)

}

class b4u_CalendarViewCtrl: UIViewController ,FSCalendarDataSource , FSCalendarDelegate{
    
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblNumberDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var fsCalendar: FSCalendar!
    
    var delegate:calendarDelegate?

    var selectedDate:NSDate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        FSCalendar.appearance().setWeekdayTextColor(UIColor.redColor())
        FSCalendar.appearance().setHeaderTitleColor(UIColor.darkGrayColor())
        FSCalendar.appearance().setSelectionColor(UIColor.blackColor())
        
        fsCalendar.delegate = self
        fsCalendar.dataSource = self
        
        fsCalendar.flow = .Horizontal
        FSCalendar.appearance().setHeaderDateFormat("MMM-yyyy")
        
        //  FSCalendar.appearance().set
        
        // [[FSCalendar appearance] setMinDissolvedAlpha:0.5];
        // [[FSCalendar appearance] setTodayColor:[UIColor redColor]];
        //  [[FSCalendar appearance] setUnitStyle:FSCalendarUnitStyleCircle];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        
        NSDate()
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let components = calendar.components([.Month, .Day , .Year , .Weekday], fromDate: date)
        
        lblDay.text =  self.getWeekDay(components.weekday)
        
        lblNumberDay.text = "\(components.day)"
        lblMonth.text = self.getMonth(components.month)
        lblYear.text = "\(components.year)"
        
        self.selectedDate = date
        
    }
    
    
    func getWeekDay(weekDay:Int)->String
    {
        switch weekDay
        {
        case 1 :
            return "Sunday"
        case 2 :
            return "Monday"
        case 3 :
            return "Tuesday"
        case 4 :
            return "Wednesday"
        case 5 :
            return "Thursday"
        case 6 :
            return "Friday"
        case 7 :
            return "Saturday"
            
            
        default :
            return ""
        }
    }
    
    
    func getMonth(month:Int)->String
    {
        switch month
        {
        case 1 :
            return "JAN"
        case 2 :
            return "FEB"
        case 3 :
            return "MAR"
        case 4 :
            return "APR"
        case 5 :
            return "MAY"
        case 6 :
            return "JUN"
        case 7 :
            return "JUL"
        case 8 :
            return "AUG"
        case 9 :
            return "SEP"
        case 10 :
            return "OCT"
        case 11 :
            return "NOV"
        case 12 :
            return "DEC"
        default :
            return ""
        }
    }
    
    @IBAction func okBtnClicked(sender: AnyObject)
    {
        if let date = self.selectedDate
        {
            bro4u_DataManager.sharedInstance.selectedDate = date
            
            delegate?.didSelectDate(date)
        }
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    @IBAction func cancelBtnClicked(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion:nil)

    }
}

