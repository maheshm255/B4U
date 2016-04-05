//
//  b4u-PaymentTblViewCell.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_PaymentTblViewCell: UITableViewCell {

    
    @IBOutlet weak var radioImageView:UIImageView!
    @IBOutlet weak var typeImageView:UIImageView!
    @IBOutlet weak var typeLabel:UILabel!
    @IBOutlet weak var infoLabel:UILabel!
    @IBOutlet weak var checkBoxImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
