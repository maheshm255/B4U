//
//  b4u-PaymentViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

enum paymentOption{
   case kNone
   case kPaytem
   case kPayUMoney
   case kNetBanking
   case kCOD
}
class b4u_PaymentViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    var itemDict : NSDictionary = ["Paytm":"10% Cashback","payUmoney":"1% instant off",
        "Net banking/Credit/Debit":"Use Credit/Debit or Net banking",
        "Cash On Service":"Pay cash on service"]
    var radioButtonSelected:NSIndexPath!
    
    var selectedPaymentOption:paymentOption = paymentOption.kNone
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

    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemDict.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "paymentSelectionTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_PaymentTblViewCell
        
        cell.typeLabel?.text = itemDict.allKeys[indexPath.row] as? String
        cell.infoLabel?.text = itemDict.valueForKey((itemDict.allKeys[indexPath.row] as? String)!) as? String
        
        if radioButtonSelected != nil{
            if radioButtonSelected.isEqual(indexPath){
                cell.radioImageView.image = UIImage(named: "radioBlue")
            }
            else
            {
                cell.radioImageView.image = UIImage(named: "radioGray")
            }
        }
        
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! b4u_PaymentTblViewCell
        if radioButtonSelected != nil
        {
            let selectedcell = tableView.cellForRowAtIndexPath(radioButtonSelected) as! b4u_PaymentTblViewCell
            selectedcell.radioImageView.image = UIImage(named: "radioGray")
        }
        cell.radioImageView.image = UIImage(named: "radioBlue")
        radioButtonSelected = indexPath
        
    }
    
//    @IBAction func placeOrder(sender: AnyObject){
//        
////          let paytmViewController :PaytmViewController = PaytmViewController()
////          self.navigationController?.pushViewController(paytmViewController, animated: true)
////            let payUmoneyViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PaymentSCVC") as? PayUMoneyViewController
////
////        self.performSegueWithIdentifier("paymentSegue", sender:nil)
//
////        let payUmoneyViewController :PayUMoneyViewController = PayUMoneyViewController()
////        self.navigationController?.pushViewController(paytmViewController, animated: true)
//        
//        let payUmoneyViewController :PayUMoneyWebPaymentViewController = PayUMoneyWebPaymentViewController()
//        self.navigationController?.pushViewController(payUmoneyViewController, animated: true)
//    }

    
}
