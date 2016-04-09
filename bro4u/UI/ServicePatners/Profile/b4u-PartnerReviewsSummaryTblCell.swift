//
//  b4u-PartnerReviewsSummaryTblCell.swift
//  bro4u
//
//  Created by Mac on 09/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_PartnerReviewsSummaryTblCell: UITableViewCell {

    @IBOutlet weak var constraintLblQualityWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintOnTimeLblWidth: NSLayoutConstraint!
    @IBOutlet weak var imgViewOnTime: UIImageView!
    @IBOutlet weak var imgViewQuality: UIImageView!
    @IBOutlet weak var lblOnTimeQuality: UILabel!
    @IBOutlet weak var lblOnTimePositive: UILabel!
    @IBOutlet weak var lblReviewPositive: UILabel!
    @IBOutlet weak var lblReviewPrecentage: UILabel!
    @IBOutlet weak var lblFromRatings: UILabel!
    @IBOutlet weak var imgViewStar5: UIImageView!
    @IBOutlet weak var imgViewStar4: UIImageView!
    @IBOutlet weak var imgViewStar3: UIImageView!
    @IBOutlet weak var imgViewStar2: UIImageView!
    @IBOutlet weak var imgViewStar1: UIImageView!
    
    
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
        let profileModelObj = bro4u_DataManager.sharedInstance.vendorProfile!

        self.lblFromRatings.text = "From ratings by \(profileModelObj.reviewCount!) users"
        
        self.lblReviewPrecentage.text = profileModelObj.averageRatingPercent!
        
        self.lblOnTimePositive.text = "\(profileModelObj.onTime!)% Positive"
    
        self.lblOnTimeQuality.text = "\(profileModelObj.serviceQuality!)% Positive"
        
        
        switch "\(Int(profileModelObj.averageRating!))"
        {
        case "4":
            self.imgViewStar5.image = UIImage(named:"starGrey")
        case "3":
            self.imgViewStar5.image = UIImage(named:"starGrey")
            self.imgViewStar4.image = UIImage(named:"starGrey")
            
        case "2":
            self.imgViewStar5.image = UIImage(named:"starGrey")
            self.imgViewStar4.image = UIImage(named:"starGrey")
            self.imgViewStar3.image = UIImage(named:"starGrey")
            
        case "1":
            self.imgViewStar5.image = UIImage(named:"starGrey")
            self.imgViewStar4.image = UIImage(named:"starGrey")
            self.imgViewStar3.image = UIImage(named:"starGrey")
            self.imgViewStar2.image = UIImage(named:"starGrey")
            
        case "0":
            self.imgViewStar5.image = UIImage(named:"starGrey")
            self.imgViewStar4.image = UIImage(named:"starGrey")
            self.imgViewStar3.image = UIImage(named:"starGrey")
            self.imgViewStar2.image = UIImage(named:"starGrey")
            self.imgViewStar1.image = UIImage(named:"starGrey")
        default:
            print("")
        }
        
    }

}
