//
//  b4u-LoginViewCtrl.swift
//  bro4u
//
//  Created by Tools Team India on 15/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit
import FBSDKLoginKit

protocol loginDelegate
{
    func proceedToDelivery()
    
    func loginFailed()

}

class b4u_LoginViewCtrl: UIViewController ,loginViewDelegate {
    @IBOutlet weak var tfEnerMobileNumber: UITextField!

   
    @IBOutlet var fbLoginButton: FBSDKLoginButton!

    var loginForm:loginFormScreen = loginFormScreen.kNone
    var delegate:loginDelegate?
    
     var loginView:b4u_loginView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        
        loginView  =  UINib(nibName: "b4u-loginView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as? b4u_loginView
        
        loginView!.frame = self.view.bounds
        loginView!.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        
        self.view.addSubview(loginView!)
        
        loginView?.setup()
        
        loginView?.delegate = self
        

        

    }
    
    func loginSuccessFull()
    {
        
        self.getData()
    
    }
    func loginFailed()
    {
        NSNotificationCenter.defaultCenter().postNotificationName(kLoginDismissed, object:nil)

        self.dismissViewControllerAnimated(true, completion:nil)

    }
    @IBOutlet weak var btnOTPLogin: UIButton!

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       // loginView!.addBehavior()
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

    @IBAction func btnCancelClicked(sender: AnyObject) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(kLoginDismissed, object:nil)

        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    func getData()
    {
        
        //?req_id=3&email=harshal.zope1990%40gmail.com&first_name=Harshal&last_name=Zope&image=%22https%3A%2F%2Fgraph.facebook.com%2F836148279808264%2Fpicture%3Ftype%3Dlarge%22

        if let loginInfoObj = bro4u_DataManager.sharedInstance.loginInfo
        {
            if loginInfoObj.loginType != "OTP"
            {
                
                let reqId =   "3"
                let email =   loginInfoObj.email
                let firstName  = loginInfoObj.firstName
                let lastName =   loginInfoObj.lastName
                let image = ""
                
                let params = "?req_id=\(reqId)&email=\(email!)&first_name=\(firstName!)&last_name=\(lastName!)&image=\(image)"
                
                b4u_WebApiCallManager.sharedInstance.getApiCall(kSocialLogin, params:params, result:{(resultObject) -> Void in
                    
                    print("login user Data Received")
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(kLoginDismissed, object:nil)
                    
                  
                    let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(bro4u_DataManager.sharedInstance.loginInfo!)

                    
                NSUserDefaults.standardUserDefaults().setObject(archivedObject, forKey:"loginInfo")
                    
                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLogined")

                    NSNotificationCenter.defaultCenter().postNotificationName(kUserDataReceived, object:nil)

                    self.dismissViewControllerAnimated(true, completion:nil)
                    
                })
            }else
            {
                NSNotificationCenter.defaultCenter().postNotificationName(kUserDataReceived, object:nil)

                
                NSNotificationCenter.defaultCenter().postNotificationName(kLoginDismissed, object:nil)

                self.dismissViewControllerAnimated(true, completion:nil)

            }
        }
        
        
 
    }
}

