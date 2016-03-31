//
//  b4u_MyWalletModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_MyWalletModel: NSObject {

  var activityID:NSNumber?
  var userID:NSNumber?
  var amount:String?
  var activityType:String?
  var comments:String?
  var timestamp:String?
  
  
  init(dataDict:Dictionary<String ,AnyObject>) {
    
    activityID = dataDict["activity_id"] as? NSNumber
    userID = dataDict["user_id"] as? NSNumber
    amount = dataDict["amount"] as? String
    activityType = dataDict["activity_type"] as? String
    comments = dataDict["comments"] as? String
    timestamp = dataDict["timestamp"] as? String
  }

}
