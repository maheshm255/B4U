//
//  b4u_IntermediateScreenDataModel.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_IntermediateScreenDataModel: NSObject {

    var catID:String?
    var couponCode:String?
    var couponOfferAdDesc:String?
    var couponOfferAdHeader:String?
    var catName:String?
    var interBanner:String?
    var interMessges:[String]?
    var termsAndConditions:[String]?
    
    init(interMediateInfoDataDict:Dictionary<String ,AnyObject>) {
        
        interMessges = Array()
        termsAndConditions = Array()
        catID = interMediateInfoDataDict["cat_id"] as? String
        couponCode = interMediateInfoDataDict["coupon_code"] as? String
        couponOfferAdDesc = interMediateInfoDataDict["coupon_offer"]!["AD"]!!["description"] as? String
        
        couponOfferAdHeader = interMediateInfoDataDict["coupon_offer"]!["AD"]!!["header"] as? String

        catName = interMediateInfoDataDict["intermediatory"]!["cat_name"] as? String
        interBanner = interMediateInfoDataDict["intermediatory"]!["inter_banner"] as? String

        let interArray = interMediateInfoDataDict["intermediatory"]!["intermediatory"]!!["inter"] as! [Dictionary<String ,AnyObject>]
        
        
        if let aArray  = interArray.first
        {
            if aArray.count > 0
            {
                interMessges?.append(interArray.first!["1"]! as! String)
                
            }
            if aArray.count > 1
            {
                interMessges?.append(interArray.first!["2"]! as! String)
                
            }
            
            if aArray.count > 2
            {
                interMessges?.append(interArray.first!["3"]! as! String)
            }
        }
        
     
        
        let termsAndCond:[String] = interMediateInfoDataDict["terms_conditions"] as! [String]
        
        if termsAndCond.count > 0
        {
            for(_ ,termsAndCondStr) in termsAndCond.enumerate()
            {
                termsAndConditions?.append(termsAndCondStr)
            }
        }

    }
}
