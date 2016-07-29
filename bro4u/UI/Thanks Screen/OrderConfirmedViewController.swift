//
//  OrderConfirmedViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 01/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class OrderConfirmedViewController: UIViewController {

  @IBOutlet var bro4ULogoImageView: UIImageView!
  @IBOutlet var headerLbl: UILabel!
  @IBOutlet var subHeaderLbl: UILabel!

  @IBOutlet var vendorImageView: UIImageView!
  @IBOutlet var titleLbl: UILabel!
  @IBOutlet var subTitleLbl: UILabel!
  @IBOutlet var dateLbl: UILabel!
  @IBOutlet var timeSlotLbl: UILabel!
  @IBOutlet var orderIDLbl: UILabel!
  @IBOutlet var serviceStatusLbl: UILabel!
  @IBOutlet var orderedAtDateLbl: UILabel!
  @IBOutlet var amountLbl: UILabel!
  @IBOutlet var lblCallBro4U: UILabel!
  
  @IBOutlet weak var topView: UIView!
  @IBOutlet weak var downView: UIView!
  @IBOutlet weak var btnContinue: UIButton!

    var order_id:String?
    var confirmedOrder:b4u_OrdersModel?

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
      self.addLoadingIndicator()
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()
      topView.hidden = true
      downView.hidden = true
      btnContinue.hidden = true
    
      serviceStatusLbl.layer.borderWidth = 1.0
      serviceStatusLbl.layer.borderColor = UIColor.lightGrayColor().CGColor

      self.getData()

        let backButton = UIBarButtonItem(title: "< Back", style: .Plain, target: self, action:"doneBtnPressed")
        
      navigationItem.leftBarButtonItem = backButton
      
      
      b4u_Utility.shadowEffectToView(topView)
      b4u_Utility.shadowEffectToView(downView)

      
    }
  
  func doneBtnPressed() {
    navigationController?.popToRootViewControllerAnimated(true)
  }
    
//    func getData()
//    {
//
//        var user_id = ""
//        
//        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
//            
//            user_id = loginInfoData.userId!
//            
//        }
//        if let orderID = bro4u_DataManager.sharedInstance.orderId{
//            
//            order_id = "\(orderID)"
//            
//        }
//        
//        let params = "?order_id=\(order_id!)&user_id=\(user_id)&\(kAppendURLWithApiToken)"
//        b4u_WebApiCallManager.sharedInstance.getApiCall(kOrderConfirmedIndex , params:params, result:{(resultObject) -> Void in
//            
//            print(" Order Confirmed for Online Data Received")
//            
//            print(resultObject)
//            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
//            self.congigureUI()
//            
//        })
//    }
  
    func getData()
    {
      //2. Checking for Network reachability
      
      if(AFNetworkReachabilityManager.sharedManager().reachable){
        
        var user_id = ""
        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
          
          user_id = loginInfoData.userId!
          
        }
        if let orderID = bro4u_DataManager.sharedInstance.orderId{
          
          order_id = "\(orderID)"
          
        }
        
        let params = "?order_id=\(order_id!)&user_id=\(user_id)&\(kAppendURLWithApiToken)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kOrderConfirmedIndex , params:params, result:{(resultObject) -> Void in
          
          print(" Order Confirmed for Online Data Received")
          
          print(resultObject)
          b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
          self.congigureUI()
          
        })
        //3.Remove observer if any remain
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
        
      }else{
        //4. First Remove any existing Observer
        //Add Observer for No network Connection
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderConfirmedViewController.getData), name: "NoNetworkConnectionNotification", object: nil)
        
        //5.Adding View for Retry
        let noNetworkView = NoNetworkConnectionView(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.height))
        self.view.addSubview(noNetworkView)
        
        return
      }
    }
  
    func congigureUI()
    {
      
        confirmedOrder =  bro4u_DataManager.sharedInstance.orderData[0]

        topView.hidden = false
        downView.hidden = false
        btnContinue.hidden = false

        if let vendorName = confirmedOrder!.vendorName
        {
            self.titleLbl.text = vendorName
        }
        if let categoryName = confirmedOrder!.catName
        {
            self.subTitleLbl.text = categoryName
        }
        if let serviceDate = confirmedOrder!.serviceDate
        {
            self.dateLbl.text = serviceDate
        }
        if let serviceTime = confirmedOrder!.serviceTime
        {
            self.timeSlotLbl.text = serviceTime
        }
        if let vendorImageUrl = confirmedOrder!.profilePic
        {
            self.vendorImageView.downloadedFrom(link:vendorImageUrl, contentMode:UIViewContentMode.ScaleToFill)
            
            self.vendorImageView.layer.cornerRadius = self.vendorImageView.frame.size.width / 2 ;
            self.vendorImageView.layer.masksToBounds = false;
            
            self.vendorImageView.layer.borderWidth = 0.5;
            self.vendorImageView.layer.borderColor = UIColor.blackColor().CGColor;
            self.vendorImageView.clipsToBounds = true

        }
        if let orderID = confirmedOrder!.orderID
        {
            self.orderIDLbl.text = "#\(orderID)"
        }
        if let orderStatus = confirmedOrder!.statusDesc
        {
            self.serviceStatusLbl.text = orderStatus
        }
        if let price = confirmedOrder!.finalTotal //Need to check Key
        {
            self.amountLbl.text = "Rs. \(price).00"
        }
        if let orderedAT = confirmedOrder!.timestamp //Need to check Key
        {
            self.orderedAtDateLbl.text = "Ordered At \(orderedAT)"
        }

      //Remove Order ID from User Default
      b4u_Utility.sharedInstance.setUserDefault(nil, KeyToSave:"order_id")
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
  
  @IBAction func callBro4uAction(sender: AnyObject) {
  }
  
  
  @IBAction func payOnlineAction(sender: AnyObject) {
  }
  
  
  @IBAction func checkOtherServicesAction(sender: AnyObject) {
    
  }

  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }


}
