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
  
  @IBOutlet weak var walletBalanceTableView: UITableView!

  var myModelArr:[b4u_MyWalletModel] = Array()
  var indicatorcolor:UIView!

  @IBAction func applyBtnAction(sender: AnyObject) {
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

      var user_id = ""
      if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
        
        user_id = loginInfoData.userId! //Need to use later
        
       }
    
    
    let params = "?user_id=\(1)"
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
  
  @IBAction func cancelBtnClicked(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion:nil)
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


}
