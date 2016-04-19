//
//  b4u_PayOnlineOrderViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 22/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit



class b4u_PayOnlineOrderViewController: UIViewController,paymentDelegate {

    @IBOutlet weak var btnPaytm: UIButton!
    
    @IBOutlet weak var btnCreditCard: UIButton!
    
    @IBOutlet weak var btnNetBanking: UIButton!
    
    @IBOutlet weak var paytmOffer: UILabel!
    
    @IBOutlet weak var imageViewPaytm: UIImageView!
    
    @IBOutlet weak var imageViewCreditCard: UIImageView!
    
    @IBOutlet weak var imageViewNetBanking: UIImageView!
    
    var btnSelected:NSNumber?
    
    
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
    
    self.dismissViewControllerAnimated(true, completion:nil)
  }
    
    
    @IBAction func actionPayNow(sender: AnyObject) {
        

//        if btnSelected?.integerValue > 0 {
//            
//            switch btnSelected {
//            case 1:
//                delegate?.navigateToPaymentGateWay(paymentOption.kPaytm+1)
//            case 2:
//                delegate?.navigateToPaymentGateWay(paymentOption.kCCDC+1)
//            case 3:
//                delegate?.navigateToPaymentGateWay(paymentOption.kNetBanking+1)
//            default:
//                break
//            }
//        }

    }
    
    
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

    //Function to Navigate for Payment Screen
    func navigateToPaymentGateWay(gateWayOpton:paymentOption)
    {
        
        switch gateWayOpton {
            
//        case paymentOption.kPaytm :
            
//            self.createOrderForPayTm()
            
        case paymentOption.kCCDC :
            
            self.performSegueWithIdentifier("creditCardViewController", sender:nil)
            
        case paymentOption.kNetBanking :
            self.performSegueWithIdentifier("netBankingCtrl", sender:nil)
        default :
            break
        }
        
        
    }

    func infoBtnClicked()
    {
    }


}
