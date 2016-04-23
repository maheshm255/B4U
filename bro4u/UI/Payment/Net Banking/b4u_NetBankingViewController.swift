//
//  b4u_NetBankingViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 28/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

enum selectBank : Int{
    case kICICI = 1
    case kHDFC
    case kSBI
    case kAXIS
}

class b4u_NetBankingViewController: UIViewController,UIPopoverPresentationControllerDelegate,bankSelectedDelegate , createOrderDelegate{

//    var payUMoneyCntrl:PayUMoneyViewController?
    var paymentType:String?
    var selectedBankCode:String?

    var saltKey:String?
    
    @IBOutlet weak var iciciBtn: UIButton!
    @IBOutlet weak var sbiBtn: UIButton!
    @IBOutlet weak var hdfcBtn: UIButton!
    @IBOutlet weak var axisBtn: UIButton!
    @IBOutlet weak var selectBankBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var downView: UIView!
    
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      self.addLoadingIndicator()
      
        
      if (b4u_Utility.sharedInstance.getUserDefault("order_id") != nil) {
        
        let orderID = NSNumber(integer:Int(b4u_Utility.sharedInstance.getUserDefault("order_id") as! String)!)
        
        bro4u_DataManager.sharedInstance.orderId = orderID

        self.hasOrderCreated("Success")
      } else if bro4u_DataManager.sharedInstance.userSelectedOrder != nil {
        self.hasOrderCreated("Success")
      }//susmit
      else
      {
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        let createOrderObj = b4u_CreateOrder()
        createOrderObj.paymentType  = kNetBankingPayment
        createOrderObj.delegate = self
        createOrderObj.createOrder()
        
        topView.hidden = true
        downView.hidden = true
      }



        NSNotificationCenter.defaultCenter().addObserver(self, selector:"handlePaymentResponse:", name: "paymentResponse", object: nil)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func handlePaymentResponse(reponseData : AnyObject){
    
    print("response data \(reponseData)")
    let orderConfirmedViewController = storyboard?.instantiateViewControllerWithIdentifier("OrderConfirmedViewControllerID") as? OrderConfirmedViewController
    navigationController?.pushViewController(orderConfirmedViewController!, animated: true)
    
    
  }
  
    func configureUI()
    {
    
      topView.hidden = false
      downView.hidden = false

      iciciBtn.layer.borderWidth = 1.0
      iciciBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
      hdfcBtn.layer.borderWidth = 1.0
      hdfcBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
      sbiBtn.layer.borderWidth = 1.0
      sbiBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
      axisBtn.layer.borderWidth = 1.0
      axisBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
      
      
      selectBankBtn.layer.borderWidth = 1.0
      selectBankBtn.layer.borderColor = UIColor.orangeColor().CGColor
      
      self.totalAmountLbl.text = "Rs. \(bro4u_DataManager.sharedInstance.selectedSuggestedPatner != nil ? bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.custPrice! : ((bro4u_DataManager.sharedInstance.userSelectedOrder != nil) ? bro4u_DataManager.sharedInstance.userSelectedOrder!.actualPrice! : ""))"//susmit

    }


    @IBAction func selectBankBtnAction(sender: AnyObject) {
        
    
            let btn = sender as! UIButton
            
            
            let storyboard : UIStoryboard = self.storyboard!
            
            let bankListTblCtrl:b4u_bankListTableViewController = storyboard.instantiateViewControllerWithIdentifier("bankListTableViewControllerID") as! b4u_bankListTableViewController
            
            bankListTblCtrl.modalPresentationStyle = .Popover
            bankListTblCtrl.preferredContentSize = CGSizeMake(300, 300)
            
            bankListTblCtrl.delegate = self
            
            let popoverMenuViewController = bankListTblCtrl.popoverPresentationController
            popoverMenuViewController?.permittedArrowDirections = .Up
            popoverMenuViewController?.delegate = self
            popoverMenuViewController?.sourceView = btn
            popoverMenuViewController?.sourceRect = CGRect(
                x: CGRectGetMidX(btn.bounds),
                y: CGRectGetMidY(btn.bounds),
                width: 1,
                height: 1)
            presentViewController(
                bankListTblCtrl,
                animated: true,
                completion: nil)
            
        
    }

