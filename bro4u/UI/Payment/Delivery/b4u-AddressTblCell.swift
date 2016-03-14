//
//  b4u-AddressTblCell.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_AddressTblCell: UITableViewCell {
    @IBOutlet weak var addAddressBtn: UIButton!

    @IBOutlet weak var imgViewSelectAddress1: UIImageView!
    @IBOutlet weak var viewAddress2: UIView!
    @IBOutlet weak var viewAddress1: UIView!
    @IBOutlet weak var btnDeleteAddress2: UIButton!
    
    @IBOutlet weak var btnDeleteAddress1: UIButton!
    
    @IBOutlet weak var imgViewSelecteAddress2: UIImageView!
    @IBOutlet weak var lblAddress2: UILabel!
    @IBOutlet weak var lblAddress1: UILabel!
    @IBOutlet weak var imgViewAddressSelect: NSLayoutConstraint!
    @IBOutlet weak var imgViewSelect: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
