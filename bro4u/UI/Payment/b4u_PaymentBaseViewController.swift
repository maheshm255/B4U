//
//  b4u_PaymentBaseViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_PaymentBaseViewController: UIViewController ,deliveryViewDelegate ,loginViewDelegate , paymentDelegate,UIPopoverPresentationControllerDelegate,createOrderDelegate, PGTransactionDelegate{
    
    @IBOutlet weak var viewSegmentCtrl: UIView!
    var segmentedControl:HMSegmentedControl?
    @IBOutlet weak var viewParent: UIView!
    let segmentTitles = ["LOGIN", "DELIVERY", "PAYMENT"]
    
    
    var deliveryViewCtrl:b4u_DeliveryViewController?
    var paymentViewCtrl:b4u_PaymentViewController?
    
    var topConstraint:NSLayoutConstraint?
    var bottomConstraint:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        
        self.cofigureUI()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //To move view Up when Keyboard Appears
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= 30
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += 30
        }
    }
    
    func cofigureUI()
    {
        
        self.addSegmentControl()
    }
    
    
    
    func addSegmentControl()
    {
        let viewWidth = CGRectGetWidth(self.view.frame)
        
        
        self.segmentedControl = HMSegmentedControl()
        
        
        self.segmentedControl = HMSegmentedControl(sectionTitles: segmentTitles)
        //self.segmentedControl!.frame = CGRectMake(0, 0, viewWidth, 40);
        // self.segmentedControl!.autoresizingMask = [.FlexibleRightMargin,.FlexibleWidth]
        self.segmentedControl!.addTarget(self, action: "segmentedControlChangedValue:", forControlEvents: .ValueChanged)
        self.segmentedControl!.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        self.segmentedControl!.backgroundColor = UIColor(red: 0/255.0, green: 162/255.0, blue: 221/255.0, alpha: 1.0)
        self.segmentedControl!.selectionIndicatorColor = UIColor(red: 241/255.0, green: 244/255.0, blue: 169/255.0, alpha: 1.0)
        self.segmentedControl!.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        self.segmentedControl!.touchEnabled = false;
        
        self.segmentedControl!.translatesAutoresizingMaskIntoConstraints = false
        
        let metricDict = ["w":viewWidth,"h":40.0]
        
        self.viewSegmentCtrl.addSubview(self.segmentedControl!)
        
        // - Generic cnst
        
        self.segmentedControl!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(h)]", options:[], metrics: metricDict, views: ["view":self.segmentedControl!]))
        
        self.segmentedControl!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":self.segmentedControl!]))
        
        self.viewSegmentCtrl.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]|", options:[], metrics: nil, views: ["view":self.segmentedControl!]))
        
        let hasLoggedInd:Bool = NSUserDefaults.standardUserDefaults().boolForKey("isUserLogined")
        
        
        self.configureSegmentDefaultIndex(hasLoggedInd)
    }
    
    
    func configureSegmentDefaultIndex(isUserLoggedIn:Bool)
    {
        if isUserLoggedIn
        {
            self.segmentedControl?.selectedSegmentIndex = 1
            self.addDeliveryViewControl()
        }else
        {
            self.segmentedControl?.selectedSegmentIndex = 0
            self.addLoginViewControl()
        }
    }
    func segmentedControlChangedValue(segmentedControl: HMSegmentedControl)
    {
        print("Selected index %ld (via UIControlEventValueChanged)", segmentedControl.selectedSegmentIndex)
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            print("login")
            
            self.addLoginViewControl()
        case 1:
            print("Delivery")
            self.addDeliveryViewControl()
            
        case 2:
            print("Payment")
            self.addPaymentViewControl()
        default:
            print("default")
            
        }
    }
    
    
    func addLoginViewControl()
    {
        
        
        let loginView:b4u_loginView  =  (UINib(nibName: "b4u-loginView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as? b4u_loginView)!
        
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        // loginView.frame = self.view.bounds
        // loginView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        
        loginView.setup()
        
        loginView.delegate = self
        
        let viewWidth = CGRectGetWidth(self.viewParent.frame)
        let viewHeight = CGRectGetHeight(self.viewParent.frame)
        
        
        let metricDict = ["w":viewWidth,"h":viewHeight]
        
        self.viewParent.addSubview(loginView)
        
        // - Generic cnst
        
        loginView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(h)]", options:[], metrics: metricDict, views: ["view":loginView]))
        
        loginView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":loginView]))
        
        self.viewParent.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]|", options:[], metrics: nil, views: ["view":loginView]))
        
        self.viewParent.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]|", options:[], metrics: nil, views: ["view":loginView]))
        
        
        
        
        
    }
    
    func addDeliveryViewControl()
    {
        
        
        if let aDeliveryViewCtrl = self.deliveryViewCtrl
        {
            self.viewParent.bringSubviewToFront(aDeliveryViewCtrl.view)
        }else
        {
            
            let viewWidth = CGRectGetWidth(self.viewParent.frame)
            let viewHeight = CGRectGetHeight(self.viewParent.frame)
            
            deliveryViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("deliveryViewCtrl") as? b4u_DeliveryViewController
            deliveryViewCtrl?.delegate = self
            
            self.deliveryViewCtrl!.view.translatesAutoresizingMaskIntoConstraints = false
            
            let metricDict = ["w":viewWidth,"h":viewHeight]
            
            self.viewParent.addSubview((self.deliveryViewCtrl?.view)!)
            
            // - Generic cnst
            
            //            self.deliveryViewCtrl!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(h)]", options:[], metrics: metricDict, views: ["view":self.deliveryViewCtrl!.view]))
            //
            //            self.deliveryViewCtrl!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":self.deliveryViewCtrl!.view]))
            
            //            self.viewParent.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]-0-|", options:[], metrics: nil, views: ["view":self.deliveryViewCtrl!.view]))
            
            self.viewParent.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options:[], metrics: nil, views: ["view":self.deliveryViewCtrl!.view]))
            
            
            
            topConstraint = NSLayoutConstraint(item:self.deliveryViewCtrl!.view, attribute: NSLayoutAttribute.Top  , relatedBy: NSLayoutRelation.Equal , toItem: self.viewParent, attribute: NSLayoutAttribute.Top, multiplier:1.0  , constant:0.0)
            
            bottomConstraint = NSLayoutConstraint(item:self.deliveryViewCtrl!.view, attribute: NSLayoutAttribute.Bottom  , relatedBy: NSLayoutRelation.Equal , toItem: self.viewParent, attribute: NSLayoutAttribute.Bottom, multiplier:1.0  , constant:0.0)
            
            self.viewParent.addConstraint(topConstraint!)
            
            self.viewParent.addConstraint(bottomConstraint!)
        }
        
        
    }
    
    func addPaymentViewControl()
    {
        
        if let aPaymentCtrl = self.paymentViewCtrl
        {
            self.viewParent.bringSubviewToFront(aPaymentCtrl.view)
            self.paymentViewCtrl?.loadAmountPayable()
            
        }else
        {
            paymentViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("paymentViewCtrl") as? b4u_PaymentViewController
            
            let viewWidth = CGRectGetWidth(self.viewParent.frame)
            let viewHeight = CGRectGetHeight(self.viewParent.frame)
            
            paymentViewCtrl?.delegate = self
            
            self.paymentViewCtrl!.view.translatesAutoresizingMaskIntoConstraints = false
            
            let metricDict = ["w":viewWidth,"h":viewHeight]
            
            self.viewParent.addSubview((self.paymentViewCtrl?.view)!)
            
            // - Generic cnst
            
            self.paymentViewCtrl!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(h)]", options:[], metrics: metricDict, views: ["view":self.paymentViewCtrl!.view]))
            
            self.paymentViewCtrl!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":self.paymentViewCtrl!.view]))
            
            self.viewParent.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]|", options:[], metrics: nil, views: ["view":self.paymentViewCtrl!.view]))
            
            self.viewParent.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]|", options:[], metrics: nil, views: ["view":self.paymentViewCtrl!.view]))
        }
        
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "CreditAndDebitCardViewControllerID"
        {
            let  paymentViewController:b4u_CreditAndDebitCardViewController = segue.destinationViewController as! b4u_CreditAndDebitCardViewController
            
            paymentViewController.paymentType = PAYMENT_PG_CCDC
        }
        else if segue.identifier == "netBankingCtrl"
        {
            let  paymentViewController:b4u_NetBankingViewController = segue.destinationViewController as! b4u_NetBankingViewController
            
            paymentViewController.paymentType = PAYMENT_PG_NET_BANKING
        }
    }
    
    
    //MARKS: Delivery Delegate
    
    func proceedToPayment()
    {
        
        self.getPaymentWays("")
        
    }
    
    func loginSuccessFull()
    {
        
        self.getData()
        
    }
    func loginFailed()
    {
        
    }
    
    func kbUP(notification:NSNotification)
    {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        topConstraint?.constant = -175
        bottomConstraint?.constant  = 175
    }
    
    func kbDown(notification:NSNotification)
    {
        topConstraint?.constant = 0
        bottomConstraint?.constant  = 0
    }
    
    
    func infoBtnClicked()
    {
        self.showQuicBookingView()
    }
    
    //Delegate from PaymentViewController after applying Coupon Code
    func couponApplied(couponCode: String) {
        self.getPaymentWays(couponCode)
    }
    //Function to Navigate for Payment Screen
    func navigateToPaymentGateWay(gateWayOpton:paymentOption)
    {
        
        switch gateWayOpton {
            
        case paymentOption.kPaytm :
            
            self.createOrderForPayTm()
            
        case paymentOption.kCCDC :
            
            self.performSegueWithIdentifier("creditCardViewController", sender:nil)
            
        case paymentOption.kNetBanking :
            self.performSegueWithIdentifier("netBankingCtrl", sender:nil)
            
        case paymentOption.kCOD :
            self.performSegueWithIdentifier("CODViewControllerID", sender:nil)
            
            
        }
        
        
    }
    
    //Paytm Order
    func createOrderForPayTm()
    {
        
        if (b4u_Utility.sharedInstance.getUserDefault("order_id") != nil) {
            
            let orderID = NSNumber(integer:Int(b4u_Utility.sharedInstance.getUserDefault("order_id") as! String)!)
            
            bro4u_DataManager.sharedInstance.orderId = orderID
            
            self.hasOrderCreated("Success")
        }
        else
        {
            
            b4u_Utility.sharedInstance.activityIndicator.startAnimating()
            let createOrderObj = b4u_CreateOrder()
            createOrderObj.paymentType  = kPaytmPayment
            createOrderObj.delegate = self
            createOrderObj.createOrder()
        }
        
    }
    
    
    func showQuicBookingView()
    {
        let storyboard : UIStoryboard = self.storyboard!
        
        let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("OrderDetailViewControllerID") as! b4u_OrderDetailViewController
        
        alertViewCtrl.modalPresentationStyle = .Popover
        alertViewCtrl.preferredContentSize = CGSizeMake(300, 420)
        
        let popoverMenuViewController = alertViewCtrl.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.frame),
            y: CGRectGetMidY(self.view.frame),
            width: 1,
            height: 1)
        presentViewController(
            alertViewCtrl,
            animated: true,
            completion: nil)
        
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    
    func getData()
    {
        
        //?req_id=3&email=harshal.zope1990%40gmail.com&first_name=Harshal&last_name=Zope&image=%22https%3A%2F%2Fgraph.facebook.com%2F836148279808264%2Fpicture%3Ftype%3Dlarge%22
        
        if let loginInfoObj = bro4u_DataManager.sharedInstance.loginInfo
        {
            if loginInfoObj.loginType != "OTP"
            {
                
                let reqId =   "3"
                let email =   loginInfoObj.email
                let firstName  = loginInfoObj.firstName
                let lastName =   loginInfoObj.lastName
                let image = ""
                
                let params = "?req_id=\(reqId)&email=\(email!)&first_name=\(firstName!)&last_name=\(lastName!)&image=\(image)&\(kAppendURLWithApiToken)"
                
                b4u_WebApiCallManager.sharedInstance.getApiCall(kSocialLogin, params:params, result:{(resultObject) -> Void in
                    
                    print("login user Data Received")
                    
                   //  NSNotificationCenter.defaultCenter().postNotificationName(kLoginDismissed, object:nil)
                    
                    
                    let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(bro4u_DataManager.sharedInstance.loginInfo!)
                    
                    
                    NSUserDefaults.standardUserDefaults().setObject(archivedObject, forKey:"loginInfo")
                    
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLogined")
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(kUserDataReceived, object:nil)
                    
                    self.segmentedControl?.selectedSegmentIndex = 1
                    self.addDeliveryViewControl()
                })
            }else
            {
                NSNotificationCenter.defaultCenter().postNotificationName(kUserDataReceived, object:nil)
                
                
              //  NSNotificationCenter.defaultCenter().postNotificationName(kLoginDismissed, object:nil)
                self.segmentedControl?.selectedSegmentIndex = 1

                self.addDeliveryViewControl()

             //   self.dismissViewControllerAnimated(true, completion:nil)
                
            }
        }
        
    }
    
    
    //MARKS:- Get Payement Options
    
    func getPaymentWays(couponCode : String)
    {
        
        
        var user_id = ""
        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            user_id = loginInfoData.userId! //Need to use later
            
        }
        
        //user_id = "3"
        
        
        
        var  sub_Total =  ""
        var itemId = ""
        var filterPareams = ""
        var params = ""
        
        if let aFilterParams = bro4u_DataManager.sharedInstance.userSelectedFilterParams{
            
            filterPareams = aFilterParams
        }
        
        var coupon = ""
        //    if let couponCode =    bro4u_DataManager.sharedInstance.copiedCopunCode
        //    {
        //        coupon = couponCode
        //    }
        
        if couponCode.length > 0
        {
            coupon = couponCode
        }
        else
        {
            coupon = ""
        }
        
        guard let service_date =   bro4u_DataManager.sharedInstance.selectedDate else
        {
            self.view.makeToast(message:"Please Select Service Date", duration:1.0, position:HRToastPositionDefault)
            return
        }
        
        
        
        guard let service_time =   bro4u_DataManager.sharedInstance.selectedTimeSlot else
        {
            self.view.makeToast(message:"Please Select Service Time", duration:1.0, position:HRToastPositionDefault)
            return
        }
        
        
        if  let selectedSuggestedPartner =   bro4u_DataManager.sharedInstance.selectedSuggestedPatner
        {
            sub_Total = selectedSuggestedPartner.custPrice!
            itemId = selectedSuggestedPartner.itemId!
            
            params =  itemId + filterPareams + "&sub_Total=\(sub_Total)&user_id=\(user_id)&coupon=\(coupon)&service_time=\(service_time)&service_date=\(service_date)&\(kAppendURLWithApiToken)"
            
        }else if let selectedReOrderModel = bro4u_DataManager.sharedInstance.selectedReorderModel
        {
            sub_Total = "\(selectedReOrderModel.subTotal!)"
            itemId = selectedReOrderModel.metaItemReOrder!.first!.itemID!
            
            params =  itemId + filterPareams + "?sub_Total=\(sub_Total)&user_id=\(user_id)&coupon=\(coupon)&service_time=\(service_time)&service_date=\(service_date)&unit_quantity=\(bro4u_DataManager.sharedInstance.selectedQualtity)&\(kAppendURLWithApiToken)"
        }
        
        
        
        
        if let selectedQuantity = bro4u_DataManager.sharedInstance.selectedQualtity
        {
             params = params +  "&unit_quantity=\(selectedQuantity)"
        }
        
        // TODO - Mahesh
        self.addLoadingIndicator()
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kGetBookingDetailIndex , params:params, result:{(resultObject) -> Void in
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            print("Payemtn data receivied")
            self.segmentedControl?.selectedSegmentIndex = 2
            
            self.setSelectionData()
            
            self.addPaymentViewControl()
        })
        
        
        
        
        
    }
    
    
    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
    
    // MARK: Order created
    
    //Call Back for Order Created
    func hasOrderCreated(resultObject:String)
    {
        
        if resultObject == "Success"
        {
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            //Setting Order ID in User Default
            let orderID = "\(bro4u_DataManager.sharedInstance.orderId!)"
            
            b4u_Utility.sharedInstance.setUserDefault(orderID, KeyToSave:"order_id")
            
            let callBackhandler = {(order:PGOrder?, merchantConfiguration :PGMerchantConfiguration?) in
                
                if order != nil{
                    self.laodViewController(order!, merchantConfiguration: merchantConfiguration!)
                }
                
            }
            
            
            let payUMoneyUtil = PayUMoneyUtilitiy()
            payUMoneyUtil.paytmCallBackHandler = callBackhandler
            payUMoneyUtil.orderID = "\(bro4u_DataManager.sharedInstance.orderId!)"
            payUMoneyUtil.userID = "\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)"
            payUMoneyUtil.createPaytmConfiguration()
        }
    }
    
    //MARK: Paytm Delegates and Methods
    
    func laodViewController(order : PGOrder, merchantConfiguration :PGMerchantConfiguration) -> Void {
        let txnController = PGTransactionViewController(transactionForOrder: order)
//        txnController.serverType = eServerTypeStaging;
        txnController.serverType = eServerTypeProduction;
        txnController.merchant = merchantConfiguration;
        txnController.delegate = self;
        showController(txnController)
        
    }
    
    //Paytm Delegates
    func showController(controller : PGTransactionViewController) -> Void {
        if navigationController != nil {
            navigationController?.pushViewController(controller, animated: true)
        }else{
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func removeController(controller : PGTransactionViewController) -> Void {
        if navigationController != nil {
            navigationController?.popViewControllerAnimated(true)
            
        }else{
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func didSucceedTransaction(controller: PGTransactionViewController!, response: [NSObject : AnyObject]!) {
        updatePaytmPaymentStatus("TXN_SUCCESS",orderId: response["ORDERID"] as! String)
        
        NSLog("ViewController::didSucceedTransactionresponse= %@", response);

    }
    
    func didFailTransaction(controller: PGTransactionViewController!, error: NSError!, response: [NSObject : AnyObject]!) {
        
        if response != nil
        {
            let alert = UIAlertController(title: error.localizedDescription, message: response.description, preferredStyle: UIAlertControllerStyle.Alert)
            //      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                
                self.updatePaytmPaymentStatus("TXN_FAILURE",orderId: response["ORDERID"] as! String)
                
                self.removeController(controller)
            }
            alert.addAction(OKAction)
            
        }
        else if error != nil
        {
            
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
            //      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                self.updatePaytmPaymentStatus("TXN_FAILURE",orderId: b4u_Utility.sharedInstance.getUserDefault("order_id") as! String)
                
                self.removeController(controller)
            }
            alert.addAction(OKAction)
            
        }
        //    removeController(controller)
    }
    
    func didCancelTransaction(controller: PGTransactionViewController!, error: NSError?, response: [NSObject : AnyObject]?) {
        
        if (error != nil && response != nil){
            
            print("ViewController::didCancelTransaction error = %@ response= %@", error, response);
         }
        
        
        var msg:String!
        
        if((error == nil)){
            msg = "Successful"
        }
        else{
            msg = "UnSuccessful"
        }
        
        
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        //      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        let OKAction = UIAlertAction(title: "Transaction Cancel", style: .Default) { (action:UIAlertAction!) in
            self.removeController(controller)
        }
        alert.addAction(OKAction)
    }
    
    func didFinishCASTransaction(controller: PGTransactionViewController!, response: [NSObject : AnyObject]!)
    {
        NSLog("ViewController::didFinishCASTransaction:response = %@", response);
    }
    
    
    
    func updatePaytmPaymentStatus(status : String,orderId : String)
    {
        
        let params = "?order_id=\(orderId)&payment_status=\(status)&\(kAppendURLWithApiToken)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kUpdatePaytmPaymentStatus , params:params, result:{(resultObject) -> Void in
            
            print(" Paytm Order Status Updated")
            
            if resultObject as! String == "Success" && status == "TXN_SUCCESS"
            {
                let orderConfirmedViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrderConfirmedViewControllerID") as? OrderConfirmedViewController
                
                self.navigationController?.pushViewController(orderConfirmedViewController!, animated: true)
            }else
            {
                print("Transaction Fail")
            }
            
        })
    }
    
    @IBAction func homeBtnPressed(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    
    func setSelectionData()
    {
        var selectionDict:Dictionary<String , AnyObject> = Dictionary()
        
       selectionDict =  selectionDict.union(bro4u_DataManager.sharedInstance.filterSelectionDict)
        
        
        if let orderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData.first
        {
            if let selectionLocal: b4u_SelectionModel =  orderDetailModel.selection?.first{
                
                if let userID = selectionLocal.userId
                {
                    selectionDict["user_id"] = userID
                }
                if let itemID = selectionLocal.itemId
                {
                    selectionDict["item_id"] = itemID
                }
                if let vendorId = selectionLocal.vendorId
                {
                    selectionDict["vendor_id"] = vendorId
                }
                if let unitQuantity = selectionLocal.unitQuantity
                {
                    selectionDict["unit_quantity"] = unitQuantity
                }
                if let subTotal = selectionLocal.subTotal
                {
                    selectionDict["sub_total"] = subTotal
                }
                if let deliveryCharge = selectionLocal.deliveryCharge
                {
                    selectionDict["delivery_charge"] = deliveryCharge
                }
                if let deductedFromWallet = selectionLocal.deductedFromWallet
                {
                    selectionDict["deducted_from_wallet"] = deductedFromWallet
                }
                if let deductedUsingCoupon = selectionLocal.deductedUsingCoupon
                {
                    selectionDict["deducted_using_coupon"] = deductedUsingCoupon
                }
                if let grandTotal = selectionLocal.grandTotal
                {
                    selectionDict["grand_total"] = grandTotal
                }
                
                
                do {
                    
                    
                    let jsonData = try NSJSONSerialization.dataWithJSONObject(selectionDict, options: NSJSONWritingOptions.PrettyPrinted)
                    // here "jsonData" is the dictionary encoded in JSON data
                    
                    var datastring = NSString(data:jsonData, encoding:NSUTF8StringEncoding) as String?
                    
                 datastring =   datastring?.replaceAll("\n", with:"")
                    
                    bro4u_DataManager.sharedInstance.selectedFilterSelectionInJsonFormat =  datastring
                    
                    
                } catch let error as NSError {
                    print(error)
                }
                
            }
        }
        
    }
    
}

extension Dictionary {
    
    mutating func unionInPlace(dictionary: Dictionary) {
        dictionary.forEach { self.updateValue($1, forKey: $0) }
    }
    
    func union(var dictionary: Dictionary) -> Dictionary {
        dictionary.unionInPlace(self)
        return dictionary
    }
}

