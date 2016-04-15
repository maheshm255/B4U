//
//  b4u_SelectionModel.swift
//  bro4u
//
//  Created by MACBookPro on 4/1/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_SelectionModel: NSObject {

    var userId:String?
    var itemId:String?
    var vendorId:String?
    var unitQuantity:NSNumber?
    var cakeEggEggless:String?
    var cakeWeight:String?
    var unitPrice:NSNumber?
    var subTotal:NSNumber?
    var deliveryCharge:NSNumber?
    var nightCharge:NSNumber?
    var deductedFromWallet:NSNumber?
    var deductedUsingCoupon:NSNumber?
    var grandTotal:NSNumber?
    
    
    init(dataDict:Dictionary<String ,AnyObject>) {
        userId = dataDict["user_id"] as? String
        itemId = dataDict["item_id"] as? String
        vendorId = dataDict["vendor_id"] as? String
        unitQuantity = dataDict["unit_quantity"] as? NSNumber
        cakeEggEggless = dataDict["cake_egg_eggless"] as? String
        cakeWeight = dataDict["cake_weight"] as? String
        unitPrice = dataDict["unit_price"] as? NSNumber
        subTotal = dataDict["sub_total"] as? NSNumber
        deliveryCharge = dataDict["delivery_charge"] as? NSNumber
        nightCharge = dataDict["night_charge"] as? NSNumber
        deductedFromWallet = dataDict["deducted_from_wallet"] as? NSNumber
        deductedUsingCoupon = dataDict["deducted_using_coupon"] as? NSNumber
        grandTotal = dataDict["grand_total"] as? NSNumber
   }
}
