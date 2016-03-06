//
//  MyAccountTableViewCell.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyAccountTableViewCell: UITableViewCell {

  @IBOutlet var accountItemImageView: UIImageView!
  @IBOutlet var accountItemTitleLbl: UILabel!
  @IBOutlet var accountItemSubTitleLbl: UILabel!
  
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
