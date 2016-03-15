//
//  b4u_ReOrderModel.swift
//  bro4u
//
//  Created by Rahul on 12/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ReOrderModel: NSObject {

    
    var reorderThrashed:String?
    var catName:String?
    var catID:String?
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
    var serviceDate:String?
    var statusDesc:String?
    var timestamp:String?
    var serviceTime:String?
    var cityName:String?
    var totalCost:NSNumber?
    var statusCode:NSNumber?
    var vendorMobile:String?
    var vendorName:String?
    var profilePic:String?
    var priorDays:NSNumber?
    var actualPrice:NSNumber?
    var vendorEmail:String?
    var vendorID:NSNumber?
    var itemName:String?
    var subTotal:NSNumber?
    var metaItemReOrder:[b4u_ReOrder_MetaItemModel]?
    var SelectionReorder:[b4u_ReorderSelectionModel]?

    
    init(dataDict:Dictionary<String ,AnyObject>) {
        
        reorderThrashed = dataDict["reorder_thrashed"] as? String
        catName = dataDict["cat_name"] as? String
        catID = dataDict["cat_id"] as? String
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
        serviceDate = dataDict["service_date"] as? String
        statusDesc = dataDict["status_desc"] as? String
        timestamp = dataDict["timestamp"] as? String
        serviceTime = dataDict["service_time"] as? String
        cityName = dataDict["city_name"] as? String
        totalCost = dataDict["total_cost"] as? NSNumber
        statusCode = dataDict["status_code"] as? NSNumber
        vendorMobile = dataDict["vendor_mobile"] as? String
        vendorName = dataDict["vendor_name"] as? String
        profilePic = dataDict["profile_pic"] as? String
        priorDays = dataDict["prior_days"] as? NSNumber
        actualPrice = dataDict["actual_price"] as? NSNumber
        vendorEmail = dataDict["vendor_email"] as? String
        vendorID = dataDict["vendor_id"] as? NSNumber
        itemName = dataDict["item_name"] as? String
        subTotal = dataDict["sub_total"] as? NSNumber
        
        self.metaItemReOrder = Array()
        
        if let itemDartaArray:[Dictionary<String ,AnyObject>] = dataDict["item_meta"] as? [Dictionary<String ,AnyObject>]
        {
            for (_ ,orderItemDataDict) in itemDartaArray.enumerate()
            {
                let reOrderModel = b4u_ReOrder_MetaItemModel(dataDict:orderItemDataDict)
                self.metaItemReOrder?.append(reOrderModel)
            }
            
        }
        SelectionReorder = Array()
        
        if let selectionDartaArray:[Dictionary<String ,AnyObject>] = dataDict["selection"] as? [Dictionary<String ,AnyObject>]
        {
            
            for (_ ,orderItemDataDict) in selectionDartaArray.enumerate()
            {
                let reOrderModel = b4u_ReorderSelectionModel(dataDict:orderItemDataDict);
                self.SelectionReorder?.append(reOrderModel)
            }

        }
    }

}
