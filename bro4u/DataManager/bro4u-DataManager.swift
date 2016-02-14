//
//  bro4u-DataManager.swift
//  bro4u
//
//  Created by Tools Team India on 08/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class bro4u_DataManager: NSObject {
    
    
    var mainCategories:[bro4u_MainCategory] = Array()
    class var sharedInstance: bro4u_DataManager {
        struct Singleton {
            
            static let instance = bro4u_DataManager()
            
        }
        
        return Singleton.instance
    }
    
    
    func readLocalFile(fileName:String)
    {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        
        do {
            let text = try String(contentsOfFile:path!, encoding:NSUTF8StringEncoding)
            
            let data = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            
               do {
                
            if let jsonData = data {
                // Will return an object or nil if JSON decoding fails
               let resultObj =  try NSJSONSerialization.JSONObjectWithData(jsonData, options:NSJSONReadingOptions.AllowFragments)
                print(resultObj)
                
                self.parseCategoryData(resultObj as! Dictionary<String, AnyObject>)

            }
            
               } catch  let error as NSError {
                debugPrint(error)
            }

        } catch  let error as NSError {
            debugPrint(error)
        }
        
    }
    
    func parseCategoryData(dataDict:Dictionary<String, AnyObject>)
    {
        let manCategories:[Dictionary<String ,AnyObject>] = dataDict["main_cat"] as! [Dictionary<String ,AnyObject>]
        
        for (_ ,categotyDataDict) in manCategories.enumerate()
        {
            let cateGoryObj = bro4u_MainCategory(categoryDataDict:categotyDataDict)
            mainCategories.append(cateGoryObj)
        }
    }
}
