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
    
    
    
    var addressModel:b4u_AddressDetails?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
     
        

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
        
        addressModel = b4u_AddressDetails()
        
        var user_id = ""
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            user_id = loginInfoData.userId! //Need to use later
        }

//        let user_id = "1"
        let streetName = tfFullAddress.text
        let locality = tfCurrentPlace.text
        let cityId = "5"
        let name = tfYourName.text
        let mobile = tfMobileNumber.text
        var email = ""
        
        if  tfEmail.text!.isEmail
        {
            email =  tfEmail.text!
        }
        
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
  
        
        
        addressModel?.name  = name!
        addressModel?.email  = email
        addressModel?.phoneNumber  = mobile!

        addressModel?.fullAddress  = streetName!
        addressModel?.curretPlace  = locality!
        
        
        let params = "?user_id=\(user_id)&street_name=\(streetName!)&locality=\(locality!)&city_id=\(cityId)&name=\(name!)&latitude=\(latitude)&longitude=\(longitude)&mobile=\(mobile!)&email=\(email)"
        
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
            bro4u_DataManager.sharedInstance.address.append(self.addressModel!)
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
//                self.btnCurrentLocation.setTitle("\(subLocality),\(loclity)", forState:.Normal)
                
            }
            
        }else
        {
//            self.btnCurrentLocation.setTitle("Current Location", forState:.Normal)
            
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
