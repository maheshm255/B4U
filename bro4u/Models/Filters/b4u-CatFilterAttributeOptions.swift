//
//  b4u-CatFilterAttributeOptions.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CatFilterAttributeOptions: NSObject {

    
    var attributeId:String?
    var defaultSelect:String?
    var display:String?
    var displayName:String?
    var intermediatory:String?
    var optionId:String?
    var optionName:String?
    var sortOrder:String?
    var status:String?
    var timeStamp:NSDate?
    
    
    init(optionsDataDict:Dictionary<String ,AnyObject>) {
        
        attributeId = optionsDataDict["attribute_id"] as? String
        defaultSelect = optionsDataDict["default_select"] as? String
        display = optionsDataDict["display"] as? String
        displayName = optionsDataDict["display_name"] as? String
        intermediatory = optionsDataDict["intermediatory"] as? String
        optionId = optionsDataDict["option_id"] as? String
        optionName = optionsDataDict["option_name"] as? String
        sortOrder = optionsDataDict["sort_order"] as? String
        status = optionsDataDict["status"] as? String
    //    timeStamp = optionsDataDict["timestamp"] as? NSDate
    }
}

