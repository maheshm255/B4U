//
//  b4u-LocationSearchModel.swift
//  bro4u
//
//  Created by Mac on 09/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_LocationSearchModel: NSObject {

    
    var lDescription:String?
    
    init(locationDataDict:Dictionary<String ,AnyObject>) {
        
        lDescription = locationDataDict["description"] as? String
       
    }
}
