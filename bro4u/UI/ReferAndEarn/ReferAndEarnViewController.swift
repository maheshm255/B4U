//
//  ReferAndEarnViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 04/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class ReferAndEarnViewController: UIViewController {

  @IBOutlet var codeShareLbl: UILabel!
  @IBOutlet var shareTextLbl: UILabel!
  
  @IBAction func TAndCAction(sender: AnyObject) {
  }
  
  
  @IBAction func referFriendsAction(sender: AnyObject) {
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

    @IBAction func cancelBtnClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
}
