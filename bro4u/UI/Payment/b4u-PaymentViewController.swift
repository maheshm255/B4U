//
//  b4u-PaymentViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

enum paymentOption: Int{
    case kPaytm = 1
    case kCCDC
    case kNetBanking
    case kCOD
}

protocol paymentDelegate
{
    func infoBtnClicked()
    func navigateToPaymentGateWay(gateWayOpton:paymentOption)
    func couponApplied(couponCode:String)

}

class b4u_PaymentViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var paymentTableView: UITableView!
    
    var radioButtonSelected:Int?
    
    var delegate:paymentDelegate?
    
    //Hard Coded for Payment Options
    let itemDict : NSArray = ["paytm","Credit/Debit Card",
        "Net Banking",
        "Cash On Service"]
    var offerDict : NSMutableDictionary?

    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var tfCouponCode: UITextField!
    @IBOutlet weak var imgViewDonwArrow: UIImageView!
    @IBOutlet weak var lblHaveCouponCode: UILabel!
    @IBOutlet weak var viewCouponCode: UIView!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblCouponApplied: UILabel!
    @IBOutlet weak var lblCouponAmt: UILabel!
  
    
    
    override func viewDidLoad() {
      self.showPaymentOptions()

    }
  
//    func showPaymentOptions()
//    {
//      self.loadAmountPayable()
//      
//      
//      if let copiedCoupon =   bro4u_DataManager.sharedInstance.copiedCopunCode{
//        UIPasteboard.generalPasteboard().string = copiedCoupon
//      }
//      
//      let tapGesture = UITapGestureRecognizer(target:self, action:"applyCouponCodeViewTaped")
//      tapGesture.numberOfTouchesRequired = 1
//      self.viewCouponCode.addGestureRecognizer(tapGesture)
//      self.addLoadingIndicator()
//      b4u_Utility.sharedInstance.activityIndicator.startAnimating()
//      super.viewDidLoad()
//      b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
//      
//      // Do any additional setup after loading the view.
//      
//      //To Give Shadow to Views
//      b4u_Utility.shadowEffectToView(viewCouponCode)
//      
//      b4u_Utility.shadowEffectToView(paymentTableView)
//      
//      self.createOfferDict()
//    }
  
  
    func showPaymentOptions()
    {
      //2. Checking for Network reachability
      
      if(AFNetworkReachabilityManager.sharedManager().reachable){
        
        self.loadAmountPayable()
        
        
        if let copiedCoupon =   bro4u_DataManager.sharedInstance.copiedCopunCode{
          UIPasteboard.generalPasteboard().string = copiedCoupon
        }
        
        let tapGesture = UITapGestureRecognizer(target:self, action:"applyCouponCodeViewTaped")
        tapGesture.numberOfTouchesRequired = 1
        self.viewCouponCode.addGestureRecognizer(tapGesture)
        self.addLoadingIndicator()
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        super.viewDidLoad()
        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
        
        // Do any additional setup after loading the view.
        
        //To Give Shadow to Views
        b4u_Utility.shadowEffectToView(viewCouponCode)
        
        b4u_Utility.shadowEffectToView(paymentTableView)
        
        self.createOfferDict()
        //3.Remove observer if any remain
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
        
      }else{
        //4. First Remove any existing Observer
        //Add Observer for No network Connection
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(b4u_PaymentViewController.showPaymentOptions), name: "NoNetworkConnectionNotification", object: nil)
        
        //5.Adding View for Retry
        let noNetworkView = NoNetworkConnectionView(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.height))
        self.view.addSubview(noNetworkView)
        
        return
      }
    }
  
  
    func loadAmountPayable()
    {
        if let orderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData.first
        {
            if let selectionLocal: b4u_SelectionModel =  orderDetailModel.selection?.first{
                self.lblAmount.text = "  Rs. \(selectionLocal.grandTotal!).00"
                
                self.lblCouponApplied.hidden = true
                
//                var couponAmount:NSNumber?
//                var walletAmount:NSNumber?
                var finalAmoutToDeduct:Int?
                
                if let coupon = selectionLocal.deductedUsingCoupon where Int(coupon) > 0
                {
                    if let wallet = selectionLocal.deductedFromWallet where Int(wallet) > 0
                    {
                        finalAmoutToDeduct = (coupon.integerValue) + (wallet.integerValue)
                    }
                    else
                    {
                        finalAmoutToDeduct = (coupon.integerValue)
                    }

                }
                else if let wallet = selectionLocal.deductedFromWallet where Int(wallet) > 0
                {
                    finalAmoutToDeduct = (wallet.integerValue)
                }
                
                if finalAmoutToDeduct > 0
                {
                    self.lblCouponApplied.hidden = false
                    self.lblCouponAmt.hidden = false
                    
                    self.lblCouponAmt.text = "Rs. \(finalAmoutToDeduct!).00"
                }
                else
                {
                    self.lblCouponApplied.hidden = true
                    self.lblCouponAmt.hidden = true
                    
                }
                
            }
            
            
            
        }
        
        //        if  let selectedSuggestedPartner =   bro4u_DataManager.sharedInstance.selectedSuggestedPatner
        //        {
        //            self.lblAmount.text = "  Rs. \(self.getTotalPaybleAmount())  "
        //
        //        }else if let selectedReOrderModel = bro4u_DataManager.sharedInstance.selectedReorderModel
        //        {
        //            self.lblAmount.text = "  Rs. \(selectedReOrderModel.subTotal!)  "
        //        }
        
//        if let selectedPartner:b4u_SugestedPartner = bro4u_DataManager.sharedInstance.selectedSuggestedPatner
//        {
//            //Text Struck Through
//            
//            if selectedPartner.custPrice > selectedPartner.offerPrice
//            {
//                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Rs. \(selectedPartner.custPrice!)")
//                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
//                lblWalletDiscount.attributedText = attributeString;
//                //                self.lblAmount.text = "  Rs. \(self.getTotalPaybleAmount())  "
//                
//                lblWalletDiscount.hidden = false
//            }
//            else
//            {
//                lblWalletDiscount.hidden = true
//            }
//            
//        }
        
        

    }
  
    
