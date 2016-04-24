//
//  b4u-IntermediateViewCtrl.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_IntermediateViewCtrl: UIViewController {
    
    @IBOutlet weak var imgViewHrSep: UIImageView!
    @IBOutlet weak var imgViewBanner: UIImageView!
     @IBOutlet weak var imgViewIcon3: UIImageView!
    @IBOutlet weak var imgViewIcon2: UIImageView!
    @IBOutlet weak var imgViewIcon1: UIImageView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage1: UILabel!
    @IBOutlet weak var lblMessage3: UILabel!
    @IBOutlet weak var lblMessage2: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblOfferMessage: UILabel!
    @IBOutlet weak var lblCoupan: UILabel!
    
    
    @IBOutlet weak var btnTermsAndConditions: UIButton!
    @IBOutlet weak var btnTapToCopy: UIButton!
    @IBOutlet weak var btnContinue: UIButton!

    var selectedCategoryObj:b4u_Category?
    
    var selectedImgSlide:b4u_SliderImage?
    
    var selectedAttributeOption:b4u_AttributeOptions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.btnTapToCopy.layer.cornerRadius = 2.0
        self.btnTapToCopy.layer.borderColor = UIColor(red:210.0/255, green: 210.0/255, blue: 210.0/255, alpha: 1.0).CGColor
        self.btnTapToCopy.layer.borderWidth = 1.0
        
        self.btnTapToCopy.layer.shadowColor =  UIColor(red:210.0/255, green: 210.0/255, blue: 210.0/255, alpha: 1.0).CGColor
        
        scrollView.hidden = true
        btnContinue.hidden = true
        self.addLoadingIndicator()

        self.callInterMediateApi()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cleanSelection()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cleanSelection()
    {
        bro4u_DataManager.sharedInstance.selectedDate = nil
        bro4u_DataManager.sharedInstance.selectedTimeSlot = nil
        bro4u_DataManager.sharedInstance.userSelectedFilterParams = nil
    }
    @IBAction func tAndCBtnClicked(sender: AnyObject)
    {
        // TO DO
        
        let alerController = UIAlertController(title:"Terms & Conditions", message:"", preferredStyle:.Alert)
        
        
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("tAndCtrl") as! b4u_termsAndCondViewController
        alerController.setValue(controller, forKey:"contentViewController")
        
        
        let alertAction = UIAlertAction(title:"Got IT!", style:UIAlertActionStyle.Default, handler: {(alertAction)-> Void in
            
            
            alerController.dismissViewControllerAnimated(true, completion:nil)
        })
        
        alerController.addAction(alertAction)
        
        self.presentViewController(alerController, animated:true, completion:nil)
    }
    
    @IBAction func tapToCopyBtnClicked(sender: AnyObject)
    {
        //TO DO
        
        bro4u_DataManager.sharedInstance.copiedCopunCode = self.lblCoupan.text
        
        self.view.makeToast(message:"Coupon code is copied", duration:1.0 , position: HRToastPositionDefault)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "filterScreenSegue"
        {
            let filterCtrl = segue.destinationViewController as! b4u_FilterViewController
            
            filterCtrl.selectedCategoryObj = self.selectedCategoryObj
            
            filterCtrl.selectedImgSlide = self.selectedImgSlide
            
            filterCtrl.selectedAttributeOption = self.selectedAttributeOption
        }
    }
    
    
    
    
    func callInterMediateApi()
    {
        
        if let aSelectedCatObj = selectedCategoryObj
        {
            b4u_Utility.sharedInstance.activityIndicator.startAnimating()

            var user_id = ""
            if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
                user_id = loginInfoData.userId! //Need to use later
            }

            let catId = aSelectedCatObj.catId!
//            let user_id = "15" //TODO
            let deviceId = b4u_Utility.getUUIDFromVendorIdentifier()
            
            var params = "?cat_id=\(catId)&user_id=\(user_id)&device_id=\(deviceId)"
            
            if  let aSelectedAttributeOption = selectedAttributeOption
            {
                if let optionId = aSelectedAttributeOption.optionId
                {
                    params = params + "&option_id=\(optionId)"
                }
                
                if let fieldName = aSelectedAttributeOption.fieldName
                {
                    params = params + "&field_name=\(fieldName)"
                    
                }
            }else
            {
                if let optionId = aSelectedCatObj.optionId
                {
                    params = params + "&option_id=\(optionId)"
                }
                
                if let fieldName = aSelectedCatObj.fieldName
                {
                    params = params + "&field_name=\(fieldName)"
                    
                }
            }
            b4u_WebApiCallManager.sharedInstance.getApiCall(intermediateScreenAPi, params:params, result:{(resultObject) -> Void in
                
                self.performSelectorOnMainThread("updateUI", withObject:nil, waitUntilDone:true)
            })
        }else if let aSelectedImgObj = self.selectedImgSlide
        {
            
            b4u_Utility.sharedInstance.activityIndicator.startAnimating()
            var user_id = ""
            if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
                user_id = loginInfoData.userId! //Need to use later
            }

            let catId = aSelectedImgObj.catId!
