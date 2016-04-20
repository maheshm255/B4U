//
//  MyInfoViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyInfoViewController: UIViewController ,UITextFieldDelegate {

  @IBOutlet var nameTxtFld: UITextField!
  @IBOutlet var mobileNoTxtFld: UITextField!
  @IBOutlet var emailTxtFld: UITextField!
  @IBOutlet var maleBtn: UIButton!
  @IBOutlet var femaleBtn: UIButton!
  @IBOutlet var dateBtn: UIButton!
  @IBOutlet var userNameLbl: UILabel!
  @IBOutlet var userImageView: UIImageView!
  
  var myInfoModelArr:[b4u_MyInfoModel] = Array()

  
    
    var gender:String = "male"
    

  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.addLoadingIndicator()

        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
        
      self.getData()

    }
  
    func getData()
    {
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        
        let userId = bro4u_DataManager.sharedInstance.loginInfo!.userId!
        
        let params = "?user_id=\(userId)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyInfoIndex, params:params, result:{(resultObject) -> Void in
            
            print("My Info Data Received")
            
            print(resultObject)
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

            self.updateUI()
        })
    }
    
    
    func didTapView(){
        self.view.endEditing(true)
    }
    func updateUI()
    {
        if let myInfoDetailModel = bro4u_DataManager.sharedInstance.myInfoData.first
        {
    
             self.nameTxtFld.text = myInfoDetailModel.fullName!
             self.mobileNoTxtFld.text = myInfoDetailModel.mobile!
             self.emailTxtFld.text = myInfoDetailModel.email!
             self.userNameLbl.text = myInfoDetailModel.fullName!
            
            if let gender = myInfoDetailModel.gender
            {
                if gender == "male"
                {
                    self.maleBtn.setBackgroundImage(UIImage(named:"radioBlue"), forState:.Normal)
                    self.femaleBtn.setBackgroundImage(UIImage(named:"radioGray"), forState:.Normal)
                }else
                {
                    self.maleBtn.setBackgroundImage(UIImage(named:"radioGray"), forState:.Normal)
                    self.femaleBtn.setBackgroundImage(UIImage(named:"radioBlue"), forState:.Normal)
                }
            }
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
  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }


    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func dateBtnAction(sender: AnyObject) {
    }
    
    
    @IBAction func maleBtnAction(sender: AnyObject)
    {
        gender = "male"
        
        self.maleBtn.setBackgroundImage(UIImage(named:"radioBlue"), forState:.Normal)
        self.femaleBtn.setBackgroundImage(UIImage(named:"radioGray"), forState:.Normal)
        
    }
    
    
    @IBAction func femaleBtnAction(sender: AnyObject) {
        
        gender = "female"
        
        self.maleBtn.setBackgroundImage(UIImage(named:"radioGray"), forState:.Normal)
        self.femaleBtn.setBackgroundImage(UIImage(named:"radioBlue"), forState:.Normal)
    }
    
    
    @IBAction func updateBtnAction(sender: AnyObject)
    {
        
        //index.php/my_account/update_user_account?user_id=1&email=akshay.hh@gmail.com&mobile=34564564&name=test&dob=2015-12-13&gender=male
        //Update My Info Window
        
        guard let userName = self.nameTxtFld.text where userName != "" else
        {
            self.view.makeToast(message:"Please enter your name", duration:1.0, position: HRToastPositionDefault)
            return
        }
        
        guard let phoneNumber = self.mobileNoTxtFld.text where phoneNumber.validPhoneNumber  else
        {
            self.view.makeToast(message:"Please enter your mobile number", duration:1.0, position: HRToastPositionDefault)
            return
        }
        
        guard let emailId = self.emailTxtFld.text where emailId != "" else
        {
            self.view.makeToast(message:"Please enter your email id", duration:1.0, position: HRToastPositionDefault)
            return
        }
        
        let dateOfBirth = ""
        
        let params = "?user_id=\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)&email=\(emailId)&mobile=\(phoneNumber)&name=\(userName)&dob=\(dateOfBirth)&gender=\(gender)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyAccountUpdateProfileIndex, params:params, result:{(resultObject) -> Void in
            
            
            if resultObject as! String == "Success"
            {
                self.view.makeToast(message:"Information updated successfully", duration:1.0, position: HRToastPositionDefault)
            }else
            {
                self.view.makeToast(message:"Not able to update the information ,Please try again!", duration:1.0, position: HRToastPositionDefault)
                
            }
        })
        
        
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        if textField == self.mobileNoTxtFld{
            return newLength <= 10 // Bool
        }
        
//        let aSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
//        let compSepByCharInSet = string.componentsSeparatedByCharactersInSet(aSet)
//        let numberFiltered = compSepByCharInSet.joinWithSeparator("")
//        return string == numberFiltered
        
        
        return true
        
    }
    
        
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}
