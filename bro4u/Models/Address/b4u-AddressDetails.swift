//
//  b4u-AddressDetails.swift
//  bro4u
//
//  Created by Mac on 13/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit
import CoreLocation

class b4u_AddressDetails: NSObject {

    var name:String?
    var email:String?
    var phoneNumber:String?
    var fullAddress:String?
    var currentLocation:CLLocation?
    var curretPlace:String?

    var addressId:NSNumber?
    var cityId:NSNumber?
    var cityName:String?
    var lattitude:String?
    var longitude:String?
    var userId:NSNumber?
    var locality:String?
    
    override init() {
        
    }
    init(addressDataDict:Dictionary<String , AnyObject>) {
        
        addressId = addressDataDict["address_id"] as? NSNumber
        cityId = addressDataDict["city_id"] as? NSNumber
        cityName = addressDataDict["city_name"] as? String
        email = addressDataDict["email"] as? String
        lattitude = addressDataDict["latitude"] as? String
        longitude = addressDataDict["longitude"] as? String

        locality = addressDataDict["locality"] as? String
        phoneNumber = addressDataDict["mobile"] as? String
        name = addressDataDict["name"] as? String
        curretPlace = addressDataDict["street_name"] as? String

        userId = addressDataDict["user_id"] as? NSNumber
        
        fullAddress = "\(locality!) \(cityName!)"

    }
}