//            let user_id = "15" //TODO
            let deviceId = b4u_Utility.getUUIDFromVendorIdentifier()
            
            let params = "?cat_id=\(catId)&user_id=\(user_id)&device_id=\(deviceId)"
            
            b4u_WebApiCallManager.sharedInstance.getApiCall(intermediateScreenAPi, params:params, result:{(resultObject) -> Void in
                
                self.performSelectorOnMainThread("updateUI", withObject:nil, waitUntilDone:true)
            })
        }
        
    }
    @IBAction func cancelButttonClicked(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    func updateUI()
    {
        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

        scrollView.hidden = false
        btnContinue.hidden = false
        
        if let aDataModel = bro4u_DataManager.sharedInstance.interMediateScreenDataObj
        {
            self.scrollView.hidden = false;

            
            self.lblTitle.text = aDataModel.catName
            
            if aDataModel.interMessges?.count > 0
            {
                self.lblMessage1.text = aDataModel.interMessges![0]
                self.lblMessage2.text = aDataModel.interMessges![1]
                self.lblMessage3.text = aDataModel.interMessges![2]
            }
         
            self.lblOffer.text = aDataModel.couponOfferAdHeader
            self.lblOfferMessage.text = aDataModel.couponOfferAdDesc
            
            self.imgViewBanner.downloadedFrom(link:aDataModel.interBanner!, contentMode:UIViewContentMode.ScaleToFill)
            
            
            self.navigationItem.title = aDataModel.catName
            
            var showSepLine:Bool = false
            
            if aDataModel.termsAndConditions?.count <= 0
            {
                self.btnTermsAndConditions.hidden = true
            }else
            {
                showSepLine = true
            }
            
            if let couponCode = aDataModel.couponCode  where couponCode != ""
            {
                self.lblCoupan.text = couponCode
                showSepLine = true

            }else
            {
                self.btnTapToCopy.hidden = true
            }
            
            
            if !showSepLine
            {
                self.imgViewHrSep.hidden = true
            }
            // TO DO - T&C Underline
//            
//            let attributes = [
//                NSUnderlineStyleAttributeName : 1,
//                NSForegroundColorAttributeName : UIColor(red:178.0/255, green: 178.0/255, blue: 178.0/255, alpha: 1.0),
//                NSStrokeWidthAttributeName : 3.0,
//                NSStrikethroughStyleAttributeName:1
//            ]
//            
//            
//         let tCText =  NSAttributedString(string:"Terms & Conditons", attributes: attributes) //1
//
//            
//            self.btnTermsAndConditions.setAttributedTitle(tCText, forState:UIControlState.Normal)
            
        }
    }
    
    @IBAction func btnHomePressed(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
}
