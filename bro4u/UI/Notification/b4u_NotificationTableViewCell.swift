//
//  b4u_NotificationTableViewCell.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_NotificationTableViewCell: UITableViewCell {

  @IBOutlet var notificationTxtLbl: UILabel!
  @IBOutlet var dateTimeLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureData(notificationDataModel:b4u_NotificationModel)
    {
        if let notificationTxt = notificationDataModel.notifyDesc
        {
            self.notificationTxtLbl.text = notificationTxt
        }
        if let dateTime = notificationDataModel.timestamp
        {
            self.dateTimeLbl.text = dateTime
        }
    }

}
