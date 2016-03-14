//
//  b4u_OfferZoneModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OfferZoneModel: NSObject {

  var couponCode:String?
  var header:String?
  var descriptionValue:String?
  var catID:String?
  var catName:String?
  var optionID:String?
  var fieldName:String?
  
  
  init(dataDict:Dictionary<String ,AnyObject>) {
    
    couponCode = dataDict["coupon_code"] as? String
    header = dataDict["header"] as? String
    descriptionValue = dataDict["description"] as? String
    catID = dataDict["cat_id"] as? String
    catName = dataDict["cat_name"] as? String
    optionID = dataDict["option_id"] as? String
    fieldName = dataDict["field_name"] as? String
  }

}