    //MARKS: timeSlot selecteion delegate
    func didSelectBank(bankDetail:b4u_BankDetail)
    {
        self.selectBankBtn!.setTitle(bankDetail.bankName, forState:UIControlState.Normal)
        selectedBankCode = bankDetail.bankCode
        
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func bankBtnAction(sender: AnyObject) {
        
        switch sender.tag{
        case selectBank.kICICI.rawValue :
            selectBankBtn.setTitle("ICICI NetBanking", forState: UIControlState.Normal)
            selectedBankCode = "ICIB"
        case selectBank.kHDFC.rawValue :
            selectBankBtn.setTitle("HDFC Bank", forState: UIControlState.Normal)
            selectedBankCode = "HDFB"
        case selectBank.kSBI.rawValue :
            selectBankBtn.setTitle("State Bank Of India", forState: UIControlState.Normal)
            selectedBankCode = "SBIB"
            
        case selectBank.kAXIS.rawValue :
            selectBankBtn.setTitle("AXIS Bank NetBanking", forState: UIControlState.Normal)
            selectedBankCode = "AXIB"
            
        default :
            break
            
            
        }
    }
    
    
    @IBAction func continueBtnAction(sender: AnyObject) {
        
        let callBackhandler = {(request:AnyObject?,paymentParamForPassing:PayUModelPaymentParams?, error:String?) in
            
            if error != nil{
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let webViewVC = storyboard.instantiateViewControllerWithIdentifier("PayUUIPaymentUIWebViewControllerID") as! PayUUIPaymentUIWebViewController
                
                webViewVC.paymentRequest = request as! NSURLRequest
                webViewVC.paymentParam = paymentParamForPassing
                
                self.navigationController?.pushViewController(webViewVC, animated: true)
            }
            
        }
        
        let payUMoneyUtil = PayUMoneyUtilitiy()
        payUMoneyUtil.paymentType = PAYMENT_PG_NET_BANKING
        payUMoneyUtil.selectedBankCode = selectedBankCode
        payUMoneyUtil.callBackHandler = callBackhandler
        payUMoneyUtil.txnID = bro4u_DataManager.sharedInstance.txnID
        
        
        payUMoneyUtil.sURL = (bro4u_DataManager.sharedInstance.surl != nil) ? bro4u_DataManager.sharedInstance.surl:bro4u_DataManager.sharedInstance.userSelectedOrder!.surl
        
        payUMoneyUtil.fURL = (bro4u_DataManager.sharedInstance.furl != nil) ? bro4u_DataManager.sharedInstance.furl:bro4u_DataManager.sharedInstance.userSelectedOrder!.furl
        
        payUMoneyUtil.amount = (bro4u_DataManager.sharedInstance.selectedSuggestedPatner != nil) ? bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.custPrice : "\(bro4u_DataManager.sharedInstance.userSelectedOrder!.offerPrice!)"
        
        payUMoneyUtil.productInfo = (bro4u_DataManager.sharedInstance.selectedSuggestedPatner != nil) ? bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.catName : "\(bro4u_DataManager.sharedInstance.userSelectedOrder!.catName!)"

        payUMoneyUtil.firstName = bro4u_DataManager.sharedInstance.loginInfo?.fullName
        payUMoneyUtil.email = bro4u_DataManager.sharedInstance.loginInfo?.email
        payUMoneyUtil.phoneNumber = bro4u_DataManager.sharedInstance.loginInfo?.email
        payUMoneyUtil.orderID = "\(bro4u_DataManager.sharedInstance.orderId)"
        payUMoneyUtil.userID = "\(bro4u_DataManager.sharedInstance.loginInfo?.userId)"

      
      
        payUMoneyUtil.configureAllParameters()
        payUMoneyUtil.openWebPayment()

    }
  
  
    func addLoadingIndicator () {
      self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
      self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
      b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
    
    
    func hasOrderCreated(resultObject:String)
    {
      
      if resultObject == "Success"
      {
        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
        
        if bro4u_DataManager.sharedInstance.userSelectedOrder != nil
        {
            bro4u_DataManager.sharedInstance.orderId = NSNumberFormatter().numberFromString((bro4u_DataManager.sharedInstance.userSelectedOrder?.orderID!)!)
            bro4u_DataManager.sharedInstance.txnID = bro4u_DataManager.sharedInstance.userSelectedOrder?.txnID
        }

        
        //susmit
//        let orderID = (b4u_Utility.sharedInstance.getUserDefault("order_id") != nil) ? "\(bro4u_DataManager.sharedInstance.orderId!)" : ((bro4u_DataManager.sharedInstance.userSelectedOrder?.orderID?.length)! > 0 ? bro4u_DataManager.sharedInstance.userSelectedOrder?.orderID! : "")
//        //susmit
//
//        //Setting Order ID in User Default
//        b4u_Utility.sharedInstance.setUserDefault(orderID, KeyToSave:"order_id")

        self.configureUI()
      }
      //      self.getDataOfThanksScreen(resultObject)
    }


    @IBAction func cancelPaymentButtonPressed(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Exit Payment?", message: "Are you sure you want to go back without making the payment?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) in
            //Removing Order ID and Order in User Default
            b4u_Utility.sharedInstance.setUserDefault(nil, KeyToSave:"order_id")
            bro4u_DataManager.sharedInstance.userSelectedOrder = nil
            self.navigationController?.popViewControllerAnimated(true)
        }))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
