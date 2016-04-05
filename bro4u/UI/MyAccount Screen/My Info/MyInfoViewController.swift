//
//  MyInfoViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyInfoViewController: UIViewController {

  @IBOutlet var nameTxtFld: UITextField!
  @IBOutlet var mobileNoTxtFld: UITextField!
  @IBOutlet var emailTxtFld: UITextField!
  @IBOutlet var maleBtn: UIButton!
  @IBOutlet var femaleBtn: UIButton!
  @IBOutlet var dateBtn: UIButton!
  @IBOutlet var userNameLbl: UILabel!
  @IBOutlet var userImageView: UIImageView!
  
  var myInfoModelArr:[b4u_MyInfoModel] = Array()

  
  @IBAction func dateBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func maleBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func femaleBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func updateBtnAction(sender: AnyObject) {
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

        
        let userId = bro4u_DataManager.sharedInstance.loginInfo!.userId!
        
        let params = "?user_id=\(userId)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyInfoIndex, params:params, result:{(resultObject) -> Void in
            
            print("My Info Data Received")
            
            print(resultObject)
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

            self.updateUI()
        })
    }
    
    
    func updateUI()
    {
        if let myInfoDetailModel = bro4u_DataManager.sharedInstance.myInfoData.first
        {
    
             self.nameTxtFld.text = myInfoDetailModel.fullName!
             self.mobileNoTxtFld.text = myInfoDetailModel.mobile!
             self.emailTxtFld.text = myInfoDetailModel.email!

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
