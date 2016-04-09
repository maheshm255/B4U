//
//  b4u-ServicePartnerTblViewCell.swift
//  bro4u
//
//  Created by Tools Team India on 27/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ServicePartnerTblViewCell: UITableViewCell {
    @IBOutlet weak var lblCharges: UILabel!
    @IBOutlet weak var topConstraintChargesLbl: NSLayoutConstraint!

    @IBOutlet weak var leadingConstraingDiscounLbl: NSLayoutConstraint!
    @IBOutlet weak var btnViewDetails: UIButton!
    @IBOutlet weak var btnViewProfile: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnKing: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgViewProfilePic: UIImageView!
    
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var lblVendorDistance: UILabel!
    @IBOutlet weak var lblActualPrice: UILabel!
    @IBOutlet weak var lblVendorName: UILabel!
    
    @IBOutlet weak var lblVendorFeedBack: UILabel!
    
    @IBOutlet weak var lblVendorReiviews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
