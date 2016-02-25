//
//  b4u-WebApiCallManager.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//
import UIKit

class b4u_WebApiCallManager: NSObject {

    
    //MARK: Self Singleton variable
    /*
    @ This is class variable which creates self Singleton object
    */
    class var sharedInstance: b4u_WebApiCallManager {
        struct Singleton {
            static let instance = b4u_WebApiCallManager()
        }
        return Singleton.instance
    }
    
    
    func getApiCall(apiPath:String ,params:String ,result:AnyObject->()){
        
            let requestUrl = b4uBaseUrl + apiPath + params
            let sessionManager = AFHTTPSessionManager();
        
            sessionManager.responseSerializer = AFHTTPResponseSerializer()

        sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        
        sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
            let getTokenTask = sessionManager.GET(requestUrl, parameters:nil, success: { (dataTask:NSURLSessionDataTask, response:AnyObject) -> Void in
                
                do {
                        // Will return an object or nil if JSON decoding fails
                        let resultObj =  try NSJSONSerialization.JSONObjectWithData(response as! NSData, options:NSJSONReadingOptions.AllowFragments)
                        print(resultObj)
                    
                       self.parseData(apiPath, dataDict:resultObj as! Dictionary<String, AnyObject>)
                    
                    result("Success")
                
                    
                } catch  let error as NSError {
                    debugPrint(error)
                }
                
                }) { (dataTask:NSURLSessionDataTask, error:NSError) -> Void in
                    
                    print("Session Error: \(error.description)")
                    
                    result(error)
                    
            }
            getTokenTask?.resume()
            
    }

    
    func parseData(itemName:String ,dataDict:Dictionary<String, AnyObject>)
    {
        switch(itemName)
        {
        case kHomeSCategory:
            self.parseCategoryData(dataDict)
        case kSearchApi:
            self.pareseSearchData(dataDict)
        case kCategoryAndSubOptions:
            self.parseCategoryAndSubOptionsData(dataDict)
        case intermediateScreenAPi:
            self.parseIntermediateScreenData(dataDict)
        case filterApi:
            self.parseCatalogAttributes(dataDict)
        case kTimeSlotApi:
            self.parsTimeSlotData(dataDict)
        case kShowServicePatnerApi:
            self.parseServicePatnerData(dataDict)
        default:
            print(itemName)
        }
    }
    func parseCategoryData(dataDict:Dictionary<String, AnyObject>)
    {
        let manCategories:[Dictionary<String ,AnyObject>] = dataDict["main_cat"] as! [Dictionary<String ,AnyObject>]
        
        for (_ ,categotyDataDict) in manCategories.enumerate()
        {
            let cateGoryObj = bro4u_MainCategory(categoryDataDict:categotyDataDict)
          bro4u_DataManager.sharedInstance.mainCategories.append(cateGoryObj)
        }
        
          let sliderImages:[Dictionary<String ,AnyObject>] = dataDict["slider_images"] as! [Dictionary<String ,AnyObject>]
        
        for (_ ,sliderImagesInfoDict) in sliderImages.enumerate()
        {
            let sliderImageObj = b4u_SliderImage(sliderImageInfoDataDict:sliderImagesInfoDict)
            bro4u_DataManager.sharedInstance.sliderImages.append(sliderImageObj)
        }
    }
 
    func pareseSearchData(dataDict:Dictionary<String, AnyObject>)
    {
        let searchResult:[Dictionary<String ,AnyObject>] = dataDict["search_details"] as! [Dictionary<String ,AnyObject>]
        
        for (_ ,aSearchResultDataDict) in searchResult.enumerate()
        {
            let aSearchedObj = b4u_SearchResult(searchResultDaraDict:aSearchResultDataDict)
            bro4u_DataManager.sharedInstance.searchResult.append(aSearchedObj)
        }
        
    }

    
    func parseCategoryAndSubOptionsData(dataDict:Dictionary<String, AnyObject>)
    {
        let categories:[Dictionary<String ,AnyObject>] = dataDict["categories"] as! [Dictionary<String ,AnyObject>]
        
        for (_ ,categoryDataDict) in categories.enumerate()
        {
            let categoryObj = b4u_Category(categoryDataDict:categoryDataDict)
            bro4u_DataManager.sharedInstance.categoryAndSubOptions.append(categoryObj)
        }
    }
    
    
    func parseIntermediateScreenData(dataDict:Dictionary<String, AnyObject>)
    {
      
            let interMediateDataObj = b4u_IntermediateScreenDataModel(interMediateInfoDataDict: dataDict)
            bro4u_DataManager.sharedInstance.interMediateScreenDataObj = interMediateDataObj
    }
    
    func parseCatalogAttributes(dataDict:Dictionary<String, AnyObject>)
    {
        
        let  filteredCatlog = b4u_catalog(catLogDataDict:dataDict)
        bro4u_DataManager.sharedInstance.catlogFilterObj = filteredCatlog
        
    }
    
    func parsTimeSlotData(dataDict:Dictionary<String, AnyObject>)
    {
        
       bro4u_DataManager.sharedInstance.timeSlots = b4u_TimeSlots(timeSlotArray:dataDict["timeslots"] as! [String])
        
    }
    func parseServicePatnerData(dataDict:Dictionary<String, AnyObject>)
    {
        
    }
    
}
