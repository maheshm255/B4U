//
//  b4u-PaymentViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

enum paymentOption: Int{
   case kPaytm = 0
   case kPayUMoney
   case kNetBanking
   case kCOD
}

protocol paymentDelegate
{
    func infoBtnClicked()
  
  func navigateToPaymentGateWay(gateWayOpton:paymentOption)

}
class b4u_PaymentViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var paymentTableView: UITableView!
    
    
     var dictArray: [Dictionary<String, String>] = [["Paytm":"10% Cashback"],
                 ["payUmoney":"1% instant off"],
                 ["Net banking/Credit/Debit":"Use Credit/Debit or Net banking"],
                 ["Cash On Service":"Pay cash on service"]]

//    var itemDict : NSDictionary = ["Paytm":"10% Cashback","payUmoney":"1% instant off",
//        "Net banking/Credit/Debit":"Use Credit/Debit or Net banking",
//        "Cash On Service":"Pay cash on service"]
    
    var radioButtonSelected:NSIndexPath!
    
    var delegate:paymentDelegate?

    
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var tfCouponCode: UITextField!
    @IBOutlet weak var imgViewDonwArrow: UIImageView!
    @IBOutlet weak var lblHaveCouponCode: UILabel!
    @IBOutlet weak var viewCouponCode: UIView!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var lblAmount: UILabel!

    
    override func viewDidLoad() {
      
        
    self.lblAmount.text = "  Rs. \( bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.custPrice!)  "

    let tapGesture = UITapGestureRecognizer(target:self, action:"applyCouponCodeViewTaped")
        tapGesture.numberOfTouchesRequired = 1
    self.viewCouponCode.addGestureRecognizer(tapGesture)
        
      self.addLoadingIndicator()
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        super.viewDidLoad()
      b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

        // Do any additional setup after loading the view.
       
        //To Give Shadow to tableview
        self.paymentTableView.layer.shadowColor  = UIColor.grayColor().CGColor
        self.paymentTableView.layer.shadowOffset  = CGSizeMake(3.0, 3.0)
        self.paymentTableView.layer.shadowRadius  = 0.2
        self.paymentTableView.layer.shadowOpacity  = 1
        self.paymentTableView.clipsToBounds  = false
        self.paymentTableView.layer.masksToBounds  = false
    }

    
    func applyCouponCodeViewTaped()
    {
        self.imgViewDonwArrow.hidden = true
        self.lblHaveCouponCode.hidden = true
        
        self.btnApply.hidden = false
        self.tfCouponCode.hidden = false
    }
    @IBAction func applyCouponBtnClicked(sender: AnyObject)
    {
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
        
        return dictArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "paymentSelectionTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_PaymentTblViewCell
        let itemDict: NSDictionary   = dictArray[indexPath.row]
        cell.typeLabel?.text = itemDict.allKeys[0] as? String
        cell.infoLabel?.text = itemDict.valueForKey((itemDict.allKeys[0] as? String)!) as? String
        
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
    
    @IBAction func placeOrder(sender: AnyObject){
      
      switch radioButtonSelected.row {
      case 0:
        delegate?.navigateToPaymentGateWay(paymentOption.kPaytm)
      case 1:
        delegate?.navigateToPaymentGateWay(paymentOption.kPayUMoney)
      case 2:
        delegate?.navigateToPaymentGateWay(paymentOption.kNetBanking)
      case 3:
        delegate?.navigateToPaymentGateWay(paymentOption.kCOD)
      default:
        break
      }
      
    }

  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }

  @IBAction func showDetailBtnClicked(sender: AnyObject) {
    
    self.showAlertView()
  }

  
  func showAlertView()
  {
     self.delegate?.infoBtnClicked()
    
  }
 
  
    
  }
