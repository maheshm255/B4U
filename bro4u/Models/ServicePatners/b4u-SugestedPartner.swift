//
//  b4u-SugestedPartner.swift
//  bro4u
//
//  Created by Tools Team India on 25/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_SugestedPartner: NSObject {

    var aboutVendor:String?
    var averageRating:String?
    var avgRating:String?
    var catId:String?
    var catName:String?
    var catlogMaxOfferAmount:String?
    var custPrice:String?
    var defaultBanner:String?
    var deliveryCharge:String?
    var distance:String?
    var imgAltText:String?
    var itemDesc:String?
    var itemId:String?
    var itemImage:String?
    var itemName:String?
    var itemType:String?
    var latitude:String?
    var longitude:String?
    var manCatId:String?
    var offerInPercent:String?
    var offerMessage:String?
    var offerPrice:String?
    var premiumPartner:String?
    var price:String?
    var priceBoost:String?
    var priorBooking:String?
    var priorDays:String?
    var profilePic:String?
    var quantityActive:String?
    var reviewCount:NSNumber?
    var selection:[String]?
    var sequence:String?
    var take:String?
    var urlSlug:String?
    var vendorId:String?
    var vendorMaxOfferAmount:String?
    var vendorName:String?
    var vendorOfferPercent:String?
    var vendorPriceBoost:String?
    var vendorPriorDays:String?
    var views:String?
    var wishId:String?
    var workingHours:String?
    
    var chargeTitle:String?
    
    
    var sortingPrice:String?
    
    init(sugestedPartnerDetailsDict:Dictionary<String ,AnyObject>) {
        
        aboutVendor = sugestedPartnerDetailsDict["about_vendor"] as? String
        averageRating = sugestedPartnerDetailsDict["average_rating"] as? String
        avgRating = sugestedPartnerDetailsDict["avg_rating"] as? String
        catId = sugestedPartnerDetailsDict["cat_id"] as? String
        catName = sugestedPartnerDetailsDict["cat_name"] as? String
        catlogMaxOfferAmount = sugestedPartnerDetailsDict["catalog_max_offer_amount"] as? String
        custPrice = sugestedPartnerDetailsDict["cust_price"] as? String
        defaultBanner = sugestedPartnerDetailsDict["default_banner"] as? String
        deliveryCharge = sugestedPartnerDetailsDict["delivery_charge"] as? String
        distance = "\(sugestedPartnerDetailsDict["distance"] as! NSNumber)"
        itemDesc = sugestedPartnerDetailsDict["item_desc"] as? String
        imgAltText = sugestedPartnerDetailsDict["image_alt_text"] as? String
        itemDesc = sugestedPartnerDetailsDict["item_desc"] as? String
        itemId = sugestedPartnerDetailsDict["item_id"] as? String
        itemImage = sugestedPartnerDetailsDict["item_image"] as? String
        itemName = sugestedPartnerDetailsDict["item_name"] as? String
        itemType = sugestedPartnerDetailsDict["item_type"] as? String
        latitude = sugestedPartnerDetailsDict["latitude"] as? String
        longitude = sugestedPartnerDetailsDict["longitude"] as? String
        manCatId = sugestedPartnerDetailsDict["main_cat_id"] as? String
        offerInPercent = sugestedPartnerDetailsDict["offer_in_percent"] as? String
        offerMessage = sugestedPartnerDetailsDict["offer_message"] as? String
        offerPrice = sugestedPartnerDetailsDict["offer_price"] as? String
        premiumPartner = sugestedPartnerDetailsDict["premium_partner"] as? String
        price = sugestedPartnerDetailsDict["price"] as? String
        priceBoost = sugestedPartnerDetailsDict["price_boost"] as? String
        priorBooking = sugestedPartnerDetailsDict["prior_booking"] as? String
        priorDays = sugestedPartnerDetailsDict["prior_days"] as? String
        profilePic = sugestedPartnerDetailsDict["profile_pic"] as? String
        quantityActive = sugestedPartnerDetailsDict["quantity_active"] as? String
        reviewCount = sugestedPartnerDetailsDict["review_count"] as? NSNumber
      //  selection = sugestedPartnerDetailsDict["banner"] as? String
        sequence = sugestedPartnerDetailsDict["sequence"] as? String
        take = sugestedPartnerDetailsDict["take"] as? String
        urlSlug = sugestedPartnerDetailsDict["url_slug"] as? String
        vendorId = sugestedPartnerDetailsDict["vendor_id"] as? String
        vendorMaxOfferAmount = sugestedPartnerDetailsDict["vendor_max_offer_amount"] as? String
        vendorName = sugestedPartnerDetailsDict["vendor_name"] as? String
        
        chargeTitle = sugestedPartnerDetailsDict["charges_title"] as? String
        
        
        if let aOfferPrice = self.offerPrice
        {
            self.sortingPrice = aOfferPrice
            
        }else if let aPrice = self.price
        {
            self.sortingPrice = aPrice

        }
//        banner = sugestedPartnerDetailsDict["banner"] as? String
//        banner = sugestedPartnerDetailsDict["banner"] as? String
//        banner = sugestedPartnerDetailsDict["banner"] as? String
//        banner = sugestedPartnerDetailsDict["banner"] as? String
//        banner = sugestedPartnerDetailsDict["banner"] as? String
//        banner = sugestedPartnerDetailsDict["banner"] as? String

    }

}