//    func getTotalPaybleAmount()->Double
//    {
//        var price:Double = 0.0
//        if  let selectedSuggestedPartner =   bro4u_DataManager.sharedInstance.selectedSuggestedPatner
//        {
//            price = Double(selectedSuggestedPartner.offerPrice!)!
//            
//            if let selectedQuantity = bro4u_DataManager.sharedInstance.selectedQualtity
//            {
//                 price = Double(selectedQuantity)! * price
//            }
//            
//            if let deliveryCharge = selectedSuggestedPartner.deliveryCharge
//            {
//              price =   price + deliveryCharge.doubleValue
//            }
//        }
//        
//        return price
//    }
  
    func createOfferDict()
    {
      offerDict = NSMutableDictionary()
        
      let paymentMethod = bro4u_DataManager.sharedInstance.orderDetailData[0].paymentMethod!
        if paymentMethod == "both"
        {
            for offer in bro4u_DataManager.sharedInstance.orderDetailData[0].paymentGateWayes!
            {
                let PaymentGatewayOffersModel: b4u_PaymentGatewayOffersModel = offer
                
                offerDict?.setValue(PaymentGatewayOffersModel.offerMsg, forKey: PaymentGatewayOffersModel.offerFor!)
                
            }

        }
        else if paymentMethod == "online"
        {
            
            for offer in bro4u_DataManager.sharedInstance.orderDetailData[0].paymentGateWayes!
            {
                let PaymentGatewayOffersModel: b4u_PaymentGatewayOffersModel = offer
                if PaymentGatewayOffersModel.offerFor != "cod"
                {
                    offerDict?.setValue(PaymentGatewayOffersModel.offerMsg, forKey: PaymentGatewayOffersModel.offerFor!)
                }
            }

        }
        else if paymentMethod == "cod"
        {
            let PaymentGatewayOffersModel: b4u_PaymentGatewayOffersModel = bro4u_DataManager.sharedInstance.orderDetailData[0].paymentGateWayes![3]
            offerDict?.setValue(PaymentGatewayOffersModel.offerMsg, forKey: PaymentGatewayOffersModel.offerFor!)

        }

    }
    
    func applyCouponCodeViewTaped()
    {
        self.imgViewDonwArrow.hidden = true
        self.lblHaveCouponCode.hidden = true
        
        self.btnApply.hidden = false
        self.tfCouponCode.hidden = false
    }
  
    @IBAction func applyCouponBtnClicked(sender: AnyObject)
    {

        if tfCouponCode.text?.length>0
        {
          b4u_Utility.sharedInstance.activityIndicator.startAnimating()

            var user_id = ""
            var  sub_Total =  ""
            var itemId = ""
            var vendorID = ""
            var categoryID = ""

            if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
                
                user_id = loginInfoData.userId! //Need to use later
                
            }
            let imei = b4u_Utility.getUUIDFromVendorIdentifier()
            let deviceType = "mobile"
            if  let selectedSuggestedPartner =   bro4u_DataManager.sharedInstance.selectedSuggestedPatner
            {
                sub_Total = selectedSuggestedPartner.custPrice!
                itemId = selectedSuggestedPartner.itemId!
            }
            if let orderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData.first
            {
                if let selectionLocal: b4u_SelectionModel =  orderDetailModel.selection?.first{
                    
                    if let vendor_ID = selectionLocal.vendorId
                    {
                        vendorID = vendor_ID
                    }
                }
            }
            
            if let catIDData:b4u_OrderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData[0]{
                
                categoryID = catIDData.catId!
            }


            
            let params = "?coupon_code=\(tfCouponCode.text!)&user_id=\(user_id)&imei=\(imei)&bro4u_device_type=\(deviceType)&sub_total=\(sub_Total)&cat_id=\(categoryID)&vendor_id=\(vendorID)&item_id=\(itemId)&\(kAppendURLWithApiToken)"
            
            
                b4u_WebApiCallManager.sharedInstance.getApiCall(kCouponCodeValidateIndex , params:params, result:{(resultObject) -> Void in
                  b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

                  self.applyReferralCode(resultObject as! String)

                    print(resultObject)
                })
        }
        else
        {
          self.view.makeToast(message:"Please enter coupon code first", duration:1.0, position:HRToastPositionDefault)
          
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
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return bro4u_DataManager.sharedInstance.orderDetailData[0].paymentGateWayes!.count
        return offerDict!.count

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "paymentSelectionTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_PaymentTblViewCell
        
//        let PaymentGatewayOffersModel: b4u_PaymentGatewayOffersModel   = bro4u_DataManager.sharedInstance.orderDetailData[0].paymentGateWayes![indexPath.row]
        
        if offerDict!.count == 1
        {
            cell.typeLabel.hidden  = false
            cell.typeImageView.hidden = true
            cell.typeLabel?.text = itemDict[3] as? String
            cell.infoLabel?.text = offerDict?.objectForKey(kCodOffer) as? String
            cell.tag = 3

        }
        else
        {
            if(indexPath.row == 0){
                cell.typeLabel.hidden  = true
                cell.typeImageView.hidden = false
                cell.typeImageView.image = UIImage(named:itemDict[0] as! String)
            }
            else
            {
                cell.typeLabel.hidden  = false
                cell.typeImageView.hidden = true
                cell.typeLabel?.text = itemDict[indexPath.row] as? String
                
            }
            var offerStr:String?
            
            switch  indexPath.row
            {
            case 0:
                offerStr = offerDict?.objectForKey(kPaytmOffer) as? String
                break;
            case 1:
                offerStr = offerDict?.objectForKey(kOnlinepayOffer) as? String

                break;
            case 2:
                offerStr = offerDict?.objectForKey(kPayumoneyOffer) as? String

                break;
            case 3:
                offerStr = offerDict?.objectForKey(kCodOffer) as? String

                break;
            default:
                break;

                
            }
            cell.infoLabel?.text = offerStr
            cell.tag = indexPath.row

        }
        
//        if(indexPath.row == 0){
//            cell.typeLabel.hidden  = true
//            cell.typeImageView.hidden = false
//            cell.typeImageView.image = UIImage(named:itemDict[0] as! String)
//        }
//        else
//        {
//            cell.typeLabel.hidden  = false
//            cell.typeImageView.hidden = true
//            cell.typeLabel?.text = itemDict[indexPath.row] as? String
//            
//        }
      
//        if(offerDict?.count > 0)
//        {
//          switch indexPath.row {
//          case 0:
//            cell.infoLabel?.text = offerDict?.objectForKey(kPaytmOffer) as? String
//          case 1:
//            cell.infoLabel?.text = offerDict?.objectForKey(kPayumoneyOffer) as? String
//          case 2:
//            cell.infoLabel?.text = offerDict?.objectForKey(kOnlinepayOffer) as? String
//          case 3:
//            cell.infoLabel?.text = offerDict?.objectForKey(kCodOffer) as? String
//            
//          default:
//            break
//          }
//
//        }
//        cell.infoLabel?.text = PaymentGatewayOffersModel.offerMsg
      
        if radioButtonSelected != nil{
            if radioButtonSelected == indexPath.row{
                cell.radioImageView.image = UIImage(named: "radioBlue")
            }
            else
            {
                cell.radioImageView.image = UIImage(named: "radioGray")
            }
        }
        
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! b4u_PaymentTblViewCell
        if radioButtonSelected != nil
        {
            let indexPath = NSIndexPath(forRow:radioButtonSelected!, inSection: 0)

            let selectedcell = tableView.cellForRowAtIndexPath(indexPath) as! b4u_PaymentTblViewCell
            selectedcell.radioImageView.image = UIImage(named: "radioGray")
        }
        cell.radioImageView.image = UIImage(named: "radioBlue")
        radioButtonSelected = cell.tag
    }
    
    @IBAction func placeOrder(sender: AnyObject){
        
        if radioButtonSelected != nil
        {
        if radioButtonSelected >= 0 {
            
            switch radioButtonSelected! {
            case 0:
               delegate?.navigateToPaymentGateWay(paymentOption.kPaytm)
            case 1:
                delegate?.navigateToPaymentGateWay(paymentOption.kCCDC)
            case 2:
                delegate?.navigateToPaymentGateWay(paymentOption.kNetBanking)
            case 3:
                delegate?.navigateToPaymentGateWay(paymentOption.kCOD)
            default:
                break
            }

        }
        }else
        {
            self.view.makeToast(message:"Please Select Payment Option", duration:1.0, position:HRToastPositionDefault)
        }
        
    }
    
    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
    
    @IBAction func showDetailBtnClicked(sender: AnyObject) {
        
        self.showAlertView()
    }
    
    
    func showAlertView()
    {
        self.delegate?.infoBtnClicked()
        
    }
  
  
  func applyReferralCode(resultObject:String)
  {
    let codeValidateStatus = bro4u_DataManager.sharedInstance.couponCodeStatus
    let codeValidateMessage = bro4u_DataManager.sharedInstance.couponCodeMessage

    if resultObject == "Success" && codeValidateStatus == "true"
    {
      delegate?.couponApplied(self.tfCouponCode.text!)
      self.view.makeToast(message:codeValidateMessage!, duration:1.0, position:HRToastPositionDefault)
      self.tfCouponCode.text = ""
    }
    else
    {
      self.view.makeToast(message:codeValidateMessage!, duration:1.0, position:HRToastPositionDefault)
      self.tfCouponCode.text = ""
    }
    
    
    if let orderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData.first
    {
        if let selectionLocal: b4u_SelectionModel =  orderDetailModel.selection?.first{
            self.lblAmount.text = "  Rs. \(selectionLocal.grandTotal!).00"
        }
    }
    self.view.endEditing(true)

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

  
}
