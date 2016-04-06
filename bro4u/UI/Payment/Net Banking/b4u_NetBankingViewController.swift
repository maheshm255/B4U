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

class b4u_NetBankingViewController: UIViewController,UIPopoverPresentationControllerDelegate,timeSlotDelegate {

    var payUMoneyCntrl:PayUMoneyViewController?
    var paymentType:String?
    var selectedBankCode:String?
    var pListArray: NSArray = []

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
   
        payUMoneyCntrl = PayUMoneyViewController()
        payUMoneyCntrl?.paymentType = PAYMENT_PG_NET_BANKING
        payUMoneyCntrl?.selectedBankCode = selectedBankCode


        self.navigationController?.pushViewController(self.payUMoneyCntrl!, animated: true)
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.readPlist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readPlist(){
        
        let path = NSBundle.mainBundle().pathForResource("BankListAndCodes", ofType: "plist")
        pListArray = NSArray(contentsOfFile: path!)!
    }


    @IBAction func selectBankBtnAction(sender: AnyObject) {
        
//        b4u_BankList(bankListArray:dataDict["timeslots"] as! [String])
//        
//        if  pListArray.count > 0
//        {
//            let btn = sender as! UIButton
//            
//            
//            let storyboard : UIStoryboard = self.storyboard!
//            
//            //        UIStoryboard(name:"Main",bundle: nil)
//            
//            let timeSlotController:b4u_TimeSlotViewCtrl = storyboard.instantiateViewControllerWithIdentifier("b4uTimeSlotCtrl") as! b4u_TimeSlotViewCtrl
//            
//            timeSlotController.modalPresentationStyle = .Popover
//            timeSlotController.preferredContentSize = CGSizeMake(150, 300)
//            
//            timeSlotController.delegate = self
//            //  timeSlotController.delegate = self
//            
//            let popoverMenuViewController = timeSlotController.popoverPresentationController
//            popoverMenuViewController?.permittedArrowDirections = .Up
//            popoverMenuViewController?.delegate = self
//            popoverMenuViewController?.sourceView = btn
//            popoverMenuViewController?.sourceRect = CGRect(
//                x: CGRectGetMidX(btn.bounds),
//                y: CGRectGetMidY(btn.frame),
//                width: 1,
//                height: 1)
//            presentViewController(
//                timeSlotController,
//                animated: true,
//                completion: nil)
//            
//        }
        
    }

    //MARKS: timeSlot selecteion delegate
    func didSelectTimeSlot(tiemSlot:String)
    {
        self.selectBankBtn!.setTitle(tiemSlot, forState:UIControlState.Normal)
        
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
