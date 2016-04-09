//
//  b4u_OrderConfirmedCODViewController.swift
//  bro4u
//
//  Created by Rahul on 08/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit
import CoreLocation

class b4u_OrderConfirmedCODViewController: UIViewController {

    var order_id:String?
    var confirmedOrder:b4u_OrdersModel?

    @IBOutlet weak var imgViewServiceProvider: UIImageView!
    @IBOutlet weak var lblServiceProvide: UILabel!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblServiceDate: UILabel!
    @IBOutlet weak var lblTimeSlot: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblServiceStatus: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblOrderedAt: UILabel!
    @IBOutlet weak var lblHeasder: UILabel!
    @IBOutlet weak var lblSubheader: UILabel!
    @IBOutlet weak var lblOnlineAdvantage1: UILabel!
    @IBOutlet weak var lblOnlineAdvantage2: UILabel!
    @IBOutlet weak var lblOnlineAdvantage3: UILabel!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var downView: UIView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var btnContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addLoadingIndicator()
//        currentOrder =  bro4u_DataManager.sharedInstance.orderData[0]
        
        self.createOrder()
//        self.getDataOfThanksScreen()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        topView.hidden = true
        middleView.hidden = true
        downView.hidden = true
        btnContinue.hidden = true
        
        var user_id = ""
        var total_cost = "98"
        var service_time = "12pm-2pm"
        var service_date = "2-09-2015"
        var selection = "[{%22option_112%22%3A%222%22%2C%22option_105%22%3A%221%22%2C%22user_id%22%3A%221626%22%2C%22item_id%22%3A%221928%22%2C%22vendor_id%22%3A%22132%22%2C%22unit_quantity%22%3A%221%22%2C%22grand_total%22%3A98%2C%22sub_total%22%3A98%2C%22delivery_charge%22%3A%220.00%22%2C%22deducted_from_wallet%22%3A0%2C%22deducted_using_coupon%22%3A0}]"
        var grand_total="98.0"
        var night_delivery_charge="0.00"
        var customer_name="Harshal+Zope"
        var vendor_id="132"
        var custom_message="ihih"
        var address_id="2"
        var email="harshal.zope1990@gmail.com"
        var mobile="8149881090"
        var item_id="1928"
        var payment_wallet="0"
        var coupon="bash200"
        var imei="359296054612743"
        var cat_id="13"
        var latitude="23.344543"
        var longitude="49878428"

        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            user_id = loginInfoData.userId! //Need to use later
            
        }
//
//        if let catIDData:b4u_Category = bro4u_DataManager.sharedInstance.categoryAndSubOptions[0]{
//            
//            cat_id = catIDData.catId! //Need to use later
//        }
//        
//        if let currentLocationData:CLLocation = bro4u_DataManager.sharedInstance.currenLocation{
//            
//            latitude = "\(currentLocationData.coordinate.latitude)"
//            longitude = "\(currentLocationData.coordinate.longitude)"
//        }
//        
//        if let addressData:b4u_AddressDetails = bro4u_DataManager.sharedInstance.address[0]{
//            
//            address_id = "\(addressData.addressId!)" //Need to use later
//            email = "\(addressData.email!)" //Need to use later
//            latitude = "\(addressData.lattitude)"
//            longitude = "\(addressData.longitude)"
//            mobile = "\(addressData.phoneNumber)"
//            customer_name = "\(addressData.name)"
//            
//        }
        
        
        
        let params = "?user_id=\(user_id)&total_cost=\(total_cost)&service_time=\(service_time)&service_date=\(service_date)&selection=\(selection)&grand_total=\(grand_total)&night_delivery_charge=\(night_delivery_charge)&customer_name=\(customer_name)&vendor_id=\(vendor_id)&custom_message=\(custom_message)&address_id=\(address_id)&email=\(email)&mobile=\(mobile)&item_id=\(item_id)&payment_wallet=\(payment_wallet)&coupon=\(coupon)&imei=\(imei)&cat_id=\(cat_id)&latitude=\(latitude)&longitude=\(longitude)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kPlaceCashOnDeliveryIndex , params:params, result:{(resultObject) -> Void in
            
            print(" COD Order Data Received")
            
            self.getDataOfThanksScreen(resultObject as! String)
            print(resultObject)
        })
    }
    
    func getDataOfThanksScreen(result:String)
    {
        if result  == "Success"
        {
            
            var user_id = ""
            var order_id = ""

            if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
                
                user_id = loginInfoData.userId! //Need to use later
                
            }
            if let orderID = bro4u_DataManager.sharedInstance.orderId{
                
                order_id = orderID //Need to use later
                
            }

            
            //user_id = "15"
            let params = "?order_id=\(order_id)&user_id=\(user_id)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(kOrderConfirmedIndex , params:params, result:{(resultObject) -> Void in
                
                print(" Order Confirmed  Data Received")
                
                print(resultObject)
                b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
                self.configureUI()
                
            })

        }
        
    }


    @IBAction func actionOngoingOrder(sender: AnyObject) {
    }

    @IBAction func actioonContinueShopping(sender: AnyObject) {
    }
    
    func configureUI()
    {
        confirmedOrder =  bro4u_DataManager.sharedInstance.orderData[0]

        topView.hidden = false
        middleView.hidden = false
        downView.hidden = false
        btnContinue.hidden = false

        
        if let vendorName = confirmedOrder!.vendorName
        {
            self.lblServiceProvide.text = vendorName
        }
        if let categoryName = confirmedOrder!.catName
        {
            self.lblService.text = categoryName
        }
        if let serviceDate = confirmedOrder!.serviceDate
        {
            self.lblServiceDate.text = serviceDate
        }
        if let serviceTime = confirmedOrder!.serviceTime
        {
            self.lblTimeSlot.text = serviceTime
        }
        if let vendorImageUrl = confirmedOrder!.profilePic
        {
            self.imgViewServiceProvider.downloadedFrom(link:vendorImageUrl, contentMode:UIViewContentMode.ScaleToFill)
        }
        if let orderID = confirmedOrder!.orderID
        {
            self.lblOrderId.text = "#\(orderID)"
        }
        if let orderStatus = confirmedOrder!.statusDesc
        {
            self.lblServiceStatus.text = orderStatus
        }
        if let price = confirmedOrder!.finalTotal //Need to check Key
        {
            self.lblAmount.text = "Rs. \(price).00"
        }
        if let orderedaAT = confirmedOrder!.timestamp //Need to check Key
        {
            self.lblAmount.text = orderedaAT
        }

        
    }

    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }

}
