//
//  b4u-AddAddressCtrl.swift
//  bro4u
//
//  Created by Mac on 19/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_AddAddressCtrl: UIViewController,locationDelegate {

    
    @IBOutlet weak var tfCurrentPlace: UITextField!
    @IBOutlet weak var tfCurrentLocation: UITextField!
    @IBOutlet weak var tfFullAddress: UITextField!
    @IBOutlet weak var imgViewAddressSelected: UIImageView!
    
    
    @IBOutlet weak var tfMobileNumber: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfYourName: UITextField!
    @IBOutlet weak var imgViewContactInfoSelected: UIImageView!
    
    var selectedCity:b4u_Cities?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tfCurrentPlace.enabled = false
        self.tfCurrentLocation.enabled = false
        self.getCities()
    }

    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        if let placeObj = bro4u_DataManager.sharedInstance.currentLocality
        {
            if let locality = placeObj.locality , subLocality = placeObj.subLocality
            {
                tfCurrentLocation.text  = locality
                tfCurrentPlace.text  =   subLocality
            }
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getCities()
    {
        b4u_WebApiCallManager.sharedInstance.getApiCall(kGetCities, params:"", result:{(resultObject) -> Void in
            
            print("city received")
            
            
            self.updateUI()
        })
    }
    
    
    func updateUI()
    {
        if bro4u_DataManager.sharedInstance.cities.count > 0
        {
            self.selectedCity = bro4u_DataManager.sharedInstance.cities.first
            
            if let logoinInfo = bro4u_DataManager.sharedInstance.loginInfo
            {
                if let name = logoinInfo.fullName
                {
                    self.tfYourName.text = name
                }
                if let phone = logoinInfo.mobile
                {
                    self.tfMobileNumber.text = phone
                }
                if let email = logoinInfo.email
                {
                    self.tfEmail.text = email
                }
            }
            
            self.tfCurrentPlace.text = self.selectedCity!.cityName!
        }
    }

    @IBAction func btnCancelPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func BtnSaveAddressPressed(sender: AnyObject)
    {
        
        
        var user_id = ""
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            user_id = loginInfoData.userId! //Need to use later
        }
        
        
        guard let name = tfYourName.text where name != "" else{
            self.view.makeToast(message:"Please Enter Name", duration:1.0, position:HRToastPositionDefault)
            return
        }
        
        guard let email = tfEmail.text where email != "" else{
            self.view.makeToast(message:"Please Enter Email Id", duration:1.0, position:HRToastPositionDefault)
            return
        }
        
        guard let mobile = tfMobileNumber.text where mobile != "" else{
            self.view.makeToast(message:"Please Enter Mobile Number", duration:1.0, position:HRToastPositionDefault)
            return
        }
        
        let streetName = tfFullAddress.text
        let locality = tfCurrentPlace.text
        let cityId =  self.selectedCity!.cityId!
        
        var latitude:String = "12.213"
        var longitude:String = "66.234"
        //        if let  currentLocaiton = bro4u_DataManager.sharedInstance.currenLocation
        //        {
        //             latitude = "\(currentLocaiton.coordinate.latitude)"
        //             longitude = "\(currentLocaiton.coordinate.longitude)"
        //
        //            addressModel?.currentLocation  = currentLocaiton
        //
        //        }
        
        
        
        
        
        let params = "?user_id=\(user_id)&street_name=\(streetName!)&locality=\(locality!)&city_id=\(cityId)&name=\(name)&latitude=\(latitude)&longitude=\(longitude)&mobile=\(mobile)&email=\(email)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kSaveAddress, params:params, result:{(resultObject) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.updateUI(resultObject as! String)
            })
            
        })
    }
    
    func updateUI(result:String)
    {
        if result == "Success"
        {
            self.dismissViewControllerAnimated(true, completion:nil)
            
        }else
        {
            print("Server Not Able to save the address")
        }
    }
    // MARK: TextField Delegate Methods
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField)
    {
        if textField == tfCurrentLocation
        {
            self.performSegueWithIdentifier("locationCtrlSegue1", sender:nil)
            
        }
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        return true
    }
    func textFieldDidEndEditing(textField: UITextField)
    {
        textField.resignFirstResponder()
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        //        if (textField.text!.length >= CASE_SUBJECT_MAX_LENGTH && range.length == 0)
        //        {
        //            return false // return NO to not change text
        //        }
        //        else
        //        {
        return true
        // }
        //return !(string == " ")
    }
    func textFieldShouldClear(textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        
        return true;
    }
    
    
    
    func userSelectedLocation(locationStr:String)
    {
        
    }
    
    func userCurrentLocaion()
    {
        if let currentLocality = bro4u_DataManager.sharedInstance.currentLocality
        {
            if let loclity = currentLocality.locality , subLocality = currentLocality.subLocality
            {
                self.tfCurrentLocation.text = "\(subLocality),\(loclity)"
            }
        }else
        {
            self.tfCurrentLocation.text = "Current Location"
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "locationCtrlSegue1"
        {
            
            bro4u_DataManager.sharedInstance.locationSearchPredictions.removeAll()
            let locatinCtrlObj = segue.destinationViewController as! b4u_LocationViewCtrl
            
            locatinCtrlObj.delegate = self
        }
    }


}
