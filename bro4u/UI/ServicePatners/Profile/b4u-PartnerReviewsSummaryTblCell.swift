//
//  b4u-PartnerReviewsSummaryTblCell.swift
//  bro4u
//
//  Created by Mac on 09/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_PartnerReviewsSummaryTblCell: UITableViewCell {

    @IBOutlet weak var constraintLblOnTImeTrailing: NSLayoutConstraint!
    @IBOutlet weak var constraintLblQualityTrailing: NSLayoutConstraint!
    @IBOutlet weak var imgViewQualityBase: UIImageView!
    @IBOutlet weak var imgViewOnTimeBase: UIImageView!
 
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

        self.lblFromRatings.text = "Rated by \(profileModelObj.reviewCount!) users"
        
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
        
        
        self.imgViewOnTimeBase.layoutIfNeeded()
        
        
        var width = CGRectGetWidth(self.imgViewOnTimeBase.bounds)
        
         var aWidth = ( width * CGFloat(Int(profileModelObj.onTime!)!) ) / 100
        
        self.constraintLblOnTImeTrailing.constant =  self.constraintLblOnTImeTrailing.constant +  width - aWidth
        
        
         width = CGRectGetWidth(self.imgViewOnTimeBase.bounds)
        
         aWidth = ( width * CGFloat(Int(profileModelObj.serviceQuality!)!) ) / 100
        
        self.constraintLblQualityTrailing.constant =  self.constraintLblQualityTrailing.constant + width - aWidth
        
        
        self.imgViewOnTime.layer.cornerRadius = 2.0
        self.imgViewOnTimeBase.layer.cornerRadius = 2.0
        self.imgViewQuality.layer.cornerRadius = 2.0
        self.imgViewQualityBase.layer.cornerRadius = 2.0

        
        self.layer.cornerRadius = 2.0
        
    }

}
