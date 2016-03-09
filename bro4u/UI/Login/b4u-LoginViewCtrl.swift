//
//  b4u-LoginViewCtrl.swift
//  bro4u
//
//  Created by Tools Team India on 15/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class b4u_LoginViewCtrl: UIViewController ,GIDSignInDelegate,GIDSignInUIDelegate ,UITextFieldDelegate{
    @IBOutlet weak var tfEnerMobileNumber: UITextField!

   
    @IBOutlet var fbLoginButton: FBSDKLoginButton!

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self

        FBSDKSettings.setAppID("194765280880394")
    }
    @IBOutlet weak var btnOTPLogin: UIButton!

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
        
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func goBtnClicked(sender: AnyObject)
    {
        // ?req_id=10&device_id=asdfasdf&mobile=9740201846

        if self.tfEnerMobileNumber.tag == 1
        {
            let phoneNo = tfEnerMobileNumber.text!
            
            if  phoneNo.validPhoneNumber
            {
                let reqId = 10
                
                let deviceId = b4u_Utility.getUUIDFromVendorIdentifier
                
                let params =  "?req_id=\(reqId)&device_id=\(deviceId)&mobile=\(phoneNo)"
                
                b4u_WebApiCallManager.sharedInstance.getApiCall(kOTPlogin, params:params, result:{(resultObject) -> Void in
                    
                    if resultObject as! String == "Success"
                    {
                        self.tfEnerMobileNumber.placeholder = "Enter OTP Received"
                        self.tfEnerMobileNumber.tag = 2
                    }else
                    {
                        
                    }
                    
                })
            }else
            {
                print("phone number is not valid")
            }
            
        }else if self.tfEnerMobileNumber.tag == 2
        {
            
        }
        
    }
    
    //Google Sign In
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let name = user.profile.name
                let email = user.profile.email
                // ...
            } else {
                
            }
    }
    
    @IBAction func btnOTPLoginClicked(sender: AnyObject)
    {
        self.btnOTPLogin.hidden = true
    }
    
}


extension b4u_LoginViewCtrl : FBSDKLoginButtonDelegate {
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        print("loginButtonWillLogin")
        return true
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("didCompleteWithResult")
    }
}
