//
//  cf_Utility.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//

import UIKit

let SE_COLOR_SPRUCE_GREEN:Int =  0x009530

class b4u_Utility: NSObject {
   
    
    /*
       Argument      : nil
       Functionality : Returns the UUID for this particular vendor application
    */
    
    class func getUUIDFromVendorIdentifier()->String
    {
        let vendoerId =   UIDevice.currentDevice().identifierForVendor
        return vendoerId!.UUIDString
    }
    
}
