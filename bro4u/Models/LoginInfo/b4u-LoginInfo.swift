//
//  b4u-LoginInfo.swift
//  bro4u
//
//  Created by Mac on 14/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_LoginInfo: NSObject {

    
    var address:String?
    var cityId:String?
    var email:String?
    var fullName:String?
    var landLine:String?

    var mobile:String?
    var otp:String?
    var profilePic:String?
    var status:String?
    var userId:String?

    var loginType:String?
    var googleAuthToken:String?
    override init() {
        
    }
     init(loginInfoDataDict:Dictionary<String , AnyObject>)
    {
        address = loginInfoDataDict["address"] as? String
        cityId = loginInfoDataDict["city_id"] as? String
        email = loginInfoDataDict["email"] as? String
        fullName = loginInfoDataDict["landline"] as? String
        landLine = loginInfoDataDict["full_name"] as? String
        mobile = loginInfoDataDict["mobile"] as? String
        otp = loginInfoDataDict["otp"] as? String
        profilePic = loginInfoDataDict["profile_pic"] as? String
        status = loginInfoDataDict["status"] as? String
        userId = loginInfoDataDict["user_id"] as? String

    }
}
