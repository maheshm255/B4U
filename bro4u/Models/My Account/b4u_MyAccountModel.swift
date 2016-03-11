//
//  b4u_MyAccountModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_MyAccountModel: NSObject {

    var userID:String?
    var fullName:String?
    var emailID:String?
    var mobileNumber:String?
    var profile_pic:String?
    var walletBalance:NSNumber?
    
    
    init(dataDict:Dictionary<String ,AnyObject>) {
        
        userID = dataDict["user_id"] as? String
        fullName = dataDict["full_name"] as? String
        emailID = dataDict["email"] as? String
        mobileNumber = dataDict["mobile"] as? String
        walletBalance = dataDict["wallet_balance"] as? NSNumber

    }

}
