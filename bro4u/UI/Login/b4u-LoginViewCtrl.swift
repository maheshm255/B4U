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

        
      //  GIDSignIn.sharedInstance().signOut()
        
        
        FBSDKSettings.setAppID("194765280880394")
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile"]

       // fbLoginButton.
       // FBSDKLoginManager().logOut()


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
                        self.tfEnerMobileNumber.text = ""
                    }else
                    {
                        print("Fail to generate OPT")
                    }
                    
                })
            }else
            {
                print("phone number is not valid")
            }
            
        }else if self.tfEnerMobileNumber.tag == 2
        {
            if let userEnterOTP = self.tfEnerMobileNumber.text ,loginInfo = bro4u_DataManager.sharedInstance.loginInfo
            {
                
                if userEnterOTP == loginInfo.otp!
                {
                   print("Login Success")
                    
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLogined")
                    
                    self.dismissViewControllerAnimated(true, completion:nil)
                }
                else
                {
                    print("Wrong OTP Entered")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey:"False")

                }
            }
        }
        
    }
    
    //Google Sign In
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                
                
                let loginInfoObj = b4u_LoginInfo()
                
                loginInfoObj.userId = user.userID
                loginInfoObj.googleAuthToken = user.authentication.idToken
                loginInfoObj.fullName = user.profile.name
                loginInfoObj.email = user.profile.email
                loginInfoObj.loginType = "googleSignIn"
                
                bro4u_DataManager.sharedInstance.loginInfo = loginInfoObj
                
                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLogined")
                self.dismissViewControllerAnimated(true, completion:nil)

                // ...
            } else {
                
                bro4u_DataManager.sharedInstance.loginInfo = nil
                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"False")

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
        
        self.getFaceBookProfileInfo()
    }


func getFaceBookProfileInfo()
{
    let requestMe:FBSDKGraphRequest = FBSDKGraphRequest(graphPath:"me", parameters:nil)
    let graphRequestConnection:FBSDKGraphRequestConnection  = FBSDKGraphRequestConnection()
    
    graphRequestConnection.addRequest(requestMe, completionHandler:({ (connection, result, error) -> Void in
        
        if ((error) != nil)
        {
            // Process error
            print("Error: \(error)")
        }
        else
        {
            
            print(result) // This works
          
           print(FBSDKAccessToken.currentAccessToken())
            
            let loginInfoObj = b4u_LoginInfo()
            
            loginInfoObj.userId = result.valueForKey("id")as! String!
            //loginInfoObj.googleAuthToken = user.authentication.idToken
            loginInfoObj.fullName = result.valueForKey("name") as! String
        //    loginInfoObj.email = user.profile.email
            loginInfoObj.loginType = "facebook"
            
            bro4u_DataManager.sharedInstance.loginInfo = loginInfoObj
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLogined")
            self.dismissViewControllerAnimated(true, completion:nil)
            
            
        }
        }))
    
    
    graphRequestConnection.start()
}

}
