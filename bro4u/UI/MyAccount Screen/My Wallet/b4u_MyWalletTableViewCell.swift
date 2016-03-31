//
//  b4u_MyWalletTableViewCell.swift
//  bro4u
//
//  Created by MSP-User3 on 31/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_MyWalletTableViewCell: UITableViewCell {

  @IBOutlet var dateTimeLbl: UILabel!
  @IBOutlet var commentsLbl: UILabel!
  @IBOutlet var amountLbl: UILabel!
  @IBOutlet var activityTypeBtn: UIButton!

  @IBAction func activityBtnAction(sender: AnyObject) {
    
  }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
  func configureData(myWalletDataModel:b4u_MyWalletModel)
  {
    if let dateTime = myWalletDataModel.timestamp
    {
      self.dateTimeLbl.text = dateTime
    }
    if let commentsStr = myWalletDataModel.comments
    {
      self.commentsLbl.text = commentsStr
    }
    if let amount = myWalletDataModel.amount
    {
      self.amountLbl.text = amount
    }
    if let activityType = myWalletDataModel.activityType
    {
      self.activityTypeBtn.setTitle(activityType, forState: .Normal)
    }

  }

}
