//
//  b4u_OrdersModel.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OrdersModel: NSObject {

    var catID:String?
    var catName:String?
    var orderID:String?
    var zipcode:NSNumber?
    var deductedFromWallet:String?
    var itemID:String?
    var paymentType:String?
    var customerName:String?
    var email:String?
    var mobile:String?
    var paymentStatus:String?
    var serviceAddress:String?
    var priorDays:NSNumber?
    var serviceDate:String?
    var profilePic:String?
    var timestamp:String?
    var serviceTime:String?
    var totalCost:NSNumber?
    var finalAmountPaid:NSNumber?
    var materialCharges:NSNumber?
    var netAmountPaid:NSNumber?
    var statusCode:NSNumber?
    var statusDesc:String?
    var vendorName:String?
    var vendorMobile:String?
    var vendorEmail:String?
    var vendorID:String?
    var statusUpdated:String?
    var onGoing:String?
    var actualPrice:NSNumber?
    var offerPrice:NSNumber?
    var finalTotal:NSNumber?
    var statusNumber:NSNumber?
    var metaItemReOrder:[b4u_ReOrder_MetaItemModel]?

    var paymentGateWayes:[b4u_PaymentGatewayOffersModel]?
    
    var whyOnline:[b4u_WhyOnlineModel]?

    init(dataDict:Dictionary<String ,AnyObject>) {
        
        
        catID = dataDict["cat_id"] as? String
        catName = dataDict["cat_name"] as? String
        orderID = dataDict["order_id"] as? String
        zipcode = dataDict["zipcode"] as? NSNumber
        deductedFromWallet = dataDict["deducted_from_wallet"] as? String
        itemID = dataDict["item_id"] as? String
        paymentType = dataDict["payment_type"] as? String
        customerName = dataDict["customer_name"] as? String
        email = dataDict["email"] as? String
        mobile = dataDict["mobile"] as? String
        paymentStatus = dataDict["payment_status"] as? String
        serviceAddress = dataDict["service_address"] as? String
        priorDays = dataDict["prior_days"] as? NSNumber
        serviceDate = dataDict["service_date"] as? String
        profilePic = dataDict["profile_pic"] as? String
        timestamp = dataDict["timestamp"] as? String
        serviceTime = dataDict["service_time"] as? String
        totalCost = dataDict["total_cost"] as? NSNumber
        finalAmountPaid = dataDict["final_amount_paid"] as? NSNumber
        materialCharges = dataDict["material_charges"] as? NSNumber
        netAmountPaid = dataDict["net_amount_paid"] as? NSNumber
        statusCode = dataDict["status_code"] as? NSNumber
        statusDesc = dataDict["status_desc"] as? String
        vendorName = dataDict["vendor_name"] as? String
        vendorMobile = dataDict["vendor_mobile"] as? String
        vendorEmail = dataDict["vendor_email"] as? String
        vendorID = dataDict["vendor_id"] as? String
        statusUpdated = dataDict["status_updated"] as? String
        onGoing = dataDict["on_going"] as? String
        actualPrice = dataDict["actual_price"] as? NSNumber
        offerPrice = dataDict["offer_price"] as? NSNumber
        finalTotal = dataDict["final_total"] as? NSNumber
        statusNumber = dataDict["status_number"] as? NSNumber
        
        self.metaItemReOrder = Array()
        
        if let itemDartaArray:[Dictionary<String ,AnyObject>] = dataDict["item_meta"] as? [Dictionary<String ,AnyObject>]
        {
            for (_ ,orderItemDataDict) in itemDartaArray.enumerate()
            {
                let reOrderModel = b4u_ReOrder_MetaItemModel(dataDict:orderItemDataDict)
                self.metaItemReOrder?.append(reOrderModel)
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
        
        self.whyOnline = Array()
        
        if let itemDataArray:[Dictionary<String ,AnyObject>] = dataDict["why_online"] as? [Dictionary<String ,AnyObject>]
        {
            for (_ ,whyOnlineDataDict) in itemDataArray.enumerate()
            {
                let whyOnlineModel = b4u_WhyOnlineModel(dataDict:whyOnlineDataDict)
                self.whyOnline?.append(whyOnlineModel)
            }
        }

        
    }

}
