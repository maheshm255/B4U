//
//  bro4u-DataManager.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//
import UIKit
import CoreLocation

class bro4u_DataManager: NSObject {
    
    // API Responce Data
    var mainCategories:[bro4u_MainCategory] = Array()
    var sliderImages:[b4u_SliderImage] = Array()
    var searchResult:[b4u_SearchResult] = Array()
    var categoryAndSubOptions:[b4u_Category] = Array()
    var locationSearchPredictions:[b4u_LocationSearchModel] = Array()

    var interMediateScreenDataObj:b4u_IntermediateScreenDataModel?
    var catlogFilterObj:b4u_catalog?

    var timeSlots:b4u_TimeSlots?

    var suggestedPatnersResult:b4u_SuggestedPatnersResult?

    // User Selected
    var selectedDate:NSDate?
    var selectedTimeSlot:String?
    
    var selectedSuggestedPatner:b4u_SugestedPartner?
  
    var userSelectedFilterParams:String?
    var currenLocation:CLLocation?
    var currentLocality:CLPlacemark?

    var userSelectedLocatinStr:String?
    
    var selectedQualtity:NSString?
    
    var address:[b4u_AddressDetails] = Array()
  
    var loginInfo:b4u_LoginInfo?
    
    var selectedReorderModel:b4u_ReOrderModel?
    
    
    var orderId:NSNumber?
    var txnID:String?
    var surl:String?
    var furl:String?
    var couponCodeStatus:String?
    var couponCodeMessage:String?


    var vendorProfile:b4u_VendorProfileModel?

    var vendorDescriptinHtmlString:String?
    
    var vendorPriceChartHtmlString:String?
    
    var copiedCopunCode:String?
    
  //Rahul Added
    var myInfoData:[b4u_MyInfoModel] = Array()
    var myWalletData:[b4u_MyWalletModel] = Array()
    var walletBalanceData:NSNumber?
    var myAccountData:b4u_MyAccountModel?
    var offerZoneData:[b4u_OfferZoneModel] = Array()
    var referAndEarnData:b4u_ReferAndEarnModel?
    var orderConfirmedData:[b4u_OrderConfirmedModel] = Array()
    var orderData:[b4u_OrdersModel] = Array()
    var paymentGatewayOffersData:[b4u_PaymentGatewayOffersModel] = Array()
    var notificationData:[b4u_NotificationModel] = Array()
    var myReorderData:[b4u_ReOrderModel] = Array()
    var orderDetailData:[b4u_OrderDetailModel] = Array()
    var selectionData:[b4u_SelectionModel] = Array()
    var whyOnlineData:[b4u_WhyOnlineModel] = Array()
 
    

    class var sharedInstance: bro4u_DataManager {
        struct Singleton {
            
            static let instance = bro4u_DataManager()
            
        }
        
        return Singleton.instance
    }
 
  

//    
//    func readLocalFile(fileName:String)
//    {
//        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
//        
//        do {
//            let text = try String(contentsOfFile:path!, encoding:NSUTF8StringEncoding)
//            
//            let data = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//            
//               do {
//                
//            if let jsonData = data {
//                // Will return an object or nil if JSON decoding fails
//               let resultObj =  try NSJSONSerialization.JSONObjectWithData(jsonData, options:NSJSONReadingOptions.AllowFragments)
//                print(resultObj)
//                
//                self.parseCategoryData(resultObj as! Dictionary<String, AnyObject>)
//
//            }
//            
//               } catch  let error as NSError {
//                debugPrint(error)
//            }
//
//        } catch  let error as NSError {
//            debugPrint(error)
//        }
//        
//    }
    
//    func parseCategoryData(dataDict:Dictionary<String, AnyObject>)
//    {
//        let manCategories:[Dictionary<String ,AnyObject>] = dataDict["main_cat"] as! [Dictionary<String ,AnyObject>]
//        
//        for (_ ,categotyDataDict) in manCategories.enumerate()
//        {
//            let cateGoryObj = bro4u_MainCategory(categoryDataDict:categotyDataDict)
//            mainCategories.append(cateGoryObj)
//        }
//    }
}
