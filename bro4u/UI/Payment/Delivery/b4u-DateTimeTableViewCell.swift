//
//  b4u-DateTimeTableViewCell.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_DateTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewSelect: UIImageView!
    @IBOutlet weak var btnLblSelectTIme: UIButton!
    @IBOutlet weak var btnSelectDate: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
