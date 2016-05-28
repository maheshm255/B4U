//
//  b4u_OrderDetailViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 22/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OrderDetailViewController: UIViewController {

  @IBOutlet weak var lblVendorName: UILabel!
  @IBOutlet weak var lblVendorDetail: UILabel!
  @IBOutlet weak var lbluserName: UILabel!
  @IBOutlet weak var lbluserEmail: UILabel!
  @IBOutlet weak var lblAddress: UILabel!
  @IBOutlet weak var lblPhoneNumber: UILabel!

    @IBOutlet weak var imgViewLine: UIImageView!
    @IBOutlet weak var lblSubTotalText: UILabel!
    @IBOutlet weak var lblWalletCouponOffersText: UILabel!
    @IBOutlet weak var lblNightDeliveryChargeText: UILabel!
    @IBOutlet weak var lblDeliveryChargesText: UILabel!
    @IBOutlet weak var lblGrandTotalText: UILabel!
    @IBOutlet weak var btnGotIt: UIButton!

    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblNightDeliveryCharge: UILabel!
    @IBOutlet weak var lblDeliveryCharges: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblWalletCouponOffers: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.congigureUI()
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

    
    func congigureUI()
    {
        if let address:b4u_AddressDetails = bro4u_DataManager.sharedInstance.address[0]{
            
            lbluserName.text = address.name!
            lbluserEmail.text = address.email!
            lblPhoneNumber.text = address.phoneNumber!
            lblAddress.text = address.fullAddress!
        }
        if let selectedPartner:b4u_SugestedPartner = bro4u_DataManager.sharedInstance.selectedSuggestedPatner{
            
            lblVendorDetail.text = selectedPartner.itemName!
            lblVendorName.text = selectedPartner.vendorName!
            lblSubTotal.text = selectedPartner.custPrice!
            
            if let orderDetailModel = bro4u_DataManager.sharedInstance.orderDetailData.first
            {
                if let selectionLocal: b4u_SelectionModel =  orderDetailModel.selection?.first{
                    
                    if let subTotal = selectionLocal.subTotal
                    {
                        lblSubTotal.text = "\(subTotal)"
                    }
                    if let deliveryCharge = selectionLocal.deliveryCharge
                    {
                        lblDeliveryCharges.text = "+ \(deliveryCharge)"
                    }
                    if let nightCharge = selectionLocal.nightCharge
                    {
                        lblNightDeliveryCharge.text = " + \(nightCharge)"

                    }
                    if let deductedFromWallet = selectionLocal.deductedFromWallet,deductedUsingCoupon = selectionLocal.deductedUsingCoupon
                    {
                        lblWalletCouponOffers.text = " - \(deductedFromWallet.integerValue + deductedUsingCoupon.integerValue)"
                    }
                    if let grandTotal = selectionLocal.grandTotal
                    {
                        lblGrandTotal.text = "\(grandTotal)"
                    }


                }
            }

        }
    }

  @IBAction func btnCloseClicked(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion:nil)
  }
  


}
