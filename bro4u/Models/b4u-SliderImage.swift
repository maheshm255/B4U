//
//  b4u-SliderImage.swift
//  bro4u
//
//  Created by Tools Team India on 15/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_SliderImage: NSObject {

    
    var active:String?
    var bannerId:String?
    var bannerTitle:String?
    var catId:String?
    var expiryDate:NSDate?
    var expiryDateTime:NSDate?
    var imageName:String?
    var link:String?
    var optionId:String?
    var sort:String?
    var startDateTime:NSDate?
    var timestamp:NSDate?
    var deviceType:String?

    
    init(sliderImageInfoDataDict:Dictionary<String ,AnyObject>) {
        
        active = sliderImageInfoDataDict["active"] as? String
        bannerId = sliderImageInfoDataDict["banner_id"] as? String
        bannerTitle = sliderImageInfoDataDict["banner_title"] as? String
        catId = sliderImageInfoDataDict["cat_id"] as? String
      //  expiryDate = sliderImageInfoDataDict["expiry_date"] as? String
        //expiryDateTime = sliderImageInfoDataDict["expiry_date_time"] as? NSNumber
        imageName = sliderImageInfoDataDict["image_name"] as? String
        link = sliderImageInfoDataDict["link"] as? String
        optionId = sliderImageInfoDataDict["option_id"] as? String
        sort = sliderImageInfoDataDict["sort"] as? String
      //  startDateTime = sliderImageInfoDataDict["start_date_time"] as? NSNumber
      //  timestamp = sliderImageInfoDataDict["timestamp"] as? NSNumber
        deviceType = sliderImageInfoDataDict["for"] as? String

        
    }
}
