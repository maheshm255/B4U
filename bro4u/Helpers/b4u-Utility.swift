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
   
    lazy  var activityIndicator : b4u_ActivityIndicator = {
        let image : UIImage = UIImage(named: "spinner")!
        return b4u_ActivityIndicator(image: image)
    }()
    
    
    class var sharedInstance: b4u_Utility {
        struct Singleton {
            
            static let instance = b4u_Utility()
        }
        
        return Singleton.instance
    }
    
    
    /*
       Argument      : nil
       Functionality : Returns the UUID for this particular vendor application
    */
    
    class func getUUIDFromVendorIdentifier()->String
    {
        let vendoerId =   UIDevice.currentDevice().identifierForVendor
        return vendoerId!.UUIDString
    }
    
    class func callAt(number:String)
    {
        //08030323232
        let url = NSURL(string:"tel://\(number)")!
        
        if UIApplication.sharedApplication().canOpenURL(url)
        {
            UIApplication.sharedApplication().openURL(url)
        }else
        {
            print("Call is not supported")
        }
    }
  
  
  //For Setting Order ID from Payment Screen - Rahul
  func setUserDefault(ObjectToSave : AnyObject?  , KeyToSave : String)
  {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    if (ObjectToSave != nil)
    {
      defaults.setObject(ObjectToSave, forKey: KeyToSave)
    }
    else
    {
      defaults.removeObjectForKey(KeyToSave)
    }
    
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  func getUserDefault(KeyToReturnValue : String) -> AnyObject?
  {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    if let name = defaults.valueForKey(KeyToReturnValue)
    {
      return name
    }
    return nil
  }

   //Shadow Effect
   class func shadowEffectToView(object : AnyObject)
   {
    object.layer.shadowColor = UIColor.lightGrayColor().CGColor
    object.layer.shadowOpacity = 1
    object.layer.shadowOffset = CGSizeZero
    object.layer.shadowRadius = 2
    object.layer.shadowPath = UIBezierPath(rect: object.bounds).CGPath
    object.layer.shouldRasterize = true
    object.layer.masksToBounds  = false

   }

  
}
