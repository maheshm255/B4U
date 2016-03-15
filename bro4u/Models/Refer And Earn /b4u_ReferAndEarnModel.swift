//
//  b4u_ReferAndEarnModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ReferAndEarnModel: NSObject {

  var referralAmount:String?
  var offerAmount:String?
  var referralSettingID:String?
  var referralCode:String?
  var totalEarned:NSNumber?
  var terms1:String?
  var terms2:String?
  
  
  init(dataDict:Dictionary<String ,AnyObject>) {
    
    referralAmount = dataDict["referral_amount"] as? String
    offerAmount = dataDict["offer_amount"] as? String
    referralSettingID = dataDict["referral_setting_id"] as? String
    referralCode = dataDict["referral_code"] as? String
    totalEarned = dataDict["total_earned"] as? NSNumber
    terms1 = dataDict["terms_1"] as? String
    terms2 = dataDict["terms_2"] as? String
    
  }

}
