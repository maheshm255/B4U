//
//  b4u-VendorProfileViewController.swift
//  bro4u
//
//  Created by Mac on 01/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_VendorProfileViewController: UIViewController {
    
    @IBOutlet weak var horizontalSeperatorView: UIImageView!
    @IBOutlet weak var baseViewScrollDetail: UIView!
    @IBOutlet weak var btnAbountPartner: UIButton!
    @IBOutlet weak var btnDescroption: UIButton!
    @IBOutlet weak var btnReview: UIButton!
    @IBOutlet weak var lblNumberOfProfiles: UILabel!
    @IBOutlet weak var lblNumberOfJobDone: UILabel!
    @IBOutlet weak var lblTimeSince: UILabel!
    @IBOutlet weak var imgViewG: UIImageView!
    @IBOutlet weak var imgViewCheckBox: UIImageView!

    @IBOutlet weak var lblNumberOReviews: UILabel!
    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var lblVendorType: UILabel!
    @IBOutlet weak var scrollViewDetails: UIScrollView!
    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var vendorIcon: UIImageView!
    @IBOutlet weak var imgViewTopBackground: UIImageView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var scrollViewBase: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addReviews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    
    func addReviews()
    {
        let partnerReviewsCtrl:b4u_PartnerReviewsTblViewCtrl =   self.storyboard?.instantiateViewControllerWithIdentifier("partnerReviewCtrl") as! b4u_PartnerReviewsTblViewCtrl
        
        partnerReviewsCtrl.view.translatesAutoresizingMaskIntoConstraints = false

        
        self.scrollViewDetails.addSubview(partnerReviewsCtrl.view)
        
        
        let metricDict = ["w":partnerReviewsCtrl.view.bounds.size.width,"h":self.scrollViewDetails.frame.size.height]

        
        
        partnerReviewsCtrl.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(h)]", options:[], metrics: metricDict, views: ["view":partnerReviewsCtrl.view]))
        partnerReviewsCtrl.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":partnerReviewsCtrl.view]))
        
        self.scrollViewDetails.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]|", options:[], metrics: nil, views: ["view":partnerReviewsCtrl.view]))
        
        self.scrollViewDetails.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]", options:[], metrics: nil, views: ["view":partnerReviewsCtrl.view]))

        
//       
//        let leading = NSLayoutConstraint(item:partnerReviewsCtrl.view, attribute:NSLayoutAttribute.Leading, relatedBy:NSLayoutRelation.Equal, toItem:self.scrollViewDetails, attribute:NSLayoutAttribute.Leading, multiplier:1.0, constant:0.0)
//        
//        self.scrollViewDetails.addConstraint(leading)
//     
//        let top = NSLayoutConstraint(item:partnerReviewsCtrl.view, attribute:NSLayoutAttribute.Top, relatedBy:NSLayoutRelation.Equal, toItem:self.scrollViewDetails, attribute:NSLayoutAttribute.Top, multiplier:1.0, constant:0.0)
//        
//        self.scrollViewDetails.addConstraint(top)
//        
//        let trailing = NSLayoutConstraint(item:partnerReviewsCtrl.view, attribute:NSLayoutAttribute.Trailing, relatedBy:NSLayoutRelation.Equal, toItem:self.scrollViewDetails, attribute:NSLayoutAttribute.Trailing, multiplier:1.0, constant:0.0)
//        
//        self.scrollViewDetails.addConstraint(trailing)
//        
//        let bottom = NSLayoutConstraint(item:partnerReviewsCtrl.view, attribute:NSLayoutAttribute.Bottom, relatedBy:NSLayoutRelation.Equal, toItem:self.scrollViewDetails, attribute:NSLayoutAttribute.Bottom, multiplier:1.0, constant:0.0)
//        
//        self.scrollViewDetails.addConstraint(bottom)
//        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btReviewPressed(sender: AnyObject)
    {
    }

    @IBAction func btnAbountPartner(sender: AnyObject)
    {
    }
    @IBAction func btnDescriptionPressed(sender: AnyObject)
    {
    }
}
