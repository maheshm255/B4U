//
//  b4u_CreateOrder.swift
//  bro4u
//
//  Created by MSP-User3 on 11/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit


protocol createOrderDelegate
{
  func hasOrderCreated(resultObject:String)
  
}
class b4u_CreateOrder: NSObject {

  
  var delegate:createOrderDelegate?
  var paymentType:String?

  func createOrder()
  {
    
    /*
     /index.php/order/place_cod_order?
     user_id=1626&
     total_cost=98&
     service_time=12pm-2pm&
     service_date=2-09-2015&
     selection=[{%22option_112%22%3A%222%22%2C%22option_105%22%3A%221%22%2C%22user_id%22%3A%221626%22%2C%22item_id%22%3A%221928%22%2C%22vendor_id%22%3A%22132%22%2C%22unit_quantity%22%3A%221%22%2C%22grand_total%22%3A98%2C%22sub_total%22%3A98%2C%22delivery_charge%22%3A%220.00%22%2C%22deducted_from_wallet%22%3A0%2C%22deducted_using_coupon%22%3A0}]&
     grand_total=98.0&
     night_delivery_charge=0.00&
     customer_name=Harshal+Zope&
     vendor_id=132&
     custom_message=ihih&
     address_id=2&
     email=harshal.zope1990%40gmail.com&
     mobile=8149881090&
     item_id=1928&
     payment_wallet=0&
     coupon=bash200&
     imei=359296054612743&
     cat_id=13&
     latitude=23.344543&
     longitude=49878428
     
     
     */
        
    
    
    var user_id = ""
    var total_cost = ""
    var service_time = ""
    var service_date = ""
    var selection = "[{%22option_112%22%3A%222%22%2C%22option_105%22%3A%221%22%2C%22user_id%22%3A%221626%22%2C%22item_id%22%3A%221928%22%2C%22vendor_id%22%3A%22132%22%2C%22unit_quantity%22%3A%221%22%2C%22grand_total%22%3A98%2C%22sub_total%22%3A98%2C%22delivery_charge%22%3A%220.00%22%2C%22deducted_from_wallet%22%3A0%2C%22deducted_using_coupon%22%3A0}]"
    var grand_total=""
    var night_delivery_charge=""
    var customer_name=""
    var vendor_id=""
    var custom_message="ihih"
    var address_id="1"
    var email=""
    var mobile=""
    var item_id=""
    var payment_wallet="0"
    var coupon=""
    var imei = b4u_Utility.getUUIDFromVendorIdentifier()
    var cat_id=""
    var latitude=""
    var longitude=""
    
    
    if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
      
      user_id = loginInfoData.userId! //Need to use later
    }
    
    total_cost =  bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.custPrice!
    
    if let couponCode =    bro4u_DataManager.sharedInstance.copiedCopunCode
    {
      coupon = couponCode
    }
    service_time =   bro4u_DataManager.sharedInstance.selectedTimeSlot!
    service_date =   "\(bro4u_DataManager.sharedInstance.selectedDate!)"
    
    
    if let orderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData.first
    {
      if let selectionLocal: b4u_SelectionModel =  orderDetailModel.selection?.first{
        
        grand_total = "\(selectionLocal.grandTotal)"
        
        if let deliverChages = selectionLocal.nightCharge
        {
          night_delivery_charge = deliverChages
        }
        item_id = selectionLocal.itemId!
        vendor_id = selectionLocal.vendorId!
        selection =  ""
      }
      
    }
    
    if let catIDData:b4u_OrderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData[0]{
      
      cat_id = catIDData.catId!
    }
    
    
    if let addressData:b4u_AddressDetails = bro4u_DataManager.sharedInstance.address[0]{
      
      if let addressId = addressData.addressId
      {
        address_id = "\(addressId)"
      }
      
      if let aEmail = addressData.email
      {
        email = aEmail
      }
      if let lat = addressData.lattitude
      {
        latitude = lat
      }
      
      if let long = addressData.longitude
      {
        longitude = long
      }
      
      if let phoneNumber = addressData.phoneNumber
      {
        mobile = phoneNumber
      }
      if let cusName = addressData.name
      {
        customer_name = cusName
      }
    }
    
    
    
    let params = "?user_id=\(user_id)&total_cost=\(total_cost)&service_time=\(service_time)&service_date=\(service_date)&selection=\(selection)&grand_total=\(grand_total)&night_delivery_charge=\(night_delivery_charge)&customer_name=\(customer_name)&vendor_id=\(vendor_id)&custom_message=\(custom_message)&address_id=\(address_id)&email=\(email)&mobile=\(mobile)&item_id=\(item_id)&payment_wallet=\(payment_wallet)&coupon=\(coupon)&imei=\(imei)&cat_id=\(cat_id)&latitude=\(latitude)&longitude=\(longitude)"
    
    
    if self.paymentType == kCODPayment{
      b4u_WebApiCallManager.sharedInstance.getApiCall(kPlaceCashOnDeliveryIndex , params:params, result:{(resultObject) -> Void in
        print(" COD Order Data Received")
        // self.getDataOfThanksScreen(resultObject as! String)
        
        self.delegate?.hasOrderCreated(resultObject as! String)
        
        print(resultObject)
      })
      
    }
    else{
      b4u_WebApiCallManager.sharedInstance.getApiCall(kPlaceOnlineOrderIndex , params:params, result:{(resultObject) -> Void in
        print(" Online Order Data Received")
        // self.getDataOfThanksScreen(resultObject as! String)
        
        self.delegate?.hasOrderCreated(resultObject as! String)
        
        print(resultObject)
      })
      
    }

  }



}
