//
//  b4u-VendorReviews.swift
//  bro4u
//
//  Created by Mac on 03/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_VendorReviews: NSObject {

    
    var rating:String?
    var reviewTitle:String?
    var reivew:String?
    var fullName:String?
    var timeStamp:String?
    
    init(reviewDataDict:Dictionary<String ,AnyObject>)
    {
        
        rating = reviewDataDict["rating"] as? String
        reviewTitle = reviewDataDict["review_title"] as? String
        reivew = reviewDataDict["review"] as? String
        fullName = reviewDataDict["full_name"] as? String
        timeStamp = reviewDataDict["timestamp"] as? String
    }
}
