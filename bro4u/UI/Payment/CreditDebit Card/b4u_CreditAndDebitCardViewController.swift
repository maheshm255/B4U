//
//  b4u_CreditAndDebitCardViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 28/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CreditAndDebitCardViewController: UIViewController,UITextFieldDelegate ,UINavigationBarDelegate , createOrderDelegate{

    
//    var payUMoneyCntrl:PayUMoneyViewController?
    var paymentType:String?
    var datePicker:UIDatePicker!
    var datePickerContainer:UIView!
    var order_id:String?


    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var creditCardNoTextFld: UITextField!
    @IBOutlet weak var expiryDateBtn: UIButton!
    @IBOutlet weak var cvvTextFld: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var downView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      //  self.navigationController?.navigationBar.delegate = self
        // Do any additional setup after loading the view.
      
      self.orderCreateDebitAndCredit()
//      NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(b4u_NetBankingViewController.handlePaymentResponse(_:)), name: "paymentResponse", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector:"handlePaymentResponse:", name: "paymentResponse", object: nil)
//
//      
//        self.addLoadingIndicator()
//      
//      if (b4u_Utility.sharedInstance.getUserDefault("order_id") != nil) {
//        let orderID = NSNumber(integer:Int(b4u_Utility.sharedInstance.getUserDefault("order_id") as! String)!)
//        
//        bro4u_DataManager.sharedInstance.orderId = orderID
//                    
//        self.hasOrderCreated("Success")
//      } else if bro4u_DataManager.sharedInstance.userSelectedOrder != nil {
//        self.hasOrderCreated("Success")
//      }//susmit
//      else
//      {
//        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
//        let createOrderObj = b4u_CreateOrder()
//        createOrderObj.paymentType  = kCardPayment
//        createOrderObj.delegate = self
//        createOrderObj.createOrder()
//        
//        topView.hidden = true
//        downView.hidden = true
//      }

