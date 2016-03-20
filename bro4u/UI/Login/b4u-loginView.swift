//
//  b4u-loginView.swift
//  bro4u
//
//  Created by Mac on 20/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

import FBSDKLoginKit


class b4u_loginView: UIView ,FBSDKLoginButtonDelegate ,GIDSignInDelegate,GIDSignInUIDelegate{

    
    var fbLoginBtn:FBSDKLoginButton?
    var googleSignBtn:GIDSignInButton?
    var otpLoginBtn:UIButton?

    
    var lblOr:UILabel?
    var lblLoginUsing:UILabel?
    
    var tfEnterMogileNumber:UITextField?
    var btnGo:UIButton?
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        addBehavior()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addBehavior (){
        print("Add all the behavior here")
        
        
       
        self.addGoogleSingIn()
        self.addFBfbLoginBtn()
        self.addLabels()
        self.addOTPLoginBtn()
        
        
    }
    
    func addLabels()
    {
        lblLoginUsing = UILabel();
        lblLoginUsing?.text = "LOGIN USING"
        lblLoginUsing?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lblLoginUsing!)
        
        
        let horizontalConstraint = NSLayoutConstraint(item: lblLoginUsing!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: lblLoginUsing!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.fbLoginBtn, attribute: NSLayoutAttribute.Top , multiplier:1, constant: -20)
        self.addConstraint(verticalConstraint)
        

        lblOr = UILabel();
        lblOr?.text = "OR"
        lblOr?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lblOr!)
        
        
        let lblhorizontalConstraint = NSLayoutConstraint(item: lblOr!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(lblhorizontalConstraint)
        
        let lblverticalConstraint = NSLayoutConstraint(item: lblOr!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.googleSignBtn, attribute: NSLayoutAttribute.Bottom , multiplier:1, constant:20)
        self.addConstraint(lblverticalConstraint)

    }
    
    func addOTPLoginBtn()
    {
        otpLoginBtn = UIButton(type: UIButtonType.System)
        otpLoginBtn?.setTitle("OTP LOGIN", forState:UIControlState.Normal)
        otpLoginBtn?.translatesAutoresizingMaskIntoConstraints = false
        otpLoginBtn?.addTarget(self, action:"otpBtnClicked", forControlEvents:UIControlEvents.TouchUpInside)
        self.addSubview(otpLoginBtn!)
        
        
        let horizontalConstraint = NSLayoutConstraint(item: otpLoginBtn!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: otpLoginBtn!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.googleSignBtn, attribute: NSLayoutAttribute.Bottom , multiplier:1, constant: 20)
        self.addConstraint(verticalConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: otpLoginBtn!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 250)
        self.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: otpLoginBtn!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        self.addConstraint(heightConstraint)
        
        
        
//        tfEnterMogileNumber = UITextField()
//        tfEnterMogileNumber?.placeholder = "Enter mobile number"
//        
//        tfEnterMogileNumber?.translatesAutoresizingMaskIntoConstraints = false
        
    
    }
    
    func otpBtnClicked()
    {
        
    }
    func addGoogleSingIn()
    {
        googleSignBtn = GIDSignInButton()
        
        googleSignBtn!.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(googleSignBtn!);
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
        
        let horizontalConstraint = NSLayoutConstraint(item: googleSignBtn!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: googleSignBtn!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        self.addConstraint(verticalConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: googleSignBtn!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 250)
        self.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: googleSignBtn!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        self.addConstraint(heightConstraint)
        
    }
    func addFBfbLoginBtn()
    {
       fbLoginBtn  = FBSDKLoginButton(type:UIButtonType.System)
        
        fbLoginBtn!.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(fbLoginBtn!);
        
        
        
        let horizontalConstraint = NSLayoutConstraint(item: fbLoginBtn!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: fbLoginBtn!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.googleSignBtn, attribute: NSLayoutAttribute.Top, multiplier: 1, constant:-20)
        self.addConstraint(verticalConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: fbLoginBtn!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 250)
        self.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: fbLoginBtn!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        self.addConstraint(heightConstraint)
        
        
        FBSDKSettings.setAppID("194765280880394")
        
        fbLoginBtn!.delegate = self
        fbLoginBtn!.readPermissions = ["public_profile"]
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
        
//        self.getFaceBookProfileInfo()
//        
//        delegate?.loginFailed()
    }
    
    
    //MARKS: GOOGLE SIGN IN
    
    
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
                
               // self.disMissSelf()
                // ...
            } else {
                
                bro4u_DataManager.sharedInstance.loginInfo = nil
                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"False")
                
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
}
