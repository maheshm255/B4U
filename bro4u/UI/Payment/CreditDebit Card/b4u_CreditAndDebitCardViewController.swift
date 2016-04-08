//
//  b4u_CreditAndDebitCardViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 28/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CreditAndDebitCardViewController: UIViewController,UITextFieldDelegate ,UINavigationBarDelegate{

    
    var payUMoneyCntrl:PayUMoneyViewController?
    var paymentType:String?
    var datePicker:UIDatePicker!
    var datePickerContainer:UIView!

    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var creditCardNoTextFld: UITextField!
    @IBOutlet weak var expiryDateBtn: UIButton!
    @IBOutlet weak var cvvTextFld: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      //  self.navigationController?.navigationBar.delegate = self
        // Do any additional setup after loading the view.
        
//        self.creditCardNoTextFld.text = "5123456789012346"
//        self.cvvTextFld.text = "123"
//        self.expiryDateBtn.setTitle("12/2019", forState: .Normal)
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

//        self.hideKeyboardWhenTappedAround()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ExpiryDateBtnAction(sender: AnyObject) {
        self.view.endEditing(true)

//        datePicker = UIDatePicker()
//        datePicker.datePickerMode = UIDatePickerMode.Date
//        datePicker.addTarget(self, action: "dateChanged:", forControlEvents: UIControlEvents.ValueChanged)
//        let pickerSize : CGSize = datePicker.sizeThatFits(CGSizeZero)
//        datePicker.frame = CGRectMake(0.0, 200, pickerSize.width, 250)
//        
//        //you probably don't want to set background color as black
//        datePicker.backgroundColor = UIColor.blueColor()
//
//        self.view.addSubview(datePicker)
        
        let expiryDatePicker = MonthYearPickerView()
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            let string = String(format: "%02d/%d", month, year)
            NSLog(string) // should show something like 05/2015
            self.expiryDateBtn.titleLabel!.text = string
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
        
        payUMoneyCntrl = PayUMoneyViewController()
        payUMoneyCntrl?.paymentType = PAYMENT_PG_CCDC
        
        let dateArr = expiryDateBtn.titleLabel!.text!.componentsSeparatedByString("/")
        
        payUMoneyCntrl?.cardExpYear = dateArr[1]
        payUMoneyCntrl?.cardExpMonth = dateArr[0]
        payUMoneyCntrl?.cardNo = creditCardNoTextFld.text
        payUMoneyCntrl?.CVVNo = cvvTextFld.text
        
        self.navigationController?.pushViewController(self.payUMoneyCntrl!, animated: true)
        
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
}
