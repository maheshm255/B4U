//
//  b4u-loginView.swift
//  bro4u
//
//  Created by Mac on 20/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

import FBSDKLoginKit

protocol loginViewDelegate
{
    func loginSuccessFull()
    func loginFailed()
    
}

class b4u_loginView: UIView ,FBSDKLoginButtonDelegate ,GIDSignInDelegate,GIDSignInUIDelegate ,UITextFieldDelegate{

    
    @IBOutlet weak var fbloginBtn: FBSDKLoginButton!
    @IBOutlet weak var btnGoogleSing: GIDSignInButton!
    @IBOutlet weak var btnOTP: UIButton!

    @IBOutlet weak var tfOTPNumber: UITextField!
    @IBOutlet weak var goBtnClicked: UIButton!
    
    
    var loginForm:loginFormScreen?
    
    var delegate:loginViewDelegate?


    override init (frame : CGRect) {
        super.init(frame : frame)
        
      //  self.setup()
    }
    

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!


    }
    
    
    func setup() {
        
        
        self.addLoadingIndicator()
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // FB Button Settiing
        FBSDKSettings.setAppID("194765280880394")
        
        fbloginBtn!.delegate = self
        fbloginBtn!.readPermissions = ["public_profile", "email", "user_friends"]//["public_profile","email"]
        
        tfOTPNumber.keyboardType = UIKeyboardType.NumberPad
    }
    
    
    
    @IBAction func goBtnClicked(sender: AnyObject)
    {
        // ?req_id=10&device_id=asdfasdf&mobile=9740201846
        
        if self.tfOTPNumber.tag == 1
        {
            let phoneNo = tfOTPNumber.text!
            
            if  phoneNo.validPhoneNumber
            {
                let reqId = 10
                
                let deviceId = b4u_Utility.getUUIDFromVendorIdentifier
                
                let params =  "?req_id=\(reqId)&device_id=\(deviceId)&mobile=\(phoneNo)&\(kAppendURLWithApiToken)"
                
                b4u_WebApiCallManager.sharedInstance.getApiCall(kOTPlogin, params:params, result:{(resultObject) -> Void in
                    
                    if resultObject as! String == "Success"
                    {
                        self.tfOTPNumber.placeholder = "Enter OTP Received"
                        self.tfOTPNumber.tag = 2
                        self.tfOTPNumber.text = ""
                    }else
                    {
                        print("Fail to generate OPT")
                    }
                    
                })
            }else
            {
                print("phone number is not valid")
            }
            
        }else if self.tfOTPNumber.tag == 2
        {
            if let userEnterOTP = self.tfOTPNumber.text ,loginInfo = bro4u_DataManager.sharedInstance.loginInfo
            {
                
                if userEnterOTP == loginInfo.otp!
                {
                    print("Login Success")
                    
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLogined")
                    
                    
                    let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(bro4u_DataManager.sharedInstance.loginInfo!)

                    
                    NSUserDefaults.standardUserDefaults().setObject(archivedObject, forKey:"loginInfo")
                    //self.disMissSelf()
                    
                    tfOTPNumber.resignFirstResponder()
                    delegate?.loginSuccessFull()
                }
                else
                {
                    print("Wrong OTP Entered")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey:"False")
                    //TODO remove nsuderdefaultloginobject
                    delegate?.loginFailed()
                    
                }
            }
        }
        
    }
    
    @IBAction func OtpBntClicked(sender: AnyObject)
    {
        self.btnOTP.hidden = true
        
    }
   
   

    func addBehavior (){
        print("Add all the behavior here")
    }
    

    
    //MARKS: FB Delegates
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
        let requestMe:FBSDKGraphRequest = FBSDKGraphRequest(graphPath:"me", parameters:["fields": "id, name, first_name, last_name, email"])
        let graphRequestConnection:FBSDKGraphRequestConnection  = FBSDKGraphRequestConnection()
        
        graphRequestConnection.addRequest(requestMe, completionHandler:({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
                
                self.delegate?.loginFailed()

            }
            else
            {
                
                print(result) // This works
                
                print(FBSDKAccessToken.currentAccessToken())
                
                let loginInfoObj = b4u_LoginInfo()
                
                loginInfoObj.userId = result.valueForKey("id")as! String!
                //loginInfoObj.googleAuthToken = user.authentication.idToken
                loginInfoObj.fullName = result.valueForKey("name") as? String
                loginInfoObj.email = result.valueForKey("email") as? String
                loginInfoObj.firstName = result.valueForKey("first_name") as? String
                loginInfoObj.lastName = result.valueForKey("last_name") as? String

                loginInfoObj.loginType = "facebook"
                
                bro4u_DataManager.sharedInstance.loginInfo = loginInfoObj
                
                self.delegate?.loginSuccessFull()

                
            }
        }))
        
        
        graphRequestConnection.start()
    }

    
    
    //MARKS: GOOGLE SIGN IN
    
    
    //Google Sign In
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                
                let url = NSURL(string:  "https://www.googleapis.com/oauth2/v3/userinfo?access_token=\(user.authentication.accessToken)")
                
                
                b4u_Utility.sharedInstance.activityIndicator.startAnimating()

                let session = NSURLSession.sharedSession()
                session.dataTaskWithURL(url!) {(data, response, error) -> Void in
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    do {
                        let userData = try NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? [String:AnyObject]
                        /*
                        Get the account information you want here from the dictionary
                        Possible values are
                        "id": "...",
                        "email": "...",
                        "verified_email": ...,
                        "name": "...",
                        "given_name": "...",
                        "family_name": "...",
                        "link": "https://plus.google.com/...",
                        "picture": "https://lh5.googleuserco...",
                        "gender": "...",
                        "locale": "..."
                        
                        so in my case:
                        */
                        let loginInfoObj = b4u_LoginInfo()
                        loginInfoObj.userId = user.userID
                        loginInfoObj.googleAuthToken = user.authentication.idToken
                        loginInfoObj.fullName = user.profile.name
                        loginInfoObj.email = user.profile.email
                        loginInfoObj.loginType = "googleSignIn"
                        
                        loginInfoObj.firstName = userData!["given_name"] as? String
                        loginInfoObj.lastName = userData!["family_name"] as? String
                        
                        bro4u_DataManager.sharedInstance.loginInfo = loginInfoObj
                        
                        self.delegate?.loginSuccessFull()
                        
                        
                        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

                        
                    } catch {
                        NSLog("Account Information could not be loaded")
                        
                        bro4u_DataManager.sharedInstance.loginInfo = nil
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey:"False")
                        self.delegate?.loginFailed()
                        
                        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()


                    }
                    }.resume()
                
                
                
           
                // ...
            } else {
                
                bro4u_DataManager.sharedInstance.loginInfo = nil
                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"False")
                
                delegate?.loginFailed()
            }
    }

    
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        
          if let respontCtrl = self.getResponderController()
          {
            respontCtrl.presentViewController(viewController, animated:true, completion:nil)
        }
        
    }
    
    func getResponderController()->UIViewController?
    {
        var responder = self.nextResponder()
        
        while (responder != nil)
        {
            if responder is UIViewController
            {
                let respondCtrl = responder as! UIViewController
                
                return respondCtrl
            }
            
            responder = responder!.nextResponder()
        }
        return nil
    }
    
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        
            viewController.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    internal func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.

    {
        textField.resignFirstResponder()
        return true
    }
  
  
    
    func addLoadingIndicator () {
        self.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.center
    }
    
}
