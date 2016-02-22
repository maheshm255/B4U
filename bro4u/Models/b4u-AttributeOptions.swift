//
//  b4u-AttributeOptions.swift
//  bro4u
//
//  Created by Tools Team India on 19/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_AttributeOptions: NSObject {

    var catId:String?
    var attributeId:String?
    var fieldName:String?
    var inputType:String?
    var optionId:String?
    var optionName:String?
    
    init(attreibuteOptionsDataDict:Dictionary<String ,AnyObject>) {
        
        catId = attreibuteOptionsDataDict["cat_id"] as? String
        attributeId = attreibuteOptionsDataDict["attribute_id"] as? String
        fieldName = attreibuteOptionsDataDict["field_name"] as? String
        optionId = attreibuteOptionsDataDict["option_id"] as? String
        optionName = attreibuteOptionsDataDict["option_name"] as? String
        
    }

}
