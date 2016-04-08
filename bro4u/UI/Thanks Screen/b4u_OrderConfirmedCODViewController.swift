//
//  b4u_OrderConfirmedCODViewController.swift
//  bro4u
//
//  Created by Rahul on 08/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OrderConfirmedCODViewController: UIViewController {

    var order_id:String?
    var currentOrder: b4u_OrdersModel?

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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addLoadingIndicator()
        currentOrder =  bro4u_DataManager.sharedInstance.orderData[0]
        

        self.getData()

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
    
    
    func getData()
    {
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        var user_id = ""
        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            user_id = loginInfoData.userId! //Need to use later
            
        }
        
        //user_id = "15"
        let params = "?order_id=\(currentOrder?.orderID)&user_id=\(user_id)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kOrderConfirmedIndex , params:params, result:{(resultObject) -> Void in
            
            print(" Order Confirmed  Data Received")
            
            print(resultObject)
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            self.congigureUI()
            
        })
    }


    @IBAction func actionOngoingOrder(sender: AnyObject) {
    }

    @IBAction func actioonContinueShopping(sender: AnyObject) {
    }
    
    func congigureUI()
    {
        
        
        if let vendorName = currentOrder!.vendorName
        {
            self.lblServiceProvide.text = vendorName
        }
        if let categoryName = currentOrder!.catName
        {
            self.lblService.text = categoryName
        }
        if let serviceDate = currentOrder!.serviceDate
        {
            self.lblServiceDate.text = serviceDate
        }
        if let serviceTime = currentOrder!.serviceTime
        {
            self.lblTimeSlot.text = serviceTime
        }
        if let vendorImageUrl = currentOrder!.profilePic
        {
            self.imgViewServiceProvider.downloadedFrom(link:vendorImageUrl, contentMode:UIViewContentMode.ScaleToFill)
        }
        if let orderID = currentOrder!.orderID
        {
            self.lblOrderId.text = "#\(orderID)"
        }
        if let orderStatus = currentOrder!.statusDesc
        {
            self.lblServiceStatus.text = orderStatus
        }
        if let price = currentOrder!.finalTotal //Need to check Key
        {
            self.lblAmount.text = "Rs. \(price).00"
        }
        if let orderedaAT = currentOrder!.timestamp //Need to check Key
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
