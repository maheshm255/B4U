//
//  b4u_OnlineOrderModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OnlineOrderModel: NSObject {

  
  var status:String?
  var txnid:String?
  var surl:String?
  var furl:String?
  var orderId:NSNumber?
  
  
  init(dataDict:Dictionary<String ,AnyObject>) {
    
    status = dataDict["status"] as? String
    txnid = dataDict["txnid"] as? String
    surl = dataDict["surl"] as? String
    furl = dataDict["furl"] as? String
    orderId = dataDict["order_id"] as? NSNumber
  }

}
