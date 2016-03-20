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

        // Do any additional setup after loading the view.
//        
//        var configureError: NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
//        assert(configureError == nil, "Error configuring Google services: \(configureError)")
//        
//        GIDSignIn.sharedInstance().delegate = self
//        
//        GIDSignIn.sharedInstance().uiDelegate = self
//
//        
//      //  GIDSignIn.sharedInstance().signOut()
//        
//        
//        FBSDKSettings.setAppID("194765280880394")
//        
//        fbLoginButton.delegate = self
//        fbLoginButton.readPermissions = ["public_profile"]

       // fbLoginButton.
       // FBSDKLoginManager().logOut()

     //   FBSDKLoginManager().fromViewController = nil;
        
        
        loginView  =  UINib(nibName: "b4u-loginView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as? b4u_loginView
        
        loginView!.frame = self.view.bounds
        loginView!.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        
        self.view.addSubview(loginView!)
        
        loginView?.setup()
        
        loginView?.delegate = self
        
//       loginView = b4u_loginView()
//        
//        loginView!.translatesAutoresizingMaskIntoConstraints = false
//
//       loginView!.backgroundColor = UIColor.redColor();
//        self.view.addSubview(loginView!);
//       
//        
//        let constX:NSLayoutConstraint = NSLayoutConstraint(item: loginView!, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0);
//        self.view.addConstraint(constX);
//        //
//        //
//        let constY:NSLayoutConstraint = NSLayoutConstraint(item: loginView!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0);
//        self.view.addConstraint(constY);
//        //
//        //
//        let constTrayling:NSLayoutConstraint = NSLayoutConstraint(item: loginView!, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0);
//        self.view.addConstraint(constTrayling);
//        //
//        //
//        let constBottom:NSLayoutConstraint = NSLayoutConstraint(item: loginView!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0);
//        self.view.addConstraint(constBottom);
        

    }
    
    
    func loginSuccessFull()
    {
        NSNotificationCenter.defaultCenter().postNotificationName(kLoginDismissed, object:nil)

      self.dismissViewControllerAnimated(true, completion:nil)
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
}
//    @IBAction func goBtnClicked(sender: AnyObject)
//    {
//        // ?req_id=10&device_id=asdfasdf&mobile=9740201846
//
//        if self.tfEnerMobileNumber.tag == 1
//        {
//            let phoneNo = tfEnerMobileNumber.text!
//            
//            if  phoneNo.validPhoneNumber
//            {
//                let reqId = 10
//                
//                let deviceId = b4u_Utility.getUUIDFromVendorIdentifier
//                
//                let params =  "?req_id=\(reqId)&device_id=\(deviceId)&mobile=\(phoneNo)"
//                
//                b4u_WebApiCallManager.sharedInstance.getApiCall(kOTPlogin, params:params, result:{(resultObject) -> Void in
//                    
//                    if resultObject as! String == "Success"
//                    {
//                        self.tfEnerMobileNumber.placeholder = "Enter OTP Received"
//                        self.tfEnerMobileNumber.tag = 2
//                        self.tfEnerMobileNumber.text = ""
//                    }else
//                    {
//                        print("Fail to generate OPT")
//                    }
//                    
//                })
//            }else
//            {
//                print("phone number is not valid")
//            }
//            
//        }else if self.tfEnerMobileNumber.tag == 2
//        {
//            if let userEnterOTP = self.tfEnerMobileNumber.text ,loginInfo = bro4u_DataManager.sharedInstance.loginInfo
//            {
//                
//                if userEnterOTP == loginInfo.otp!
//                {
//                   print("Login Success")
//                    
//                    NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLogined")
//                    
//                        self.disMissSelf()
//                }
//                else
//                {
//                    print("Wrong OTP Entered")
//                    NSUserDefaults.standardUserDefaults().setBool(true, forKey:"False")
//
//                }
//            }
//        }
//        
//    }
//    
//    //Google Sign In
//    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
//        withError error: NSError!) {
//            if (error == nil) {
//                // Perform any operations on signed in user here.
//                
//                
//                let loginInfoObj = b4u_LoginInfo()
//                
//                loginInfoObj.userId = user.userID
//                loginInfoObj.googleAuthToken = user.authentication.idToken
//                loginInfoObj.fullName = user.profile.name
//                loginInfoObj.email = user.profile.email
//                loginInfoObj.loginType = "googleSignIn"
//                
//                bro4u_DataManager.sharedInstance.loginInfo = loginInfoObj
//                
//                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLogined")
//
//                self.disMissSelf()
//                // ...
//            } else {
//                
//                bro4u_DataManager.sharedInstance.loginInfo = nil
//                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"False")
//
//            }
//    }
//    
//    @IBAction func btnOTPLoginClicked(sender: AnyObject)
//    {
//        self.btnOTPLogin.hidden = true
//    }
//    
//    
//    func disMissSelf()
//    {
//        switch self.loginForm
//        {
//        case  loginFormScreen.kRightMenu :
//            
//        self.dismissViewControllerAnimated(true, completion:nil)
//
//        case  loginFormScreen.kPaymentScreen :
//            
//            delegate?.proceedToDelivery()
//            
//            print("payment screen")
//        case  loginFormScreen.kNone :
//            print("Logint from not set")
//
//        }
//
//    }
//}
//
//
//extension b4u_LoginViewCtrl : FBSDKLoginButtonDelegate {
//    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
//        print("loginButtonWillLogin")
//        
//        return true
//    }
//    
//    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
//        print("loginButtonDidLogOut")
//    }
//    
//    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        print("didCompleteWithResult")
//        
//        self.getFaceBookProfileInfo()
//        
//        delegate?.loginFailed()
//    }
//
//
//func getFaceBookProfileInfo()
//{
//    let requestMe:FBSDKGraphRequest = FBSDKGraphRequest(graphPath:"me", parameters:nil)
//    let graphRequestConnection:FBSDKGraphRequestConnection  = FBSDKGraphRequestConnection()
//    
//    graphRequestConnection.addRequest(requestMe, completionHandler:({ (connection, result, error) -> Void in
//        
//        if ((error) != nil)
//        {
//            // Process error
//            print("Error: \(error)")
//        }
//        else
//        {
//            
//            print(result) // This works
//          
//           print(FBSDKAccessToken.currentAccessToken())
//            
//            let loginInfoObj = b4u_LoginInfo()
//            
//            loginInfoObj.userId = result.valueForKey("id")as! String!
//            //loginInfoObj.googleAuthToken = user.authentication.idToken
//            loginInfoObj.fullName = result.valueForKey("name") as? String
//        //    loginInfoObj.email = user.profile.email
//            loginInfoObj.loginType = "facebook"
//            
//            bro4u_DataManager.sharedInstance.loginInfo = loginInfoObj
//            
//            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLogined")
//            self.disMissSelf()
//            
//        }
//        }))
//    
//    
//    graphRequestConnection.start()
//}
//
    
    
//}
