//
//  b4u-QuickBookOrderCtrl.swift
//  bro4u
//
//  Created by Mac on 22/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_QuickBookOrderCtrl: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var btnBookRequest: UIButton!
    @IBOutlet weak var tfMobileNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tfName.keyboardType = UIKeyboardType.Alphabet
        tfMobileNumber.keyboardType = UIKeyboardType.NumberPad
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
    
    override func viewWillAppear(animated: Bool) {
        
        if  let loginInfo = bro4u_DataManager.sharedInstance.loginInfo
        {
            if let phoneNumber = loginInfo.mobile
            {
                self.tfMobileNumber.text = phoneNumber
            }
            
            if let name = loginInfo.fullName
            {
                self.tfName.text = name
            }
        }
    }
    @IBAction func cancelBtnClicked(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
    }

    @IBAction func btnBookRequestClicked(sender: AnyObject)
    {
        
        //?name=Harshal&mobile=9740201846&address=kasturi+nagar+bangalore&latitude=33.4534&longitude=23.34434&service_date=21-1-2016&service_time=12PM-2PM&imei=398454&cat_id=12&user_id=3&selection=[{%22field_name%22:%22option_value%22,%22field_name%22:%22option_value%22}]
        
    
        guard  let name =   self.tfName.text where name != "" else
        {
            self.view.makeToast(message:"Please Enter Name", duration:1.0, position: HRToastPositionDefault)
           return
        }
        guard let mobileNum =  self.tfMobileNumber.text where mobileNum != "" else
        {
            self.view.makeToast(message:"Please Enter Mobile Number", duration:1.0, position: HRToastPositionDefault)
            return
        }
        
        
        var userId = ""
        
        if let userInfor = bro4u_DataManager.sharedInstance.loginInfo
        {
            userId = userInfor.userId!
        }
        let address = "aa" // TO DO
        let latt = "17.1"  // TO DO
        let long = "88.0" //  TO DO
        let serviceDate =  NSDate.dateFormat().stringFromDate(bro4u_DataManager.sharedInstance.selectedDate!)
        let serviceTime = bro4u_DataManager.sharedInstance.selectedTimeSlot!
        let imei = b4u_Utility.getUUIDFromVendorIdentifier()
        let selection = bro4u_DataManager.sharedInstance.selectedFilterSelectionInJsonFormat
        
        
        let params = "?name=\(name)&mobile=\(mobileNum)&address=\(address)&latitude=\(latt)&longitude=\(long)&service_date=\(serviceDate)&service_time=\(serviceTime)&imei=\(imei)&user_id=\(userId)&selection=\(selection!)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kQuickOrderBook, params:params, result:{(resultObject) -> Void in
            
            self.dismissViewControllerAnimated(true, completion:nil)
            
        })
    }
}
