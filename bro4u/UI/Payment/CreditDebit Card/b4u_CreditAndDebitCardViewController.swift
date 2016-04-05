//
//  b4u_CreditAndDebitCardViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 28/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CreditAndDebitCardViewController: UIViewController {

    
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var creditCardNoTextFld: UITextField!
    @IBOutlet weak var expiryDateBtn: UIButton!
    @IBOutlet weak var cvvTextFld: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    
    @IBAction func ExpiryDateBtnAction(sender: AnyObject) {
    }
    
    
    @IBAction func continueBtnAction(sender: AnyObject) {
    }
    
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

}
