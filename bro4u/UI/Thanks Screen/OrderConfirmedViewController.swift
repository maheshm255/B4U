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
  
  
  
  @IBAction func callBro4uAction(sender: AnyObject) {
  }
  
  
  @IBAction func payOnlineAction(sender: AnyObject) {
  }
  
  
  @IBAction func checkOtherServicesAction(sender: AnyObject) {
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
      self.addLoadingIndicator()

        self.getData()
        
    }
    
    func getData()
    {
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            var filedName = loginInfoData.userId! //Need to use later
            
        }
        
        let user_id = 15
        let order_id = 8765
        let params = "?order_id=\(order_id)&user_id=\(user_id)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kOrderConfirmedIndex , params:params, result:{(resultObject) -> Void in
            
            print(" Order Confirmed  Data Received")
            
            print(resultObject)
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            self.congigureUI()
            
        })
    }
    
    
    func congigureUI()
    {
        
        let currentOrder =  bro4u_DataManager.sharedInstance.orderData[0]

        if let vendorName = currentOrder.vendorName
        {
            self.titleLbl.text = vendorName
        }
        if let categoryName = currentOrder.catName
        {
            self.subTitleLbl.text = categoryName
        }
        if let serviceDate = currentOrder.serviceDate
        {
            self.dateLbl.text = serviceDate
        }
        if let serviceTime = currentOrder.serviceTime
        {
            self.timeSlotLbl.text = serviceTime
        }
        if let serviceTime = currentOrder.serviceTime
        {
            self.timeSlotLbl.text = serviceTime
        }
        if let vendorImageUrl = currentOrder.profilePic
        {
            self.vendorImageView.downloadedFrom(link:vendorImageUrl, contentMode:UIViewContentMode.ScaleToFill)
        }
        if let orderID = currentOrder.orderID
        {
            self.orderIDLbl.text = "#\(orderID)"
        }
        if let orderStatus = currentOrder.statusDesc
        {
            self.serviceStatusLbl.text = orderStatus
        }
        if let price = currentOrder.finalTotal //Need to check Key
        {
            self.amountLbl.text = "Rs. \(price).00"
        }

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
  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }


}
