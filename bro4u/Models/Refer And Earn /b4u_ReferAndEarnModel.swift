//
//  b4u_ReferAndEarnModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ReferAndEarnModel: NSObject {

  var referralAmount:NSNumber?
  var offerAmount:NSNumber?
  var referralSettingID:NSNumber?
  var referralCode:NSNumber?
  var totalEarned:NSNumber?
  var terms1:String?
  var terms2:String?
  
  
  init(categoryDataDict:Dictionary<String ,AnyObject>) {
    
    referralAmount = categoryDataDict["referral_amount"] as? NSNumber
    offerAmount = categoryDataDict["offer_amount"] as? NSNumber
    referralSettingID = categoryDataDict["referral_setting_id"] as? NSNumber
    referralCode = categoryDataDict["referral_code"] as? NSNumber
    totalEarned = categoryDataDict["total_earned"] as? NSNumber
    terms1 = categoryDataDict["terms_1"] as? String
    terms2 = categoryDataDict["terms_2"] as? String
    
  }

}
