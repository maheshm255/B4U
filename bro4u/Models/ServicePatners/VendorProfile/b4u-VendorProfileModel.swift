//
//  b4u-VendorProfileModel.swift
//  bro4u
//
//  Created by Mac on 03/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_VendorProfileModel: NSObject {
    
    
    
    var completedJob:String?
    var onTime:String?
    var serviceQuality:String?
    var reviewCount:String?
    var reviews:[b4u_VendorReviews]?
    var aboutVendor:String?
    var averageRating:String?
    var averageRatingPercent:String?
    var defaultBanner:String?
    var profilePic:String?
    var vendorName:String?
    var catName:String?

    var workingFromDay:String?
    var workingToDay:String?
    
    var workingFromFromat:String?
    var workingfromHours:String?
    var workingToFormat:String?
    var workingToHours:String?
    
    var inBusiness:String?
    var profileViews:String?
    
    init(vendorDataDict:Dictionary<String ,AnyObject>)
    {
        
        completedJob = vendorDataDict["completed_jobs"] as? String
        onTime = vendorDataDict["on_time"] as? String
        serviceQuality = vendorDataDict["service_quality"] as? String
        reviewCount = vendorDataDict["reviewcount"] as? String
        
        
        self.reviews = Array()
        
        if let reviewsDataArray:[Dictionary<String ,AnyObject>] = vendorDataDict["reviews"] as? [Dictionary<String ,AnyObject>]
        {
            for (_ ,dataDict) in reviewsDataArray.enumerate()
            {
                let reiveModel = b4u_VendorReviews(reviewDataDict: dataDict)
                
                self.reviews?.append(reiveModel)
            }
        }
        
        if let vendorDataArray:[Dictionary<String ,AnyObject>] = vendorDataDict["vendordata"] as? [Dictionary<String ,AnyObject>]
        {
            
            let vendorDetaisDataDict = vendorDataArray.first
            
            aboutVendor = vendorDetaisDataDict!["about_vendor"] as? String
            averageRating = vendorDetaisDataDict!["average_rating"] as? String
            averageRatingPercent = vendorDetaisDataDict!["average_rating_percent"] as? String
            defaultBanner = vendorDetaisDataDict!["default_banner"] as? String
            profilePic = vendorDetaisDataDict!["profile_pic"] as? String
            
            catName = vendorDetaisDataDict!["cat_name"] as? String

            
            vendorName = vendorDetaisDataDict!["vendor_name"] as? String
            
            inBusiness = vendorDetaisDataDict!["in_business"] as? String

            profileViews = vendorDetaisDataDict!["views"] as? String


            if  let workingDaysArray:[Dictionary<String , AnyObject>] = vendorDetaisDataDict!["working_days"] as? [Dictionary<String , AnyObject>]
            {
                let  workingDaysDict = workingDaysArray.first
                workingFromDay = workingDaysDict!["from_day"] as? String
                workingToDay = workingDaysDict!["to_day"] as? String
                
            }
            
            if let workingHoursArray:[Dictionary<String , AnyObject>] = vendorDetaisDataDict!["working_hours"] as?
                [Dictionary<String , AnyObject>]
            {
                let  workingHoursDict = workingHoursArray.first

                workingFromFromat = workingHoursDict!["from_format"] as? String
                workingfromHours = workingHoursDict!["from_hour"] as? String
                workingToFormat = workingHoursDict!["to_format"] as? String
                workingToHours = workingHoursDict!["to_hour"] as? String
            }
        }
    }
}

