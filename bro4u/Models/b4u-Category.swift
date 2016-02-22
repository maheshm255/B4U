//
//  b4u-Category.swift
//  bro4u
//
//  Created by Tools Team India on 19/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_Category: NSObject {

   
    var catDesc:String?
    var catIcon:String?
    var catId:String?
    var catName:String?
    var fieldName:String?
    var mainCatId:String?
    var optionId:String?
    var optionName:String?
    var sort_order:String?
    var showDropDown:String?
    var attributeOptins:[b4u_AttributeOptions]?
    
    init(categoryDataDict:Dictionary<String ,AnyObject>) {
        
        catDesc = categoryDataDict["cat_desc"] as? String
        catIcon = categoryDataDict["cat_icon"] as? String
        catId = categoryDataDict["cat_id"] as? String
        catName = categoryDataDict["cat_name"] as? String
        fieldName = categoryDataDict["field_name"] as? String
        mainCatId = categoryDataDict["main_cat_id"] as? String
        optionId = categoryDataDict["option_id"] as? String
        optionName = categoryDataDict["option_name"] as? String
        sort_order = categoryDataDict["sort_order"] as? String
        showDropDown = categoryDataDict["show_dropdown"] as? String
     
        attributeOptins = Array()
        
        let attributeOptions:[Dictionary<String ,AnyObject>] = categoryDataDict["attribute_options"] as! [Dictionary<String ,AnyObject>]
        
        for (_ ,attributeOptionsDataDict) in attributeOptions.enumerate()
        {
            let aAttributeOptionObj = b4u_AttributeOptions(attreibuteOptionsDataDict:attributeOptionsDataDict)
            
            attributeOptins?.append(aAttributeOptionObj)
            
        }
    }

}
