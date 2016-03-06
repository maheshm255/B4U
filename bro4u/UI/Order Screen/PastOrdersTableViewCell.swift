//
//  PastOrdersTableViewCell.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class PastOrdersTableViewCell: UITableViewCell {

  
  @IBOutlet var userImageView: UIImageView!
  @IBOutlet var titleLbl: UILabel!
  @IBOutlet var subTitleLbl: UILabel!
  @IBOutlet var dateLbl: UILabel!
  @IBOutlet var timeSlotLbl: UILabel!
  @IBOutlet var dateTimeLbl: UILabel!
  @IBOutlet var orderIDLbl: UILabel!
  @IBOutlet var serviceStatusLbl: UILabel!
  @IBOutlet var bookingLbl: UILabel!
  @IBOutlet var priceLbl: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
