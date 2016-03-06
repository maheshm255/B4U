//
//  OngoingOrdersTableViewCell.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit



class OngoingOrdersTableViewCell: UITableViewCell {

  @IBOutlet var userImageView: UIImageView!
  @IBOutlet var tiltleLbl: UILabel!
  @IBOutlet var subTitleLbl: UILabel!
  @IBOutlet var dateLbl: UILabel!
  @IBOutlet var timeSlotLbl: UILabel!
  @IBOutlet var dateTimeLbl: UILabel!
  @IBOutlet var orderIDLbl: UILabel!
  @IBOutlet var statusLbl: UILabel!
  @IBOutlet var bookingLbl: UILabel!
  @IBOutlet var priceLbl: UILabel!
  
  
  
  @IBAction func cancelBtnAction(sender: AnyObject) {
  }
  
  @IBAction func trackBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func rescheduledBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func callBro4uAction(sender: AnyObject) {
  }
  
  
  @IBAction func payOnlineAction(sender: AnyObject) {
  }
  
  
  
  @IBOutlet var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
