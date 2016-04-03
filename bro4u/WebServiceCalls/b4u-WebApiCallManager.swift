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
        
        
       
        
        var requestUrl = ""
        if apiPath == kLocationSearchUrl
        {
            
            requestUrl  = apiPath + params
            
        }else
        {
            requestUrl  = b4uBaseUrl + apiPath + params
        }
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
            self.parseTimeSlotData(dataDict)
        case kShowServicePatnerApi:
            self.parseServicePatnerData(dataDict)
        case kLocationSearchUrl:
            self.parseLocationSearchData(dataDict)
        case kMyAccountIndex:
            self.pasrseAccountData(dataDict)
        case kMyOrdersIndex:
            self.pasrseMyOrdersData(dataDict)
        case kMyWalletIndex:
            self.pasrseMyWalletData(dataDict)
        case kMyInfoIndex:
            self.pasrseMyInfoData(dataDict)
        case kOrderNotificationIndex:
            self.pasrseNotificationData(dataDict)
        case kReOrderIndex:
            self.pasrseReOrderData(dataDict)
        case kOfferZoneIndex:
          self.pasrseOfferZoneData(dataDict)
        case kReferAndEarnIndex:
          self.pasrseReferAndEarnData(dataDict)
        case kGetAddress:
            self.pasrseAddressData(dataDict)
        case kOTPlogin:
            self.pasrseOTPLoginInfo(dataDict)
        case kOrderConfirmedIndex:
            self.pasrseOrderConfirmData(dataDict)
        case kSocialLogin:
            self.parseSocialLogin(dataDict)
        case kGetBookingDetailIndex:
            self.parseBookingDetail(dataDict)

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
        
        bro4u_DataManager.sharedInstance.searchResult.removeAll()
        for (_ ,aSearchResultDataDict) in searchResult.enumerate()
        {
            let aSearchedObj = b4u_SearchResult(searchResultDaraDict:aSearchResultDataDict)
            bro4u_DataManager.sharedInstance.searchResult.append(aSearchedObj)
        }
        
    }

    
    func parseCategoryAndSubOptionsData(dataDict:Dictionary<String, AnyObject>)
    {
        let categories:[Dictionary<String ,AnyObject>] = dataDict["categories"] as! [Dictionary<String ,AnyObject>]
        
        bro4u_DataManager.sharedInstance.categoryAndSubOptions.removeAll()
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
    
    func parseTimeSlotData(dataDict:Dictionary<String, AnyObject>)
    {
        
       bro4u_DataManager.sharedInstance.timeSlots = b4u_TimeSlots(timeSlotArray:dataDict["timeslots"] as! [String])
        
    }
    func parseServicePatnerData(dataDict:Dictionary<String, AnyObject>)
    {
        
        if let suggestedPatnersModel =  bro4u_DataManager.sharedInstance.suggestedPatnersResult
        {
         
             suggestedPatnersModel.parseMoreResult(dataDict)
        }else
        {
            let suggestedPatnersObj = b4u_SuggestedPatnersResult(sugestedPartnersResultDict: dataDict)
            
            bro4u_DataManager.sharedInstance.suggestedPatnersResult = suggestedPatnersObj
        }
    }
    
    func parseLocationSearchData(dataDict:Dictionary<String, AnyObject>)
    {
        let locationPredicton:[Dictionary<String ,AnyObject>] = dataDict["predictions"] as! [Dictionary<String ,AnyObject>]
        
        bro4u_DataManager.sharedInstance.locationSearchPredictions.removeAll()
        for (_ ,locationDataDict) in locationPredicton.enumerate()
        {
            let locationPredictionObj = b4u_LocationSearchModel(locationDataDict:locationDataDict)
            bro4u_DataManager.sharedInstance.locationSearchPredictions.append(locationPredictionObj)
        }
    }
    
    func pasrseAccountData(dataDict:Dictionary<String, AnyObject>)
    {
        
        let userDetails:Dictionary<String,AnyObject> = dataDict["user_details"] as! Dictionary<String,AnyObject>

        let myAccountDetailObj = b4u_MyAccountModel(dataDict:userDetails)
        
        bro4u_DataManager.sharedInstance.myAccountData = myAccountDetailObj
    }
    
    func pasrseReOrderData(dataDict:Dictionary<String, AnyObject>)
    {
        
        let reOrederDataArray:[Dictionary<String ,AnyObject>] = dataDict["order"] as! [Dictionary<String ,AnyObject>]
        
        bro4u_DataManager.sharedInstance.myReorderData.removeAll()
        for (_ ,orderDataDict) in reOrederDataArray.enumerate()
        {
            let reOrderModel = b4u_ReOrderModel(dataDict: orderDataDict)
            bro4u_DataManager.sharedInstance.myReorderData.append(reOrderModel)
        }
    }
    //rahul Code
    func pasrseMyOrdersData(dataDict:Dictionary<String, AnyObject>)
    {
        
        let parentArray1:[Dictionary<String ,AnyObject>] = dataDict["orders"] as! [Dictionary<String ,AnyObject>]
        
        bro4u_DataManager.sharedInstance.orderData.removeAll()
        bro4u_DataManager.sharedInstance.paymentGatewayOffersData.removeAll()

        for (_ ,dataDict) in parentArray1.enumerate()
        {
            let parentObj = b4u_OrdersModel(dataDict:dataDict)
            bro4u_DataManager.sharedInstance.orderData.append(parentObj)
        }
        
        let parentArray2:[Dictionary<String ,AnyObject>] = dataDict["payment_gateway_offers"] as! [Dictionary<String ,AnyObject>]
        
        for (_ ,dataDict) in parentArray2.enumerate()
        {
            let parentObj = b4u_PaymentGatewayOffersModel(dataDict:dataDict)
            bro4u_DataManager.sharedInstance.paymentGatewayOffersData.append(parentObj)
        }
    }
    
    func pasrseMyWalletData(dataDict:Dictionary<String, AnyObject>)
    {
        
        let parentArray:[Dictionary<String ,AnyObject>] = dataDict["wallet_activities"] as! [Dictionary<String ,AnyObject>]
        
        bro4u_DataManager.sharedInstance.myWalletData.removeAll()
        for (_ ,dataDict) in parentArray.enumerate()
        {
            let parentObj = b4u_MyWalletModel(dataDict: dataDict)
            bro4u_DataManager.sharedInstance.myWalletData.append(parentObj)
        }
        bro4u_DataManager.sharedInstance.walletBalanceData = dataDict["wallet_balance"] as? NSNumber
    }
    
    func pasrseMyInfoData(dataDict:Dictionary<String, AnyObject>)
    {
        
        let parentArray:[Dictionary<String ,AnyObject>] = dataDict["userdetails"] as! [Dictionary<String ,AnyObject>]
        
        bro4u_DataManager.sharedInstance.myInfoData.removeAll()
        for (_ ,dataDict) in parentArray.enumerate()
        {
            let parentObj = b4u_MyInfoModel(dataDict: dataDict)
            bro4u_DataManager.sharedInstance.myInfoData.append(parentObj)
        }
    }
    
    func pasrseNotificationData(dataDict:Dictionary<String, AnyObject>)
    {
        
        let parentArray:[Dictionary<String ,AnyObject>] = dataDict["notifications"] as! [Dictionary<String ,AnyObject>]
        
        bro4u_DataManager.sharedInstance.notificationData.removeAll()
        for (_ ,dataDict) in parentArray.enumerate()
        {
            let parentObj = b4u_NotificationModel(dataDict: dataDict)
            bro4u_DataManager.sharedInstance.notificationData.append(parentObj)
        }
    }
  
    func pasrseOfferZoneData(dataDict:Dictionary<String, AnyObject>)
    {
      
      let parentArray:[Dictionary<String ,AnyObject>] = dataDict["offers"] as! [Dictionary<String ,AnyObject>]
      
      bro4u_DataManager.sharedInstance.offerZoneData.removeAll()
      for (_ ,dataDict) in parentArray.enumerate()
      {
        let parentObj = b4u_OfferZoneModel(dataDict: dataDict)
        bro4u_DataManager.sharedInstance.offerZoneData.append(parentObj)
      }
    }

  func pasrseReferAndEarnData(dataDict:Dictionary<String, AnyObject>)
  {
  
    let parentDict:Dictionary<String ,AnyObject> = dataDict["referral_data"] as! Dictionary<String ,AnyObject>
    let parentObj = b4u_ReferAndEarnModel(dataDict: parentDict)

    bro4u_DataManager.sharedInstance.referAndEarnData = parentObj

  }
    
    func pasrseOrderConfirmData(dataDict:Dictionary<String, AnyObject>)
    {
        
        let parentArray:[Dictionary<String ,AnyObject>] = dataDict["order"] as! [Dictionary<String ,AnyObject>]
        
        bro4u_DataManager.sharedInstance.orderData.removeAll()
        
        for (_ ,dataDict) in parentArray.enumerate()
        {
            let parentObj = b4u_OrdersModel(dataDict:dataDict)
            bro4u_DataManager.sharedInstance.orderData.append(parentObj)
        }
    }


    func pasrseAddressData(dataDict:Dictionary<String, AnyObject>)
    {
        
        if let addressDataDict:[Dictionary<String ,AnyObject>] = dataDict["addresses"] as? [Dictionary<String ,AnyObject>]
        {
            
            for (_ ,dataDict) in addressDataDict.enumerate()
            {
                let addressModelObj = b4u_AddressDetails(addressDataDict:dataDict)
                bro4u_DataManager.sharedInstance.address.append(addressModelObj)
            }
        }
        
        
    }
    
    
    func pasrseOTPLoginInfo(dataDict:Dictionary<String, AnyObject>)
    {
        
        if  let loginInfoDataDict:Dictionary<String ,AnyObject> = dataDict["user"] as? Dictionary<String ,AnyObject>
        {
            let loginInfoObject = b4u_LoginInfo(loginInfoDataDict:loginInfoDataDict)
            loginInfoObject.loginType = "OTP"
            
            bro4u_DataManager.sharedInstance.loginInfo = loginInfoObject
        }
        
    }
    
    
    func parseSocialLogin(dataDict:Dictionary<String, AnyObject>)
    {
        
        if  let loginInfoDataArray:[Dictionary<String ,AnyObject>] = dataDict["userdata"] as? [Dictionary<String ,AnyObject>]
        {
            let dataDict = loginInfoDataArray.first!
            if let loginInfoOBj = bro4u_DataManager.sharedInstance.loginInfo
            {
                loginInfoOBj.userId = dataDict["user_id"] as? String
            }else
            {
                let loginInfoObject = b4u_LoginInfo(loginInfoDataDict: dataDict)
                loginInfoObject.loginType = "OTP"
                
                bro4u_DataManager.sharedInstance.loginInfo = loginInfoObject
            }
        }
        
    }
    
    
    func parseBookingDetail(dataDict:Dictionary<String, AnyObject>)
    {
        
        let parentArray1:[Dictionary<String ,AnyObject>] = dataDict["orderdetails"] as! [Dictionary<String ,AnyObject>]
        
        bro4u_DataManager.sharedInstance.orderDetailData.removeAll()
        bro4u_DataManager.sharedInstance.selectionData.removeAll()
        bro4u_DataManager.sharedInstance.paymentGatewayOffersData.removeAll()
        
        for (_ ,dataDict) in parentArray1.enumerate()
        {
            let parentObj = b4u_OrderDetailModel(dataDict:dataDict)
            bro4u_DataManager.sharedInstance.orderDetailData.append(parentObj)
        }
        
        if let parentArray2:[Dictionary<String ,AnyObject>] = dataDict["payment_gateway_offers"] as? [Dictionary<String ,AnyObject>]
        {
            for (_ ,dataDict) in parentArray2.enumerate()
            {
                let parentObj = b4u_PaymentGatewayOffersModel(dataDict:dataDict)
                bro4u_DataManager.sharedInstance.paymentGatewayOffersData.append(parentObj)
            }
        }
    }
    
}
