//
//  b4u_PayOnlineOrderViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 22/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

protocol orderPayOnlineDelegate: NSObjectProtocol
{
    func payOrder(paymentType:Int , selectedOrderObj:b4u_OrdersModel?)
}


class b4u_PayOnlineOrderViewController: UIViewController {
  
  @IBOutlet weak var btnPaytm: UIButton!
  
  @IBOutlet weak var btnCreditCard: UIButton!
  
  @IBOutlet weak var btnNetBanking: UIButton!
  
  @IBOutlet weak var paytmOffer: UILabel!
  
  @IBOutlet weak var imageViewPaytm: UIImageView!
  
  @IBOutlet weak var imageViewCreditCard: UIImageView!
  
  @IBOutlet weak var imageViewNetBanking: UIImageView!
  
  var btnSelected:Int!
  
    var delegate:orderPayOnlineDelegate?
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    
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
  
  
  
  @IBAction func btnCloseClicked(sender: AnyObject) {
    //Removing Selected Order Object and Order ID in User Default
    b4u_Utility.sharedInstance.setUserDefault(nil, KeyToSave:"order_id")
    bro4u_DataManager.sharedInstance.userSelectedOrder = nil

    self.dismissViewControllerAnimated(true, completion:nil)
  }
  
  //susmit
  @IBAction func actionPayNow(sender: AnyObject)
  {
  //  var paymentVC : UIViewController?
    
    self.dismissViewControllerAnimated(true, completion:nil)
    self.delegate?.payOrder(btnSelected, selectedOrderObj:bro4u_DataManager.sharedInstance.userSelectedOrder)
//    if btnSelected > 0 {
//      
//      switch btnSelected {
//      case 1:
//        createOrderForPayTm()
//      case 2:
//        paymentVC = self.storyboard?.instantiateViewControllerWithIdentifier("CreditAndDebitCardViewControllerID")
//        (paymentVC as! b4u_CreditAndDebitCardViewController).paymentType = PAYMENT_PG_CCDC
//      case 3:
//        paymentVC = self.storyboard?.instantiateViewControllerWithIdentifier("NetBankingViewControllerID")
//        (paymentVC as! b4u_NetBankingViewController).paymentType = PAYMENT_PG_NET_BANKING
//      default:
//        break
//      }
//    }
//    
//    if paymentVC != nil {
//      if let navCntrlr = self.navigationController {
//        navCntrlr.pushViewController(paymentVC!, animated: true)
//      }
//    }
}
  //susmit
  
