//
//  NSDateExtension.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//

extension NSDate{
    
    func addMinutes(minutesToAdd:Int)->NSDate{
        let secondsInDays : NSTimeInterval = Double(minutesToAdd) * 60
        let dateWithMinutesAdded : NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithMinutesAdded
    }
    
    
    
    func addHours(hoursToAdd:Int)->NSDate{
        let secondsInDays : NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded : NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithHoursAdded
    }
    
    
    
    func addDays(daysToAdd:Int)->NSDate{
        let secondsInDays : NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded : NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    
    
    
    func isLessThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    class func utcDateFormatter()-> NSDateFormatter
    {
        let utcDateFormater:NSDateFormatter = NSDateFormatter()
        utcDateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        utcDateFormater.timeZone = NSTimeZone(name: "UTC")
        return utcDateFormater
    }
    
    class func modifiedDateFormatter()-> NSDateFormatter
    {        
        let utcDateFormater:NSDateFormatter = NSDateFormatter()
        utcDateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        utcDateFormater.timeZone = NSTimeZone(name: "UTC")
        return utcDateFormater
    }
    
    class func casesModifiedDateFormatter()-> NSDateFormatter
    {
        let modifiedDateFormat:NSDateFormatter = NSDateFormatter()
        modifiedDateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZZZZ"
        modifiedDateFormat.timeZone = NSTimeZone(name: "UTC")
        
        return modifiedDateFormat
    }
    
    class func dateFormat()-> NSDateFormatter
    {
        let modifiedDateFormat:NSDateFormatter = NSDateFormatter()
        modifiedDateFormat.dateFormat = "dd-MM-yyyy"
      //  modifiedDateFormat.timeZone = NSTimeZone(name: "UTC")
        
        return modifiedDateFormat
    }
    
    class func getDateFromString(dateStr:String , usingFormater:NSDateFormatter)-> NSDate!
    {
        if let date:NSDate = usingFormater.dateFromString(dateStr)
        {
            return date
        }
        
        return nil
    }
    
}