//        self.hideKeyboardWhenTappedAround()

    }
  
    func orderCreateDebitAndCredit()
    {
      //2. Checking for Network reachability
      
      if(AFNetworkReachabilityManager.sharedManager().reachable){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"handlePaymentResponse:", name: "paymentResponse", object: nil)
        
        
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
          createOrderObj.paymentType  = kCardPayment
          createOrderObj.delegate = self
          createOrderObj.createOrder()
          
          topView.hidden = true
          downView.hidden = true
        }
        
        //3.Remove observer if any remain
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
        
      }else{
        //4. First Remove any existing Observer
        //Add Observer for No network Connection
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(b4u_CreditAndDebitCardViewController.orderCreateDebitAndCredit), name: "NoNetworkConnectionNotification", object: nil)
        
        //5.Adding View for Retry
        let noNetworkView = NoNetworkConnectionView(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.height))
        self.view.addSubview(noNetworkView)
        
        return
      }
      
      
    }
  
  func handlePaymentResponse(reponseData : AnyObject){
    
    print("response data \(reponseData)")
    if let status = reponseData["status"]{
      
    }
    
    let orderConfirmedViewController = storyboard?.instantiateViewControllerWithIdentifier("OrderConfirmedViewControllerID") as? OrderConfirmedViewController
    navigationController?.pushViewController(orderConfirmedViewController!, animated: true)
    
    
  }
  
    func configureUI()
    {
      topView.hidden = false
      downView.hidden = false

      
      //Set Default Values od Debit Card
//      self.creditCardNoTextFld.text = "4181576255038012"
//      self.cvvTextFld.text = "017"
//      self.expiryDateBtn.setTitle("10/2020", forState: .Normal)
      
        //Set Default Values of Credit Card
//      self.creditCardNoTextFld.text = "5459648600234794"
//      self.cvvTextFld.text = "865"
//      self.expiryDateBtn.setTitle("05/2018", forState: .Normal)
      

      
      creditCardNoTextFld.keyboardType = .NumberPad
      cvvTextFld.keyboardType = .NumberPad
      
      creditCardNoTextFld.layer.borderWidth = 1.0;
      creditCardNoTextFld.layer.borderColor = UIColor.lightGrayColor().CGColor
      cvvTextFld.layer.borderWidth = 1.0;
      cvvTextFld.layer.borderColor = UIColor.lightGrayColor().CGColor
      
      expiryDateBtn.layer.borderWidth = 1.0
      expiryDateBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
      
      
      self.creditCardNoTextFld.delegate = self
      self.cvvTextFld.delegate = self
      
    if let orderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData.first
    {
        if let selectionLocal: b4u_SelectionModel =  orderDetailModel.selection?.first{
            
            if let grandTotal = selectionLocal.grandTotal
            {
                self.amountLbl.text = "Rs. \(grandTotal).00"
            }
        }
    }

//      self.amountLbl.text = "Rs. \(bro4u_DataManager.sharedInstance.selectedSuggestedPatner != nil ? bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.custPrice! : ((bro4u_DataManager.sharedInstance.userSelectedOrder != nil) ? bro4u_DataManager.sharedInstance.userSelectedOrder!.offerPrice! : ""))"//susmit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ExpiryDateBtnAction(sender: AnyObject) {
        self.view.endEditing(true)
        
        let expiryDatePicker = MonthYearPickerView()
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            let string = String(format: "%02d/%d", month, year)
            NSLog(string) // should show something like 05/2015
            self.expiryDateBtn.setTitle(string, forState:UIControlState.Normal)
        }
        
        datePickerContainer = UIView()

        datePickerContainer.frame = CGRectMake(0.0, self.view.frame.height/2, 320.0, 300.0)
        datePickerContainer.backgroundColor = UIColor.whiteColor()
        
        datePickerContainer.addSubview(expiryDatePicker)
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        doneButton.addTarget(self, action: Selector("dismissPicker:"), forControlEvents: UIControlEvents.TouchUpInside)
        doneButton.frame    = CGRectMake(250.0, 5.0, 70.0, 37.0)
        
        datePickerContainer.addSubview(doneButton)
        
        self.view.addSubview(datePickerContainer)

    }
    
    
    func dismissPicker(sender: UIButton) {
        datePickerContainer.removeFromSuperview()
    }// end dismissPicker

    @IBAction func continueBtnAction(sender: AnyObject) {
        
        
        let callBackhandler = {(request:AnyObject?,paymentParamForPassing:PayUModelPaymentParams?, error:String?) in
            
            if error != nil {
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
        
        let dateArr = expiryDateBtn.titleLabel!.text!.componentsSeparatedByString("/")
        
        let payUMoneyUtil = PayUMoneyUtilitiy()
        payUMoneyUtil.paymentType = PAYMENT_PG_CCDC
        payUMoneyUtil.cardExpYear = dateArr[1]
        payUMoneyUtil.cardExpMonth = dateArr[0]
        payUMoneyUtil.cardNo = creditCardNoTextFld.text
        payUMoneyUtil.CVVNo = cvvTextFld.text
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
        payUMoneyUtil.nameOnCard = bro4u_DataManager.sharedInstance.loginInfo?.fullName


        payUMoneyUtil.configureAllParameters()
        payUMoneyUtil.openWebPayment()
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
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

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        if textField == self.creditCardNoTextFld{
        
            if (newLength == 5 || newLength == 10 || newLength == 15) && newLength > text.length{
                textField.text = textField.text?.stringByAppendingString("-")
            }
            return newLength <= 19 // Bool

        }
        else if textField == self.cvvTextFld{
            return newLength <= 3 // Bool

        }
        
        return true
    }

    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            // Back btn Event handler
        }
    }
    
    
    func navigationBar(navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool // same as push methods
    {
        return true
    }
    func navigationBar(navigationBar: UINavigationBar, didPopItem item: UINavigationItem)
    {
        
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
        //susmit
        
        if bro4u_DataManager.sharedInstance.userSelectedOrder != nil
        {
            self.order_id = "\(bro4u_DataManager.sharedInstance.userSelectedOrder?.orderID!)"
            bro4u_DataManager.sharedInstance.txnID = bro4u_DataManager.sharedInstance.userSelectedOrder?.txnID
        }
        else
        {
            self.order_id = "\(bro4u_DataManager.sharedInstance.orderId!)"
            //Setting Order ID in User Default
            b4u_Utility.sharedInstance.setUserDefault(self.order_id, KeyToSave:"order_id")

        }

        self.configureUI()
      }
    }

    @IBAction func cancelPaymentButtonPressed(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Exit Payment?", message: "Are you sure you want to go back without making the payment?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) in
            self.navigationController?.popViewControllerAnimated(true)
        }))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
