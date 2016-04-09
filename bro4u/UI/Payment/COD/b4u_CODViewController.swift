//
//  b4u_CODViewController.swift
//  bro4u
//
//  Created by Rahul on 03/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit
import CoreLocation


class b4u_CODViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSevar, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func getData()
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
        
    let  total_cost="98"
    let  service_time="12pm-2pm"
    let  service_date="2-09-2015"
    let  selection=""
    let  grand_total="98.0"
    let  night_delivery_charge="0.00"
//    let  customer_name="Harshal Zope"
    let  vendor_id="132"
    let  custom_message="ihih"
//    let  address_id="2"
//    let  email="harshal.zope1990@gmail.com"
//    let  mobile="8149881090"
    let  item_id="1928"
    let  payment_wallet="0"
    let  coupon="bash200"
    let  imei="359296054612743"
//    var  cat_id="13"
//    let  latitude="23.344543"
//    let  longitude="49878428"

    
        var user_id = ""
        var cat_id = ""
        var  address_id=""
        var  email=""
        var  latitude=""
        var  longitude=""
        var  mobile=""
        var  customer_name=""


        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            user_id = loginInfoData.userId! //Need to use later
            
        }
        
        if let catIDData:b4u_Category = bro4u_DataManager.sharedInstance.categoryAndSubOptions[0]{
            
            cat_id = catIDData.catId! //Need to use later
        }

        if let currentLocationData:CLLocation = bro4u_DataManager.sharedInstance.currenLocation{
            
            latitude = "\(currentLocationData.coordinate.latitude)"
            longitude = "\(currentLocationData.coordinate.longitude)"
        }
        
        if let addressData:b4u_AddressDetails = bro4u_DataManager.sharedInstance.address[0]{
            
            address_id = "\(addressData.addressId!)" //Need to use later
            email = "\(addressData.email!)" //Need to use later
            latitude = "\(addressData.lattitude)"
            longitude = "\(addressData.longitude)"
            mobile = "\(addressData.phoneNumber)"
            customer_name = "\(addressData.name)"

        }


        
        let params = "?user_id=\(user_id)&total_cost=\(total_cost)&service_time=\(service_time)&service_date=\(service_date)&selection=\(selection)&grand_total=\(grand_total)&night_delivery_charge=\(night_delivery_charge)&customer_name=\(customer_name)&vendor_id=\(vendor_id)&custom_message=\(custom_message)&address_id=\(address_id)&email=\(email)&mobile=\(mobile)&item_id=\(item_id)&payment_wallet=\(payment_wallet)&coupon=\(coupon)&imei=\(imei)&cat_id=\(cat_id)&latitude=\(latitude)&longitude=\(longitude)"

        b4u_WebApiCallManager.sharedInstance.getApiCall(kPlaceCashOnDeliveryIndex , params:params, result:{(resultObject) -> Void in
            
            print(" COD Order Data Received")
            
            self.updateUI(resultObject as! String)

            print(resultObject)
        })
    }


    func updateUI(result:String)
    {
        if result  == "Success"
        {

            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

//            let thanksScreen:OrderConfirmedViewController = storyboard.instantiateViewControllerWithIdentifier("OrderConfirmedViewControllerID") as! OrderConfirmedViewController
//            thanksScreen.order_id  =  bro4u_DataManager.sharedInstance.orderId
            
            
            let thanksScreen:b4u_OrderConfirmedCODViewController = storyboard.instantiateViewControllerWithIdentifier("OrderConfirmedCODViewControllerID") as! b4u_OrderConfirmedCODViewController
            
            thanksScreen.lblOrderId.text  =  "#\(bro4u_DataManager.sharedInstance.orderId)"
            thanksScreen.lblServiceProvide.text = bro4u_DataManager.sharedInstance.selectedSuggestedPatner?.vendorName
            thanksScreen.lblService.text = bro4u_DataManager.sharedInstance.interMediateScreenDataObj?.catName

            navigationController?.pushViewController(thanksScreen, animated: true)
        }else
        {
            print("Order Not Created")
        }
    }

}
