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
  
  @IBAction func tapToCopyBtnAction(sender: AnyObject) {
  
  }
  
  
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
            self.offerCodeLbl.text = couponCode
        }
    }


}
