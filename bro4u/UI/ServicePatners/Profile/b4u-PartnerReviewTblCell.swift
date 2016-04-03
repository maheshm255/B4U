//
//  b4u-PartnerReviewTblCell.swift
//  bro4u
//
//  Created by Mac on 03/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_PartnerReviewTblCell: UITableViewCell {

    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lblTitle: UILabel!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
