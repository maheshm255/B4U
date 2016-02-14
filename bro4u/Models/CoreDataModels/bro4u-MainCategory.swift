//
//  bro4u-MainCategory.swift
//  bro4u
//
//  Created by Tools Team India on 13/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class bro4u_MainCategory: NSObject {
    
    
    var banner:String?
    var catIcon:String?
    var interBanner:String?
    var mainCatDesc:String?
    var manCatName:String?
    var manCatId:NSNumber?
    var sortOrder:NSNumber?
    var timeStamp:NSDate?

    
    init(categoryDataDict:Dictionary<String ,AnyObject>) {
        
        banner = categoryDataDict["banner"] as? String
        catIcon = categoryDataDict["cat_icon"] as? String
        interBanner = categoryDataDict["inter_banner"] as? String
        mainCatDesc = categoryDataDict["main_cat_desc"] as? String
        manCatName = categoryDataDict["main_cat_name"] as? String
        manCatId = categoryDataDict["main_cat_id"] as? NSNumber
        sortOrder = categoryDataDict["sort_order"] as? NSNumber

    }
}
