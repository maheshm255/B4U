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
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReferAndEarnIndex, params:"", result:{(resultObject) -> Void in
            
            print(" Refer And Earn Data Received")
            
            print(resultObject)
            
            self.congigureUI()
            
            
        })
    }
    
    
    
    
    
    func congigureUI()
    {
        if let referAndEarnDetails = bro4u_DataManager.sharedInstance.referAndEarnData
        {
            self.codeShareLbl.text = "\( referAndEarnDetails.walletBalance!)"
            self.shareTextLbl.text = referAndEarnDetails.fullName
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
