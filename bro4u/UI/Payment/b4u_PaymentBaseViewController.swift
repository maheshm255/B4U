//
//  b4u_PaymentBaseViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_PaymentBaseViewController: UIViewController ,deliveryViewDelegate ,loginViewDelegate , paymentDelegate,UIPopoverPresentationControllerDelegate{

    @IBOutlet weak var viewSegmentCtrl: UIView!
    var segmentedControl:HMSegmentedControl?
    @IBOutlet weak var viewParent: UIView!
    let segmentTitles = ["LOGIN", "DELIVERY", "PAYMENT"]

    var loginViewCtrl:b4u_LoginViewCtrl?
    var deliveryViewCtrl:b4u_DeliveryViewController?
    var paymentViewCtrl:b4u_PaymentViewController?
    
    var topConstraint:NSLayoutConstraint?
    var bottomConstraint:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.cofigureUI()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARKS: Delivery Delegate
    
    func proceedToPayment()
    {
        self.segmentedControl?.selectedSegmentIndex = 2

        self.addPaymentViewControl()
    }
    
    func loginSuccessFull()
    {
        self.segmentedControl?.selectedSegmentIndex = 1
        self.addDeliveryViewControl()
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
       topConstraint?.constant = -150
       bottomConstraint?.constant  = 150
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

    
    
    func showQuicBookingView()
    {
            let storyboard : UIStoryboard = self.storyboard!
        
            let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("OrderDetailViewControllerID") as! b4u_OrderDetailViewController
        
            alertViewCtrl.modalPresentationStyle = .Popover
            alertViewCtrl.preferredContentSize = CGSizeMake(300, 400)
        
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
    
}


