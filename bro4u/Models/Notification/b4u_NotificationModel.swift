//
//  b4u_NotificationModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_NotificationModel: NSObject {

  var notifyDesc:String?
  var timestamp:String?
  
  
  init(dataDict:Dictionary<String ,AnyObject>) {
    
    notifyDesc = dataDict["notify_desc"] as? String
    timestamp = dataDict["timestamp"] as? String
    
  }

}
