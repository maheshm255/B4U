//
//  b4u-Cities.swift
//  bro4u
//
//  Created by Mac on 14/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_Cities: NSObject {

    
    var cityId:String?
    var cityName:String?
    
    override init() {
        
    }
    init(cityDataDict:Dictionary<String , AnyObject>) {
        
        cityName = cityDataDict["city_name"] as? String
        cityId = cityDataDict["city_id"] as? String
        
    }
}
