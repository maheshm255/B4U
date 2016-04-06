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

class b4u_NetBankingViewController: UIViewController {

    var payUMoneyCntrl:UIViewController?

    var saltKey:String?
    
    @IBOutlet weak var iciciBtn: UIButton!
    @IBOutlet weak var sbiBtn: UIButton!
    @IBOutlet weak var hdfcBtn: UIButton!
    @IBOutlet weak var axisBtn: UIButton!
    @IBOutlet weak var selectBankBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var totalAmountLbl: UILabel!
    
    
    
    @IBAction func bankBtnAction(sender: AnyObject) {
        
        switch sender.tag{
        case selectBank.kICICI.rawValue :
            selectBankBtn.setTitle("ICICI NetBanking", forState: UIControlState.Normal)

        case selectBank.kHDFC.rawValue :
            selectBankBtn.setTitle("HDFC Bank", forState: UIControlState.Normal)

        case selectBank.kSBI.rawValue :
            selectBankBtn.setTitle("State Bank Of India", forState: UIControlState.Normal)

        case selectBank.kAXIS.rawValue :
            selectBankBtn.setTitle("AXIS Bank NetBanking", forState: UIControlState.Normal)

        default :
            break

        
        }
    }
    
    @IBAction func selectBankBtnAction(sender: AnyObject) {
    }
    
    @IBAction func continueBtnAction(sender: AnyObject) {
   
        self.startPayment()
    
    }
    
    func startPayment(){
        
        self.payUMoneyCntrl = PayUMoneyViewController()
        self.navigationController?.pushViewController(self.payUMoneyCntrl!, animated: true)

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
