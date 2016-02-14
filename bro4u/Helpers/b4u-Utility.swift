//
//  cf-Utility.swift
//  cf-support
//
//  Created by Tools Team India on 03/08/15.
//  Copyright (c) 2015 Schneider Electric Pty Ltd. All rights reserved.
//

import UIKit

let SE_COLOR_SPRUCE_GREEN:Int =  0x009530

class cf_Utility: NSObject {
   
    
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