  @IBAction func actionRadioButton(sender: AnyObject) {
    
    let checkedImage = UIImage(named: "radioBlue")! as UIImage
    let uncheckedImage = UIImage(named: "radioGray")! as UIImage
    
    let btnSender:UIButton = sender as! UIButton
    
    if btnSender.tag == 1 {
      self.imageViewPaytm.image = checkedImage
      self.imageViewCreditCard.image = uncheckedImage
      self.imageViewNetBanking.image = uncheckedImage
    }
    else if btnSender.tag == 2{
      self.imageViewPaytm.image = uncheckedImage
      self.imageViewCreditCard.image = checkedImage
      self.imageViewNetBanking.image = uncheckedImage
      
    }
    else if btnSender.tag == 3{
      self.imageViewPaytm.image = uncheckedImage
      self.imageViewCreditCard.image = uncheckedImage
      self.imageViewNetBanking.image = checkedImage
      
    }
    self.btnSelected = btnSender.tag
  }
  
//  //Do PayTM payment for already created order
//  func createOrderForPayTm()
//  {
//    
//    if (b4u_Utility.sharedInstance.getUserDefault("order_id") != nil) {
//      
//      let orderID = NSNumber(integer:Int(b4u_Utility.sharedInstance.getUserDefault("order_id") as! String)!)
//      
//      bro4u_DataManager.sharedInstance.orderId = orderID
//      hasOrderCreated("Success")
//    } else if bro4u_DataManager.sharedInstance.userSelectedOrder != nil {
//      
//        let orderID = NSNumber(integer:Int((bro4u_DataManager.sharedInstance.userSelectedOrder?.orderID!)!)!)
//
//        bro4u_DataManager.sharedInstance.orderId = orderID
//        
//      hasOrderCreated("Success")
//    }
//  }
//  
//  //Call Back for Order Created
//  func hasOrderCreated(resultObject:String)
//  {
//    if resultObject == "Success"
//    {
//      //Setting Order ID in User Default
//      let orderID = "\(bro4u_DataManager.sharedInstance.orderId!)"
//      
//      b4u_Utility.sharedInstance.setUserDefault(orderID, KeyToSave:"order_id")
//      
//      let callBackhandler = {(order:PGOrder?, merchantConfiguration :PGMerchantConfiguration?) in
//        
//        if order != nil{
//          
//          self.laodViewController(order!, merchantConfiguration: merchantConfiguration!)
//        }
//        
//      }
//      
//      
//      let payUMoneyUtil = PayUMoneyUtilitiy()
//      payUMoneyUtil.paytmCallBackHandler = callBackhandler
//      payUMoneyUtil.orderID = "\(bro4u_DataManager.sharedInstance.orderId!)"
//      payUMoneyUtil.userID = "\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)"
//      payUMoneyUtil.createPaytmConfiguration()
//    }
//  }
//  
//  
//  func laodViewController(order : PGOrder, merchantConfiguration :PGMerchantConfiguration) -> Void {
//    let txnController = PGTransactionViewController(transactionForOrder: order)
//    txnController.serverType = eServerTypeStaging;
//    txnController.merchant = merchantConfiguration;
//    txnController.delegate = self
//    showController(txnController)
//    
//  }
//  
//  //Paytm Delegates
//  func showController(controller : PGTransactionViewController) -> Void {
//    if let navCntrlr = self.navigationController {
//      navCntrlr.pushViewController(controller, animated: true)
//    } else {
//        
//     self.presentViewController(controller, animated: true, completion: nil)
//    }
//  }
//  
//  func removeController(controller : PGTransactionViewController) -> Void {
//    if navigationController != nil {
//      navigationController?.popViewControllerAnimated(true)
//      
//    }else{
//      controller.dismissViewControllerAnimated(true, completion: nil)
//    }
//  }
//  
//  func didSucceedTransaction(controller: PGTransactionViewController!, response: [NSObject : AnyObject]!) {
//    updatePaytmPaymentStatus("TXN_SUCCESS",orderId: response["ORDERID"] as! String)
//    
//  }
//  
//  func didFailTransaction(controller: PGTransactionViewController!, error: NSError!, response: [NSObject : AnyObject]!) {
//    
//    if response != nil
//    {
//      let alert = UIAlertController(title: error.localizedDescription, message: response.description, preferredStyle: UIAlertControllerStyle.Alert)
//      self.presentViewController(alert, animated: true, completion: nil)
//      
//      
//      let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
//        
//        self.updatePaytmPaymentStatus("TXN_FAILURE",orderId: response["ORDERID"] as! String)
//        
//        self.removeController(controller)
//      }
//      alert.addAction(OKAction)
//      
//    }
//    else if error != nil
//    {
//      let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
//      self.presentViewController(alert, animated: true, completion: nil)
//      
//      let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
//        self.updatePaytmPaymentStatus("TXN_FAILURE",orderId: response["ORDERID"] as! String)
//        
//        self.removeController(controller)
//      }
//      alert.addAction(OKAction)
//      
//    }
//  }
//  
//  func didCancelTransaction(controller: PGTransactionViewController!, error: NSError!, response: [NSObject : AnyObject]!) {
//    self.removeController(controller)
//  }
//  
//  func didFinishCASTransaction(controller: PGTransactionViewController!, response: [NSObject : AnyObject]!)
//  {
//    
//  }
//  
//  
//  
//  func updatePaytmPaymentStatus(status : String,orderId : String)
//  {
//    
//    let params = "?order_id=\(orderId)&payment_status=\(status)"
//    b4u_WebApiCallManager.sharedInstance.getApiCall(kUpdatePaytmPaymentStatus , params:params, result:{(resultObject) -> Void in
//      
//      print(" Paytm Order Status Updated")
//      
//      if resultObject as! String == "Success" && status == "TXN_SUCCESS"
//      {
//        let orderConfirmedViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrderConfirmedViewControllerID") as? OrderConfirmedViewController
//        
//        self.navigationController?.pushViewController(orderConfirmedViewController!, animated: true)
//      }else
//      {
//        print("Transaction Fail")
//      }
//      
//    })
//  }
//
}
