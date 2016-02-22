//
//  b4u-CatFilterAttributes.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CatFilterAttributes: NSObject {

    
    var adminInputType:String?
    var attrDesc:String?
    var attrDetails:String?
    var attrId:String?
    var attrName:String?
    var catId:String?
    var fieldName:String?

    var iconName:String?
    var inputType:String?
    var isOption:String?
    var required:String?
    var shopDropDown:String?
    var sortOrder:String?
    var status:String?
    var tags:String?
    var timestamp:NSDate?
    var unitName:String?
    var useAs:String?
    var catFilterAttributeOptions:[b4u_CatFilterAttributeOptions]?
    
    init(catFilterAttribuesDataDict:Dictionary<String ,AnyObject>) {
        
        self.catFilterAttributeOptions = Array()

        adminInputType = catFilterAttribuesDataDict["admin_input_type"] as? String
        attrDesc = catFilterAttribuesDataDict["attr_desc"] as? String
        attrDetails = catFilterAttribuesDataDict["attr_details"] as? String
        attrId = catFilterAttribuesDataDict["attr_id"] as? String
        attrName = catFilterAttribuesDataDict["attr_name"] as? String
        catId = catFilterAttribuesDataDict["cat_id"] as? String
        fieldName = catFilterAttribuesDataDict["field_name"] as? String

        iconName = catFilterAttribuesDataDict["icon_name"] as? String
        inputType = catFilterAttribuesDataDict["input_type"] as? String
        isOption = catFilterAttribuesDataDict["is_option"] as? String
        required = catFilterAttribuesDataDict["required"] as? String
        shopDropDown = catFilterAttribuesDataDict["show_dropdown"] as? String
        sortOrder = catFilterAttribuesDataDict["sort_order"] as? String
        status = catFilterAttribuesDataDict["status"] as? String
        tags = catFilterAttribuesDataDict["tags"] as? String
       // timestamp = catFilterAttribuesDataDict["timestamp"] as? NSDate
        unitName = catFilterAttribuesDataDict["unit_name"] as? String
        useAs = catFilterAttribuesDataDict["use_as"] as? String
      
        let optionsArray = catFilterAttribuesDataDict["options"] as! [Dictionary<String , AnyObject>]
        
        for (_, dataDict) in optionsArray.enumerate()
        {
            let optionsDataModel = b4u_CatFilterAttributeOptions(optionsDataDict:dataDict)
            self.catFilterAttributeOptions?.append(optionsDataModel)
        }
        

    }
    
}
