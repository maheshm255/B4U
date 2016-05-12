//
//  OfferZoneTableViewCell.swift
//  ThanksScreen
//
//  Created by Rahul on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class OfferZoneTableViewCell: UITableViewCell {

  @IBOutlet var titleOfferLbl: UILabel!
  @IBOutlet var titleDetailLbl: UILabel!
  @IBOutlet var offerCodeLbl: UILabel!
  
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureData(offerZoneDataModel:b4u_OfferZoneModel)
    {
        if let header = offerZoneDataModel.header
        {
            self.titleOfferLbl.text = header
        }
        if let descriptionValue = offerZoneDataModel.descriptionValue
        {
            self.titleDetailLbl.text = descriptionValue
        }
        if let couponCode = offerZoneDataModel.couponCode
        {
            
            self.offerCodeLbl.layer.borderWidth = 1
            self.offerCodeLbl.layer.borderColor = UIColor.lightGrayColor().CGColor

            self.offerCodeLbl.text = couponCode
        }
    }
  
    @IBAction func tapToCopyBtnAction(sender: AnyObject) {
      
      bro4u_DataManager.sharedInstance.copiedCopunCode = self.offerCodeLbl.text
      
      self.superview!.makeToast(message:"Coupon code is copied", duration:1.0 , position: HRToastPositionDefault)
      
    }

  
}
