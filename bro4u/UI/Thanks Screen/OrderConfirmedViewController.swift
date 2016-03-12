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
        
        self.getData()
        
    }
    
    func getData()
    {
        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyInfoIndex, params:"", result:{(resultObject) -> Void in
            
            print("My Info Data Received")
            
            print(resultObject)
            
            self.congigureUI()
            
            
        })
    }
    
    
    func congigureUI()
    {
        
        for (_ , mainData) in bro4u_DataManager.sharedInstance.myInfoData.enumerate()
        {
            
            
            if let filteredData = self.filterContent(mainData)
            {
                //                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("b4uCategoryTableView") as! b4u_CategoryTblViewCtrl
                
                let vc =  self.storyboard?.instantiateViewControllerWithIdentifier("MyInfoViewControllerID") as! MyInfoViewController
                
                vc.myInfoModelArr = filteredData
            }
        }
        
    }
    
    //Need to Implement
    private func filterContent(mainModelObj:b4u_MyInfoModel) -> [b4u_MyInfoModel]?
    {
        let filteredItems:[b4u_MyInfoModel]?
        if bro4u_DataManager.sharedInstance.myInfoData.count > 0
        {
            
            return nil
            
        }else
        {
            return nil
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

}
