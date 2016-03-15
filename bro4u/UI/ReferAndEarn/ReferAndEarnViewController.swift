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
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            var filedName = loginInfoData.userId! //Need to use later

        }
        
        
        let params = "?user_id=\(1)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReferAndEarnIndex , params:params, result:{(resultObject) -> Void in
            
            print(" Refer And Earn Data Received")
            
            print(resultObject)
            
            self.congigureUI()

        })

        
     }
    
    func congigureUI()
    {
        if let referAndEarnData = bro4u_DataManager.sharedInstance.referAndEarnData
        {
            shareTextLbl.text = "Share this code to gift your friend Rs. \(referAndEarnData.offerAmount!) and you earn Rs. \(referAndEarnData.referralAmount!) on their first service experience. Keep refering to earn a lot of free service"
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
