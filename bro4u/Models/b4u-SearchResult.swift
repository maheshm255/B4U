//
//  b4u-SearchResult.swift
//  bro4u
//
//  Created by Tools Team India on 15/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_SearchResult: NSObject {

    var attrId:String?
    var attrName:String?
    var catDesc:String?
    var catIcon:String?
    var catId:String?
    var catName:String?
    var fieldName:String?

    var mainCatId:String?
    var optionId:String?
    var optionName:String?
    var sort_order:String?
    
    
    init(searchResultDaraDict:Dictionary<String ,AnyObject>) {
        
        attrId = searchResultDaraDict["attr_id"] as? String
        attrName = searchResultDaraDict["attr_name"] as? String
        catDesc = searchResultDaraDict["cat_desc"] as? String
        catIcon = searchResultDaraDict["cat_icon"] as? String
        catId = searchResultDaraDict["cat_id"] as? String
        catName = searchResultDaraDict["cat_name"] as? String
        fieldName = searchResultDaraDict["field_name"] as? String
        mainCatId = searchResultDaraDict["main_cat_id"] as? String
        optionId = searchResultDaraDict["option_id"] as? String
        optionName = searchResultDaraDict["option_name"] as? String
        sort_order = searchResultDaraDict["sort_order"] as? String
        
    }

}
