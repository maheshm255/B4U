//
//  b4u-AddAddressTableViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit


class b4u_AddAddressTableViewController: UITableViewController ,locationDelegate {

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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
     
        self.tfCurrentPlace.enabled = false
        self.tfCurrentLocation.enabled = true
        self.getCities()
        

    }

    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
       
        if let placeObj = bro4u_DataManager.sharedInstance.currentLocality
        {
            if let locality = placeObj.locality , subLocality = placeObj.subLocality
            {                
                tfCurrentPlace.text  =   subLocality
                if let customAddress =  bro4u_DataManager.sharedInstance.userSelectedLocatinStr
                {
                   tfCurrentLocation.text  =   customAddress
                    
                }else{
                    

                }
            }
            
        }
      
      self.tfFullAddress?.becomeFirstResponder()
      self.checkAllfieldsHasValueOrNot()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkAllfieldsHasValueOrNot()
    {
      if (tfYourName.text?.length > 0 && tfEmail.text?.length > 0 && tfMobileNumber.text?.length > 0)
      {
        imgViewContactInfoSelected.image = UIImage(named: "shareGreen")
      }
      else
      {
        imgViewContactInfoSelected.image = UIImage(named: "shareGray")
      }
      
      if (tfFullAddress.text?.length > 0 && tfCurrentLocation.text?.length > 0 && tfCurrentPlace.text?.length > 0)
      {
        imgViewAddressSelected.image = UIImage(named: "shareGreen")
      }
      else
      {
        imgViewAddressSelected.image = UIImage(named: "shareGray")
        
      }

    }
  
    func checkAllfieldsAfterEditing(range: NSRange, tfString: NSString, forTextField: UITextField)
      {
        
        if(forTextField == tfYourName || forTextField == tfEmail || forTextField == tfMobileNumber)
        {
          
          if (range.location > 0)
          {
            imgViewContactInfoSelected.image = UIImage(named: "shareGreen")
          }
          else if(range.location == 0 && tfString.length > 0)
          {
            imgViewContactInfoSelected.image = UIImage(named: "shareGreen")
          }
          else
          {
            imgViewContactInfoSelected.image = UIImage(named: "shareGray")
            
          }
        }
        else
        {
          if (range.location > 0)
          {
            imgViewAddressSelected.image = UIImage(named: "shareGreen")
          }
          else if(range.location == 0 && tfString.length > 0)
          {
            imgViewAddressSelected.image = UIImage(named: "shareGreen")
          }
          else
          {
            imgViewAddressSelected.image = UIImage(named: "shareGray")

          }

        }
        
        
      }


   func getCities()
    {
        let params = "?\(kAppendURLWithApiToken)"
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
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        let locality = tfCurrentLocation.text
        let cityId =  self.selectedCity!.cityId!
        
        var latitude:String = "12.213"
        var longitude:String = "66.234"
        if let  currentLocaiton = bro4u_DataManager.sharedInstance.currenLocation
        {
            latitude = "\(currentLocaiton.coordinate.latitude)"
            longitude = "\(currentLocaiton.coordinate.longitude)"

        }
        
        
        let params = "?user_id=\(user_id)&street_name=\(streetName!)&locality=\(locality!)&city_id=\(cityId)&name=\(name)&latitude=\(latitude)&longitude=\(longitude)&mobile=\(mobile)&email=\(email)&\(kAppendURLWithApiToken)"
        
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
  
  //this method gets called just before textfield gets active.
  
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        return true
    }
  
  //this method gets called when the textfield active.
    func textFieldDidBeginEditing(textField: UITextField)
    {
       if textField == tfCurrentLocation
       {
           self.performSegueWithIdentifier("locationCtrlSegue1", sender:nil)

        }
    }
  
  //this method gets called before the textfield becomes inactive.
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        return true
    }
  
  //this method gets called when the textfield becomes inactive.
    func textFieldDidEndEditing(textField: UITextField)
    {
        textField.resignFirstResponder()
    }
  
  //this method gets called when while typing every single character before its displayed.
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
//        if (textField.text!.length >= CASE_SUBJECT_MAX_LENGTH && range.length == 0)
//        {
//            return false // return NO to not change text
//        }
//        else
//        {
      
      self.checkAllfieldsAfterEditing(range,tfString: string,forTextField:textField)

      
            return true
       // }
        //return !(string == " ")
    }
  
  //this method gets called when the clear button pressed.
    func textFieldShouldClear(textField: UITextField) -> Bool
    {
        return true;
    }

    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
      self.view.endEditing(true)
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
