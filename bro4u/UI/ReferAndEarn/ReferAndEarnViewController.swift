//
//  ReferAndEarnViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 04/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class ReferAndEarnViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var imgViewGift: UIImageView!
    @IBOutlet var codeShareLbl: UILabel!
    @IBOutlet var shareTextLbl: UILabel!
    
    @IBOutlet weak var viewUserNotLoggedIn: UIView!
    
    @IBOutlet weak var btnTandC: UIButton!
    
    @IBOutlet weak var btnReferFriends: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loginDismissed", name:kUserDataReceived, object:nil);
        
        // Do any additional setup after loading the view.
        self.validateUser()
    }
    
    
    func validateUser()
    {
        self.hideElements(true)
        
        let isUserLoggedIn =   NSUserDefaults.standardUserDefaults().objectForKey("isUserLogined")
        
        if let hasLogin:Bool = isUserLoggedIn as? Bool
        {
            if hasLogin
            {
                self.viewUserNotLoggedIn.hidden = true
                
                self.getData()
                
            }
        }else
        {
            self.viewUserNotLoggedIn.hidden = false
            self.hideElements(true)
        }
    }
    
    func hideElements(isHide:Bool)
    {
        self.imgViewGift.hidden = isHide
        self.codeShareLbl.hidden = isHide
        self.shareTextLbl.hidden = isHide
        self.btnTandC.hidden = isHide
        self.btnReferFriends.hidden = isHide
        
    }
    func getData()
    {
        self.hideElements(false)
        self.addLoadingIndicator()
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        var user_id = ""
        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            user_id = loginInfoData.userId! //Need to use later
            
        }
        
        //user_id = "1"
        
        let params = "?user_id=\(user_id)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReferAndEarnIndex , params:params, result:{(resultObject) -> Void in
            
            print(" Refer And Earn Data Received")
            
            print(resultObject)
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            self.congigureUI()
            
        })
        
        
    }
    
    func congigureUI()
    {
        
        
        //For UnderLine Button Text
        
        let attrs = [NSUnderlineStyleAttributeName : 1]
        let attributedString = NSMutableAttributedString(string:"")
        
        let buttonTitleStr = NSMutableAttributedString(string:"T & C", attributes:attrs)
        attributedString.appendAttributedString(buttonTitleStr)
        btnTandC.setAttributedTitle(attributedString, forState: .Normal)

        codeShareLbl.layer.borderWidth = 2.0
        codeShareLbl.layer.borderColor =
            UIColor(red: 59/255.0, green: 189/255.0, blue: 255/255.0, alpha: 1.0).CGColor

        
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
    
//    @IBAction func cancelBtnClicked(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion:nil)
//    }
    
    
    
    
    @IBAction func TAndCAction(sender: AnyObject) {
        self.showAlertView()
        
    }
    
    @IBAction func referFriendsAction(sender: AnyObject)
    {
        if let referAndEarnData = bro4u_DataManager.sharedInstance.referAndEarnData
        {
            let textToShare = "Just gave you Rs. \(referAndEarnData.offerAmount!) to try your first service on Bro4u- The Home Service App. Use Code \(codeShareLbl.text)"
            let myWebsite = NSURL(string: "https://www.google.gl/58X0oJ")
            let itemArr : NSArray = [textToShare,myWebsite!]
            let shareCntrlr = UIActivityViewController(activityItems: itemArr as [AnyObject], applicationActivities: nil)
            presentViewController(shareCntrlr, animated: true, completion: nil)
        }
    }
    
    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
    
    func showAlertView()
    {
        let storyboard : UIStoryboard = self.storyboard!
        
       let alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("Term_ConditionViewControllerID") as! B4u_Term_ConditionViewController
        
        alertViewCtrl.modalPresentationStyle = .Popover
        alertViewCtrl.preferredContentSize = CGSizeMake(300, 250)
        // quickBookViewCtrl.delegate = self
        
        let popoverMenuViewController = alertViewCtrl.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.frame),
            y: CGRectGetMidY(self.view.frame),
            width: 1,
            height: 1)
        presentViewController(
            alertViewCtrl,
            animated: true,
            completion: nil)
        
    }
    
    @IBAction func btnOkClicked(sender: AnyObject)
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.performSegueWithIdentifier("referloginSegue", sender:nil)
        })
    }
    
    func loginDismissed()
    {
        self.validateUser()
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
}
