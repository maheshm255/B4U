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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
