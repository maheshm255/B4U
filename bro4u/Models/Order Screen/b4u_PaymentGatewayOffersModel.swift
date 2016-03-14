//
//  b4u_PaymentGatewayOffersModel.swift
//  bro4u
//
//  Created by Rahul on 13/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_PaymentGatewayOffersModel: NSObject {
    
    var offerFor:String?
    var offerMsg:String?
    
    
    init(dataDict:Dictionary<String ,AnyObject>) {
        
        offerFor = dataDict["offer_for"] as? String
        offerMsg = dataDict["offer_msg"] as? String
     }


}
