//
//  b4u_IntermediateScreenDataModel.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_IntermediateScreenDataModel: NSObject {

    
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
        couponCode = interMediateInfoDataDict["coupon_code"] as? String
        couponOfferAdDesc = interMediateInfoDataDict["coupon_offer"]!["AD"]!!["description"] as? String
        
        couponOfferAdHeader = interMediateInfoDataDict["coupon_offer"]!["AD"]!!["header"] as? String

        catName = interMediateInfoDataDict["intermediatory"]!["cat_name"] as? String
        interBanner = interMediateInfoDataDict["intermediatory"]!["inter_banner"] as? String

        let interArray = interMediateInfoDataDict["intermediatory"]!["intermediatory"]!!["inter"] as! [Dictionary<String ,AnyObject>]
        
        
        interMessges?.append(interArray.first!["1"]! as! String)
        interMessges?.append(interArray.first!["2"]! as! String)
        interMessges?.append(interArray.first!["3"]! as! String)

    }
}
