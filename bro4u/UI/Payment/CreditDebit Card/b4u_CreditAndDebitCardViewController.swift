//
//  b4u_CreditAndDebitCardViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 28/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CreditAndDebitCardViewController: UIViewController {

    
    var payUMoneyCntrl:PayUMoneyViewController?
    var paymentType:String?
    
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var creditCardNoTextFld: UITextField!
    @IBOutlet weak var expiryDateBtn: UIButton!
    @IBOutlet weak var cvvTextFld: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    
    @IBAction func ExpiryDateBtnAction(sender: AnyObject) {
    }
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.creditCardNoTextFld.text = "5123456789012346"
        self.cvvTextFld.text = "123"
        self.expiryDateBtn.setTitle("12/2019", forState: .Normal)
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

}
