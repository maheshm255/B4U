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
    
    @IBAction func tAndCBtnClicked(sender: AnyObject) {
    }

    @IBAction func tapToCopyBtnClicked(sender: AnyObject) {
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
            
            
            let params = "?cat_id=\(catId)&user_id=\(userId)&device_id=\(deviceId)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(intermediateScreenAPi, params:params, result:{(resultObject) -> Void in
                
                self.updateUI()
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
        }
    }
}
