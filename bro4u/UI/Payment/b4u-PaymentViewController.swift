//
//  b4u-PaymentViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

enum paymentOption: Int{
    case kPaytm = 0
    case kCCDC
    case kNetBanking
    case kCOD
}

protocol paymentDelegate
{
    func infoBtnClicked()
    
    func navigateToPaymentGateWay(gateWayOpton:paymentOption)
    
}
class b4u_PaymentViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var paymentTableView: UITableView!
    
    var radioButtonSelected:NSIndexPath!
    
    var delegate:paymentDelegate?
    
    //Hard Coded for Payment Options
    let itemDict : NSArray = ["paytm","Credit/Debit Card",
        "Net banking/Credit/Debit",
        "Cash On Service"]
    
    
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
        
        
        
        if  let selectedSuggestedPartner =   bro4u_DataManager.sharedInstance.selectedSuggestedPatner
        {
            self.lblAmount.text = "  Rs. \( selectedSuggestedPartner.custPrice!)  "

        }else if let selectedReOrderModel = bro4u_DataManager.sharedInstance.selectedReorderModel
        {
            self.lblAmount.text = "  Rs. \(selectedReOrderModel.subTotal!)  "
        }
      
        if tfCouponCode.text?.length>0
        {
          if let orderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData.first
          {
            if let selectionLocal: b4u_SelectionModel =  orderDetailModel.selection?.first{
              
              var couponAmount:NSNumber?
              var walletAmount:NSNumber?
              var finalAmoutToDeduct:Float?
              
              if let coupon = selectionLocal.deductedUsingCoupon
              {
                couponAmount = coupon
              }
              if let wallet = selectionLocal.deductedFromWallet
              {
                walletAmount = wallet
              }
              
              if couponAmount?.floatValue > 0 || walletAmount?.floatValue > 0
              {
                finalAmoutToDeduct = (couponAmount?.floatValue)! + (walletAmount?.floatValue)!
              }
              
              if finalAmoutToDeduct > 0
              {
                self.lblCouponApplied.hidden = false
                self.lblCouponAmt.hidden = false
                
                self.lblCouponAmt.text = "Rs. \(finalAmoutToDeduct!)"
                self.lblAmount.text = "Rs. \(selectionLocal.grandTotal!)"
                
              }
              else
              {
                self.lblCouponApplied.hidden = true
                self.lblCouponAmt.hidden = true
                
              }
            }
          }

        }


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
        
        //To Give Shadow to tableview
        self.paymentTableView.layer.shadowColor  = UIColor.grayColor().CGColor
        self.paymentTableView.layer.shadowOffset  = CGSizeMake(3.0, 3.0)
        self.paymentTableView.layer.shadowRadius  = 0.2
        self.paymentTableView.layer.shadowOpacity  = 1
        self.paymentTableView.clipsToBounds  = false
        self.paymentTableView.layer.masksToBounds  = false
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
            
            if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
                
                user_id = loginInfoData.userId! //Need to use later
                
            }
            
            let params = "?coupon_code=\(tfCouponCode.text!)&user_id=\(user_id)"
            
            
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
        
        return bro4u_DataManager.sharedInstance.orderDetailData[0].paymentGateWayes!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "paymentSelectionTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_PaymentTblViewCell
        
        let PaymentGatewayOffersModel: b4u_PaymentGatewayOffersModel   = bro4u_DataManager.sharedInstance.orderDetailData[0].paymentGateWayes![indexPath.row]
        
        if(indexPath.row == 0){
            cell.typeLabel.hidden  = true
            cell.typeImageView.hidden = false
            cell.typeImageView.image = UIImage(named:itemDict[0] as! String)
        }
        else
        {
            cell.typeLabel.hidden  = false
            cell.typeImageView.hidden = true
            cell.typeLabel?.text = itemDict[indexPath.row] as! String
            
        }
        cell.infoLabel?.text = PaymentGatewayOffersModel.offerMsg
        
        if radioButtonSelected != nil{
            if radioButtonSelected.isEqual(indexPath){
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
            let selectedcell = tableView.cellForRowAtIndexPath(radioButtonSelected) as! b4u_PaymentTblViewCell
            selectedcell.radioImageView.image = UIImage(named: "radioGray")
        }
        cell.radioImageView.image = UIImage(named: "radioBlue")
        radioButtonSelected = indexPath
        
    }
    
    @IBAction func placeOrder(sender: AnyObject){
        
        switch radioButtonSelected.row {
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
      
      let paymentBaseCntl = b4u_PaymentBaseViewController()
      paymentBaseCntl.getPaymentWays(bro4u_DataManager.sharedInstance.copiedCopunCode!)
      self.view.makeToast(message:codeValidateMessage!, duration:1.0, position:HRToastPositionDefault)
      self.tfCouponCode.text = ""

    }
    else
    {
      self.view.makeToast(message:codeValidateMessage!, duration:1.0, position:HRToastPositionDefault)
      self.tfCouponCode.text = ""
    }

  }
  
  
}
