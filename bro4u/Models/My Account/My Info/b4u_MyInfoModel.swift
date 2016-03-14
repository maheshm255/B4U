//
//  b4u_MyInfoModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_MyInfoModel: NSObject {

  
  var userID:String?
  var fullName:String?
  var email:String?
  var mobile:String?
  var landline:String?
  var cityID:NSNumber?
  var profilePic:String?
  var walletBalance:NSNumber?
  var dob:String?
  var gender:String?

  
  init(dataDict:Dictionary<String ,AnyObject>) {
    
    userID = dataDict["user_id"] as? String
    fullName = dataDict["full_name"] as? String
    email = dataDict["email"] as? String
    mobile = dataDict["mobile"] as? String
    landline = dataDict["landline"] as? String
    cityID = dataDict["city_id"] as? NSNumber
    profilePic = dataDict["profile_pic"] as? String
    walletBalance = dataDict["wallet_balance"] as? NSNumber
    dob = dataDict["dob"] as? String
    gender = dataDict["gender"] as? String
  }

}
