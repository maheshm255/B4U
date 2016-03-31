//
//  b4u_OrderDetailModel.swift
//  bro4u
//
//  Created by MACBookPro on 4/1/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OrderDetailModel: NSObject {

    
    var offerInPercent:String?
    var paymentMethod:String?
    var advancePayment:String?
    var advancePercent:NSNumber?
    var itemType:String?
    var itemID:String?
    var catId:String?
    var itemName:String?
    var vendorName:String?
    var vendorId:String?
    var onlineOfferPercent:String?
    var catName:String?
    var selection:[b4u_SelectionModel]?
    
    var paymentGateWayes:[b4u_PaymentGatewayOffersModel]?
    
    init(dataDict:Dictionary<String ,AnyObject>) {
        
        
        offerInPercent = dataDict["offer_in_percent"] as? String
        paymentMethod = dataDict["payment_method"] as? String
        advancePayment = dataDict["advance_payment"] as? String
        advancePercent = dataDict["advance_percent"] as? NSNumber
        itemType = dataDict["item_type"] as? String
        itemID = dataDict["item_id"] as? String
        catId = dataDict["cat_id"] as? String
        itemName = dataDict["item_name"] as? String
        vendorName = dataDict["vendor_name"] as? String
        vendorId = dataDict["vendor_id"] as? String
        onlineOfferPercent = dataDict["online_offer_percent"] as? String
        catName = dataDict["cat_name"] as? String
        
        self.selection = Array()
        
        if let itemDataArray:[Dictionary<String ,AnyObject>] = dataDict["selection"] as? [Dictionary<String ,AnyObject>]
        {
            for (_ ,orderDetailDataDict) in itemDataArray.enumerate()
            {
                let selectionModel = b4u_SelectionModel(dataDict:orderDetailDataDict)
                self.selection?.append(selectionModel)
            }
            
        }
        
        self.paymentGateWayes = Array()
        
        if let parentArray2:[Dictionary<String ,AnyObject>] = dataDict["payment_gateway_offers"] as? [Dictionary<String ,AnyObject>]
        {
            for (_ ,dataDict) in parentArray2.enumerate()
            {
                let parentObj = b4u_PaymentGatewayOffersModel(dataDict:dataDict)
                
                self.paymentGateWayes?.append(parentObj)
            }
        }
    }

}
