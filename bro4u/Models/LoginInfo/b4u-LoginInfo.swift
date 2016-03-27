//
//  b4u-LoginInfo.swift
//  bro4u
//
//  Created by Mac on 14/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_LoginInfo: NSObject ,NSCoding{

    
    var address:String?
    var cityId:String?
    var email:String?
    var fullName:String?
    var landLine:String?
    var firstName:String?
    var lastName:String?

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
    
    //MARK: - NSCoding -
    required init(coder aDecoder: NSCoder) {
    
        address = aDecoder.decodeObjectForKey("address") as? String
        
        cityId = aDecoder.decodeObjectForKey("city_id") as? String
        email = aDecoder.decodeObjectForKey("email") as? String
        fullName = aDecoder.decodeObjectForKey("landline") as? String
        landLine = aDecoder.decodeObjectForKey("full_name") as? String
        mobile = aDecoder.decodeObjectForKey("mobile") as? String
        otp = aDecoder.decodeObjectForKey("otp") as? String
        profilePic = aDecoder.decodeObjectForKey("profile_pic") as? String
        status = aDecoder.decodeObjectForKey("status") as? String
        userId = aDecoder.decodeObjectForKey("user_id") as? String
        
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(address, forKey: "address")
        aCoder.encodeObject(cityId, forKey: "city_id")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(fullName, forKey: "landline")
        aCoder.encodeObject(landLine, forKey: "full_name")
        aCoder.encodeObject(mobile, forKey: "mobile")
        aCoder.encodeObject(otp, forKey: "otp")
        aCoder.encodeObject(profilePic, forKey: "profile_pic")
        aCoder.encodeObject(status, forKey: "status")
        aCoder.encodeObject(userId, forKey: "user_id")
    }
}
