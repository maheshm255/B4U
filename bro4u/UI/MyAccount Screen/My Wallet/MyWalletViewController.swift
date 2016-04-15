//
//  MyWalletViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyWalletViewController: UIViewController ,UITextFieldDelegate {

  @IBOutlet var couponcodeTxtFld: UITextField!
  @IBOutlet var walletImageView: UIImageView!
  @IBOutlet var walletMoneyLbl: UILabel!
  
  @IBOutlet weak var walletBalanceTableView: UITableView!

  var myModelArr:[b4u_MyWalletModel] = Array()
  var indicatorcolor:UIView!

 
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.couponcodeTxtFld.delegate = self
        // Do any additional setup after loading the view.
      self.addLoadingIndicator()

        self.getData()
        
      }
    
    func getData()
    {
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        var user_id = ""
        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            user_id = loginInfoData.userId! //Need to use later
            
        }
        
        //user_id = "1"
        
        
        let params = "?user_id=\(user_id)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyWalletIndex , params:params, result:{(resultObject) -> Void in
            
            print(" Wallet Balance Data Received")
            
            print(resultObject)
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            self.congigureUI()
            
        })
        
        
   }

    func congigureUI()
    {
       walletBalanceTableView .reloadData()
        
        if let walletBalance =   bro4u_DataManager.sharedInstance.walletBalanceData
        {
            self.walletMoneyLbl.text = "\(walletBalance)"
        }
    }
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return bro4u_DataManager.sharedInstance.myWalletData.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let textCellIdentifier = "MyWalletTableViewCellID"
    let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! b4u_MyWalletTableViewCell
    
    let myWalletModel:b4u_MyWalletModel = bro4u_DataManager.sharedInstance.myWalletData[indexPath.section]
    
    cell.configureData(myWalletModel)
    
    cell.layer.borderWidth = 1.0
    cell.layer.borderColor = UIColor.grayColor().CGColor
    
    
    return cell
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 95.0
    }
  
  @IBAction func cancelBtnClicked(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func applyBtnAction(sender: AnyObject)
    {
     
        
        guard let referelCode = couponcodeTxtFld.text where referelCode != ""else
        {
            self.view.makeToast(message:"Please enter coupon code", duration:1.0, position:HRToastPositionDefault)
            return
        }
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        var user_id = ""
        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            user_id = loginInfoData.userId! //Need to use later
            
        }
        
        //user_id = "1"
        
        
        let params = "?user_id=\(user_id)&device_id=\(b4u_Utility.getUUIDFromVendorIdentifier())&referral_code=\(referelCode)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kApplyWalletCouponIndex , params:params, result:{(resultObject) -> Void in
            
              b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

            
               if resultObject as! String == "Success"
               {
                  self.view.makeToast(message:"Referrel code applied successfully", duration:1.0, position:HRToastPositionDefault)
               }else
               {
                self.view.makeToast(message:"Please enter valid code", duration:1.0, position:HRToastPositionDefault)

              }
            
        })
        
    }
    func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }

  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
    if section == 0
    {
      return 1.0;
    }
    else
    {
      return 10.0;
    }
    
  }


    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
