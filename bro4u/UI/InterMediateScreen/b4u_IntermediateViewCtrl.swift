//
//  b4u-IntermediateViewCtrl.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_IntermediateViewCtrl: UIViewController {

    @IBOutlet weak var imgViewBanner: UIImageView!
    
    
    
    
    @IBOutlet weak var imgViewIcon3: UIImageView!
    @IBOutlet weak var imgViewIcon2: UIImageView!
    @IBOutlet weak var imgViewIcon1: UIImageView!
    
  
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage1: UILabel!
    @IBOutlet weak var lblMessage3: UILabel!
    @IBOutlet weak var lblMessage2: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblOfferMessage: UILabel!
    @IBOutlet weak var lblCoupan: UILabel!

    
    @IBOutlet weak var btnTermsAndConditions: UIButton!
    @IBOutlet weak var btnTapToCopy: UIButton!
    
    var selectedCategoryObj:b4u_Category?

    var selectedAttributeOption:b4u_AttributeOptions?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.callInterMediateApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        }
    }


    
    
    func callInterMediateApi()
    {
        
        if let aSelectedCatObj = selectedCategoryObj
        {
            let catId = aSelectedCatObj.catId!
            let userId = "15" //TODO
            let deviceId = b4u_Utility.getUUIDFromVendorIdentifier()
            
            
            var params = "?cat_id=\(catId)&user_id=\(userId)&device_id=\(deviceId)"
            
         
            
            
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
        }
      
    }
    @IBAction func cancelButttonClicked(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
  
    func updateUI()
    {
        if let aDataModel = bro4u_DataManager.sharedInstance.interMediateScreenDataObj
        {
            self.lblTitle.text = aDataModel.catName
            self.lblMessage1.text = aDataModel.interMessges![0]
            self.lblMessage2.text = aDataModel.interMessges![1]
            self.lblMessage3.text = aDataModel.interMessges![2]
            self.lblOffer.text = aDataModel.couponOfferAdHeader
            self.lblOfferMessage.text = aDataModel.couponOfferAdDesc
            self.lblCoupan.text = aDataModel.couponCode
            
            self.imgViewBanner.downloadedFrom(link:aDataModel.interBanner!, contentMode:UIViewContentMode.ScaleToFill)

            
            self.navigationItem.title = aDataModel.catName
            
            if aDataModel.termsAndConditions?.count <= 0
            {
                self.btnTermsAndConditions.hidden = true
            }
        }
    }
}
