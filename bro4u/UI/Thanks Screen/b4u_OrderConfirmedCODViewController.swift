//
//  b4u_OrderConfirmedCODViewController.swift
//  bro4u
//
//  Created by Rahul on 08/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit
import CoreLocation

class b4u_OrderConfirmedCODViewController: UIViewController  , createOrderDelegate{

    var confirmedOrder:b4u_OrdersModel?
    var whyOnlineText:b4u_WhyOnlineModel?

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
      
        
        if let orderId = b4u_Utility.sharedInstance.getUserDefault("order_id")
        {
            
            let orderID = Int(orderId as! String)
            bro4u_DataManager.sharedInstance.orderId = NSNumber(integer:orderID!)
            self.getDataOfThanksScreen("Success")

        }else
        {
            b4u_Utility.sharedInstance.activityIndicator.startAnimating()
            let createOrderObj = b4u_CreateOrder()
            createOrderObj.paymentType  = kCODPayment
            createOrderObj.delegate = self
            createOrderObj.createOrder()
            topView.hidden = true
            middleView.hidden = true
            downView.hidden = true
            btnContinue.hidden = true
        }
//        if (b4u_Utility.sharedInstance.getUserDefault("order_id") != nil) {
//            
//         
//            
//        }
//        else
//        {
//          b4u_Utility.sharedInstance.activityIndicator.startAnimating()
//          let createOrderObj = b4u_CreateOrder()
//          createOrderObj.paymentType  = kCODPayment
//          createOrderObj.delegate = self
//          createOrderObj.createOrder()
//          topView.hidden = true
//          middleView.hidden = true
//          downView.hidden = true
//          btnContinue.hidden = true
//        }

        lblServiceStatus.layer.borderWidth = 1.0
        lblServiceStatus.layer.borderColor = UIColor.lightGrayColor().CGColor
      
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loginDismissed", name:kUserDataReceived, object:nil);

      let backButton = UIBarButtonItem(title: "< Back", style: .Plain, target: self, action:"doneBtnPressed")
        
      navigationItem.leftBarButtonItem = backButton
      
      b4u_Utility.shadowEffectToView(middleView)
      b4u_Utility.shadowEffectToView(downView)


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
  
  func doneBtnPressed() {
    navigationController?.popToRootViewControllerAnimated(true)
  }
    

  
    func getDataOfThanksScreen(result:String)
    {
        if result  == "Success"
        {
          
            var user_id = ""
            var order_id = ""

            if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
                
                user_id = loginInfoData.userId!
                
            }
            if let orderID = bro4u_DataManager.sharedInstance.orderId{
                
                order_id = "\(orderID)"
                
            }
          
            //Setting Order ID in User Default
            b4u_Utility.sharedInstance.setUserDefault(order_id, KeyToSave:"order_id")

            let params = "?order_id=\(order_id)&user_id=\(user_id)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(kOrderConfirmedIndex , params:params, result:{(resultObject) -> Void in
                
                print(" Order Confirmed  Data Received")
                
                print(resultObject)
                
                self.updateCODPaymentStatus(order_id)

                self.configureUI()
                
                b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            })

        }
        
    }


    func updateCODPaymentStatus(orderId : String)
    {
        
        let params = "/\(orderId)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kUpdateCODStatuspendingIndex , params:params, result:{(resultObject) -> Void in
            
            
            if resultObject as! String == "Success"
            {
                print(" COD Order Status Updated Successfully")

            }else
            {
                print("COD Update Status Fail")
            }
            
        })
    }

    @IBAction func actionOngoingOrder(sender: AnyObject) {
    
//      self.performSegueWithIdentifier("OrderConfirmToMyOrdersID", sender:nil)

     }

    @IBAction func actioonContinueShopping(sender: AnyObject) {
    
      //self.performSegueWithIdentifier("OrderConfirmToHomeCategoriesID", sender:nil)

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
            
            
            self.imgViewServiceProvider.layer.cornerRadius = self.imgViewServiceProvider.frame.size.width / 2 ;
            self.imgViewServiceProvider.layer.masksToBounds = false;
            
            self.imgViewServiceProvider.layer.borderWidth = 0.21;
            self.imgViewServiceProvider.layer.borderColor = UIColor.blackColor().CGColor;
            self.imgViewServiceProvider.clipsToBounds = true

        }
        if let orderID = confirmedOrder!.orderID
        {
            self.lblOrderId.text = "#\(orderID)"
        }
        if let orderStatus = confirmedOrder!.statusDesc
        {
            self.lblServiceStatus.text = orderStatus
        }
        if let price = confirmedOrder!.totalCost //Need to check Key
        {
            self.lblAmount.text = "Rs. \(price).00"
        }
        if let orderedAT = confirmedOrder!.timestamp //Need to check Key
        {
            self.lblOrderedAt.text = "Ordered At \(orderedAT)"
        }
        
        
        if bro4u_DataManager.sharedInstance.whyOnlineData.count > 0
        {
            whyOnlineText =  bro4u_DataManager.sharedInstance.whyOnlineData[0]
            
            if let text1 = whyOnlineText!.text1 //Need to check Key
            {
                self.lblOnlineAdvantage1.text = text1
            }
            if let text2 = whyOnlineText!.text2 //Need to check Key
            {
                self.lblOnlineAdvantage2.text = text2
            }
            if let text3 = whyOnlineText!.text3 //Need to check Key
            {
                self.lblOnlineAdvantage3.text = text3
            }
        }
      
      //Remove Order ID from User Default
      b4u_Utility.sharedInstance.setUserDefault(nil, KeyToSave:"order_id")


    }

    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
  
  
    func hasOrderCreated(resultObject:String)
    {
      self.getDataOfThanksScreen(resultObject)
    }

}
