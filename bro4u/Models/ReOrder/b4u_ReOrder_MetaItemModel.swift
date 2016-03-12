//
//  b4u_ReOrder_MetaItemModel.swift
//  bro4u
//
//  Created by Rahul on 12/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ReOrder_MetaItemModel: NSObject {

    
    var userID:String?
    var itemID:String?
    var vendorID:String?
    var unitQuantity:NSNumber?
    var homeFormat:NSNumber?
    var grandTotal:NSNumber?
    var platform:NSString?
    var subTotal:NSNumber?
    var deliveryCharge:NSNumber?
    var deductedFromWallet:NSNumber?
    var deductedUsingCoupon:NSNumber?
    var nightDeliveryCharge:NSNumber?

    
    init(dataDict:Dictionary<String ,AnyObject>) {
        
        userID = dataDict["user_id"] as? String
        itemID = dataDict["item_id"] as? String
        vendorID = dataDict["vendor_id"] as? String
        unitQuantity = dataDict["unit_quantity"] as? NSNumber
        homeFormat = dataDict["home_format"] as? NSNumber
        grandTotal = dataDict["grand_total"] as? NSNumber
        platform = dataDict["platform"] as? String
        subTotal = dataDict["sub_total"] as? NSNumber
        deliveryCharge = dataDict["delivery_charge"] as? NSNumber
        deductedFromWallet = dataDict["deducted_from_wallet"] as? NSNumber
        deductedUsingCoupon = dataDict["deducted_using_coupon"] as? NSNumber
        nightDeliveryCharge = dataDict["night_delivery_charge"] as? NSNumber
        
    }

}
