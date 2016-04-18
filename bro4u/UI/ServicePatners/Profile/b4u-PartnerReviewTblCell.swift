//
//  b4u-PartnerReviewTblCell.swift
//  bro4u
//
//  Created by Mac on 03/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_PartnerReviewTblCell: UITableViewCell {

    @IBOutlet weak var btnReadM: UIButton!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureData(reviewModel:b4u_VendorReviews)
    {
        
        self.lblDate.text = reviewModel.timeStamp!
        self.lblTitle.text = reviewModel.fullName!
        self.lblComments.text = reviewModel.reivew!
        
        switch reviewModel.rating!
        {
        case "4":
            self.imgStar5.image = UIImage(named:"starGrey")
        case "3":
            self.imgStar5.image = UIImage(named:"starGrey")
            self.imgStar4.image = UIImage(named:"starGrey")

        case "2":
            self.imgStar5.image = UIImage(named:"starGrey")
            self.imgStar4.image = UIImage(named:"starGrey")
            self.imgStar3.image = UIImage(named:"starGrey")

        case "1":
            self.imgStar5.image = UIImage(named:"starGrey")
            self.imgStar4.image = UIImage(named:"starGrey")
            self.imgStar3.image = UIImage(named:"starGrey")
            self.imgStar2.image = UIImage(named:"starGrey")

        case "0":
            self.imgStar5.image = UIImage(named:"starGrey")
            self.imgStar4.image = UIImage(named:"starGrey")
            self.imgStar3.image = UIImage(named:"starGrey")
            self.imgStar2.image = UIImage(named:"starGrey")
            self.imgStar1.image = UIImage(named:"starGrey")
        default:
            print("")
        }
    }
}
