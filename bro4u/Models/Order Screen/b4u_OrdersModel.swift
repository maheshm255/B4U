//
//  b4u_OrdersModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OrdersModel: NSObject {

  var banner:String?
  var catIcon:String?
  var interBanner:String?
  var mainCatDesc:String?
  var manCatName:String?
  var manCatId:String?
  var sortOrder:String?
  var timeStamp:NSDate?
  
  
  init(categoryDataDict:Dictionary<String ,AnyObject>) {
    
    banner = categoryDataDict["banner"] as? String
    catIcon = categoryDataDict["cat_icon"] as? String
    interBanner = categoryDataDict["inter_banner"] as? String
    mainCatDesc = categoryDataDict["main_cat_desc"] as? String
    manCatName = categoryDataDict["main_cat_name"] as? String
    manCatId = categoryDataDict["main_cat_id"] as? String
    sortOrder = categoryDataDict["sort_order"] as? String
    
  }

}
