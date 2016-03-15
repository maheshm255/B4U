//
//  MyWalletViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyWalletViewController: UIViewController {

  @IBOutlet var couponcodeTxtFld: UITextField!
  @IBOutlet var walletImageView: UIImageView!
  @IBOutlet var walletMoneyLbl: UILabel!
  
  var myModelArr:[b4u_MyWalletModel] = Array()
  var indicatorcolor:UIView!

  @IBAction func applyBtnAction(sender: AnyObject) {
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.getData()
        
      }
    
    func getData()
    {

      if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
        
        var filedName = loginInfoData.userId! //Need to use later
        
       }
    
    
    let params = "?user_id=\(1)"
    b4u_WebApiCallManager.sharedInstance.getApiCall(kMyWalletIndex , params:params, result:{(resultObject) -> Void in
    
    print(" Wallet Balance Data Received")
    
    print(resultObject)
    
    self.congigureUI()
    
    })
    
    
   }

    func congigureUI()
    {

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
