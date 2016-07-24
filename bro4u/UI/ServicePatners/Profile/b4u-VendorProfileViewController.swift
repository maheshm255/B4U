  //
//  b4u-VendorProfileViewController.swift
//  bro4u
//
//  Created by Mac on 01/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_VendorProfileViewController: UIViewController , UIWebViewDelegate ,UIScrollViewDelegate{
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var horizontalSepLeading: NSLayoutConstraint!
    @IBOutlet weak var detailBaseViewHeight: NSLayoutConstraint!
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
    
    
    var allWebApiSuccessCount:Int = 0
    var webViewdescHieghtConstraint: NSLayoutConstraint!

    var itemWebViewHeightConstraint: NSLayoutConstraint!
    
    var ratingChartWebView:UIWebView?
    var itemDescroptionWebView:UIWebView?
    
    
    var heightForDescription:CGFloat = 0.0
    var heightForReviews:CGFloat = 0.0
    var heightForAboutPartner:CGFloat = 0.0
    
    var partnerReviewsCtrl:b4u_PartnerReviewsTblViewCtrl?
    
    var currentPage:Int{// The index of the current page (readonly)
        
        get{
            
            let width = view.bounds.size.width - 20
            let page = Int((self.scrollViewDetails.contentOffset.x / width))
                return page
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       self.scrollViewBase.hidden = true
       self.getItemPriceChart()
       self.getItemDescriptionIndex()
       self.getProfileData()
        


    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    
    func getItemPriceChart()
    {
        let itemId = bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.itemId!
        let params = "?item_id=\(itemId)&\(kAppendURLWithApiToken)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kPriceChartIndex, params:params, result:{(resultObject) -> Void in
            
            self.allWebApiSuccessCount++

            self.configureUI()
            
        })
    }
    
    func getItemDescriptionIndex()
    {
        
        let itemId = bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.itemId!
        let params = "?item_id=\(itemId)&\(kAppendURLWithApiToken)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kItemDescriptionIndex, params:params, result:{(resultObject) -> Void in
            
            self.allWebApiSuccessCount++
            
            self.configureUI()
        })
    }
    
    
    func getProfileData()
    {
        
        let selectedDate = NSDate.dateFormat().stringFromDate(bro4u_DataManager.sharedInstance.selectedDate!)
        
        let selectedTime = bro4u_DataManager.sharedInstance.selectedTimeSlot!
        
        let params = "/\(bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.itemId!)\(bro4u_DataManager.sharedInstance.userSelectedFilterParams!)&service_date=\(selectedDate)&service_time=\(selectedTime)&\(kAppendURLWithApiToken)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kViewProfileIndex, params:params, result:{(resultObject) -> Void in
            
            self.allWebApiSuccessCount++
            self.configureUI()
        })
    }
    
    
    func configureUI()
    {

        if self.allWebApiSuccessCount == 3
        {
            self.scrollViewBase.hidden = false

            self.configureWebViews()
            
            if bro4u_DataManager.sharedInstance.vendorProfile?.reviews?.count > 0
            {
                self.addReviews()

            }
            self.configurePartnerUI()
            
            self.scrollViewDetails.pagingEnabled = true
            self.scrollViewDetails.scrollEnabled=true
            self.scrollViewDetails.delegate = self
            
            let width  = UIScreen.mainScreen().bounds.width
            let height  = self.scrollViewDetails.bounds.height
            
            self.scrollViewDetails.contentSize  = CGSizeMake(3 * width,height)
           
            self.detailBaseViewHeight.constant = self.heightForDescription + 10

            if let profileModelObj = bro4u_DataManager.sharedInstance.vendorProfile
            {
                
                self.imgViewTopBackground.downloadedFrom(link:profileModelObj.defaultBanner!, contentMode:UIViewContentMode.ScaleToFill)
                
                
                self.vendorIcon.downloadedFrom(link:profileModelObj.profilePic!, contentMode:UIViewContentMode.ScaleToFill)
                
                self.lblVendorName.text = profileModelObj.vendorName!
                self.lblVendorType.text = profileModelObj.catName!
                
                self.lblNumberOReviews.text = "\(profileModelObj.serviceQuality!)% Positive"
                
                self.lblFeedback.text = "\(profileModelObj.reviewCount!) Reviews"
                
                
                self.lblTimeSince.text = "Since \(profileModelObj.inBusiness!)"
                
                self.lblNumberOfJobDone.text = " \(profileModelObj.completedJob!) "
                
                self.lblNumberOfProfiles.text = " \(profileModelObj.profileViews!) "
                
                self.lblPrice.text = "  Rs. \( bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.offerPrice!)  "
                //Modified after One Bug
//                self.lblPrice.text = "  Rs. \( bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.priceBoost!)  "

                
                self.btnReview.setTitle("Reviews(\(profileModelObj.reviewCount!))", forState:UIControlState.Normal)

            }
            
            
            
            if bro4u_DataManager.sharedInstance.selectedSuggestedPatner!.premiumPartner! == "yes"
            {
                self.imgViewG.hidden = false
            }else
            {
               self.imgViewG.hidden = true
                
            }
            
            self.lblNumberOfProfiles.layer.cornerRadius = 1.0
            self.lblNumberOfProfiles.layer.borderWidth = 1.0
            self.lblNumberOfProfiles.layer.borderColor = UIColor(red:142.0/255, green: 142.0/255, blue: 142.0/255, alpha:1.0).CGColor
            
            
            self.lblNumberOfJobDone.layer.cornerRadius = 1.0
            self.lblNumberOfJobDone.layer.borderWidth = 1.0
            self.lblNumberOfJobDone.layer.borderColor =  UIColor(red:142.0/255, green: 142.0/255, blue: 142.0/255, alpha:1.0).CGColor
            
            
        }
    }
    
    func configureWebViews()
    {
        self.configureItemDescriptinWebView()
        self.configureRatingChartWebView()
        self.webViewConstraints(10.0)

    }
    
    
    func addReviews()
    {

        
        partnerReviewsCtrl =   self.storyboard?.instantiateViewControllerWithIdentifier("partnerReviewCtrl") as! b4u_PartnerReviewsTblViewCtrl
        
        partnerReviewsCtrl!.tableView.scrollEnabled = false
        
        self.scrollViewDetails.addSubview(partnerReviewsCtrl!.view)

        partnerReviewsCtrl!.view.translatesAutoresizingMaskIntoConstraints = false

        
       self.detailBaseViewHeight.constant = CGFloat((bro4u_DataManager.sharedInstance.vendorProfile?.reviews?.count)!) * 117.0 + 165

        let height:CGFloat = CGFloat((bro4u_DataManager.sharedInstance.vendorProfile?.reviews?.count)!) * 117.0 + 165
        
        
        self.heightForReviews = height
        
        let metricDict = ["w":partnerReviewsCtrl!.view.bounds.size.width - 20,"h":height]

        
        
        partnerReviewsCtrl!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(h)]", options:[], metrics: metricDict, views: ["view":partnerReviewsCtrl!.view]))
        
        partnerReviewsCtrl!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":partnerReviewsCtrl!.view]))
        
        
        let width  = UIScreen.mainScreen().bounds.width - 5

        
        let leading = NSLayoutConstraint(item:partnerReviewsCtrl!.view, attribute:.Leading, relatedBy: .Equal, toItem:self.scrollViewDetails, attribute:.Leading, multiplier:1.0, constant:width)
        
        self.scrollViewDetails.addConstraint(leading)
        
      
        let top = NSLayoutConstraint(item:partnerReviewsCtrl!.view, attribute:.Top, relatedBy: .Equal, toItem:self.scrollViewDetails, attribute:.Top, multiplier:1.0, constant:1.0)
        
        self.scrollViewDetails.addConstraint(top)
        
    }
    
    func configurePartnerUI()
    {
      
        
        if let aboutVendor = bro4u_DataManager.sharedInstance.vendorProfile?.aboutVendor
        {
            let label = UITextView()
            
            label.userInteractionEnabled = false
            
            label.backgroundColor = UIColor.whiteColor()
            label.text =  "About Us \n" + aboutVendor

          let height =   label.text.heightForWithFont(UIFont(name:"Helvetica", size:16.0)!, width:UIScreen.mainScreen().bounds.width-30, insets:UIEdgeInsets(top:10, left: 10, bottom: 10, right: 10)
)
            
            label.layer.cornerRadius = 2.0
            label.layer.borderColor = UIColor.lightGrayColor().CGColor
            label.layer.borderWidth = 1.0
            
            label.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0);
            
            self.scrollViewDetails.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.textColor = UIColor(colorLiteralRed:74.0/255, green: 74.0/255, blue: 74.0/255, alpha:1.0)
            
            label.font = UIFont(name:"Helvetica", size:16.0)
            
            label.textColor = UIColor.lightGrayColor()
            
            let width  = UIScreen.mainScreen().bounds.width
            
            
            let leading = NSLayoutConstraint(item:label, attribute:.Leading, relatedBy: .Equal, toItem:self.scrollViewDetails, attribute:.Leading, multiplier:1.0, constant:2 * width - 20)
            
            self.scrollViewDetails.addConstraint(leading)
            
            
            let top = NSLayoutConstraint(item:label, attribute:.Top, relatedBy: .Equal, toItem:self.scrollViewDetails, attribute:.Top, multiplier:1.0, constant:2)
            
            self.scrollViewDetails.addConstraint(top)
            
            let metricDict = ["w":self.view.bounds.size.width - 10 ,"H":height]
            
            
            label.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":label]))
            
            label.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(H)]", options:[], metrics: metricDict, views: ["view":label]))
            
            self.heightForAboutPartner = height
//            
//            let tralling = NSLayoutConstraint(item:label, attribute:.Trailing, relatedBy: .Equal, toItem:self.scrollViewDetails, attribute:.Trailing, multiplier:1.0, constant:10.0)
            //
       //     self.scrollViewDetails.addConstraint(tralling)

        }
        
        
     
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    
    func configureRatingChartWebView()
    {
        ratingChartWebView = UIWebView()
        
        ratingChartWebView?.scrollView.scrollEnabled = false
        
        ratingChartWebView?.delegate = self
        
        ratingChartWebView!.translatesAutoresizingMaskIntoConstraints = false

     //   self.setRatignChartWebViewConstraint(100.00)
        
        if let htmlStr = bro4u_DataManager.sharedInstance.vendorPriceChartHtmlString
        {
            self.ratingChartWebView?.loadHTMLString(htmlStr, baseURL:nil)
        }else
        {
            self.itemDescroptionWebView?.loadHTMLString("", baseURL:nil)
            
        }
    }
    
    
    func configureItemDescriptinWebView()
    {
        self.itemDescroptionWebView = UIWebView()
        
        itemDescroptionWebView?.scrollView.scrollEnabled = false

        self.itemDescroptionWebView!.delegate = self
        
        self.itemDescroptionWebView!.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let htmlStr = bro4u_DataManager.sharedInstance.vendorDescriptinHtmlString
        {
            self.itemDescroptionWebView?.loadHTMLString(htmlStr, baseURL:nil)
        }else
        {
            self.itemDescroptionWebView?.loadHTMLString("", baseURL:nil)

        }
    }
    
    func webViewConstraints(height:CGFloat)
    {
        
        self.detailBaseViewHeight.constant = 2 * height

        self.scrollViewDetails.addSubview(itemDescroptionWebView!)
        self.scrollViewDetails.addSubview(ratingChartWebView!)
        
        let metricDict = ["w":self.scrollViewDetails.bounds.size.width - 10 ,"h":height]
 
    
        self.itemWebViewHeightConstraint = NSLayoutConstraint(item:self.itemDescroptionWebView!, attribute:NSLayoutAttribute.Height, relatedBy:NSLayoutRelation.Equal, toItem:nil, attribute:.Height, multiplier:1.0, constant:height)
        
        self.itemDescroptionWebView!.addConstraint( self.itemWebViewHeightConstraint)
        
        self.itemDescroptionWebView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":itemDescroptionWebView!]))
        
        
        
        let leading = NSLayoutConstraint(item:itemDescroptionWebView!, attribute:.Leading, relatedBy: .Equal, toItem:self.scrollViewDetails, attribute:.Leading, multiplier:1.0, constant:0.0)
        
        self.scrollViewDetails.addConstraint(leading)
        
        
        let top = NSLayoutConstraint(item:itemDescroptionWebView!, attribute:.Top, relatedBy: .Equal, toItem:self.scrollViewDetails, attribute:.Top, multiplier:1.0, constant:1.0)
        
        self.scrollViewDetails.addConstraint(top)
        
        
        
//        self.scrollViewDetails.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]|", options:[], metrics: nil, views: ["view":itemDescroptionWebView!]))
//        
//        self.scrollViewDetails.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]", options:[], metrics: nil, views: ["view":itemDescroptionWebView!]))
//        
        
        
        
        self.webViewdescHieghtConstraint = NSLayoutConstraint(item:self.ratingChartWebView!, attribute:NSLayoutAttribute.Height, relatedBy:NSLayoutRelation.Equal, toItem:nil, attribute:.Height, multiplier:1.0, constant:height)
        
        ratingChartWebView!.addConstraint( self.webViewdescHieghtConstraint)
        
        ratingChartWebView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":ratingChartWebView!]))
        
        
        let topConstraint = NSLayoutConstraint(item:ratingChartWebView!, attribute:.Top, relatedBy:.Equal, toItem:self.itemDescroptionWebView!, attribute:.Bottom, multiplier:1.0, constant:20.0)
        
        self.scrollViewDetails.addConstraint(topConstraint)
        
        let leading1 = NSLayoutConstraint(item:ratingChartWebView!, attribute:.Leading, relatedBy: .Equal, toItem:self.scrollViewDetails, attribute:.Leading, multiplier:1.0, constant:0.0)
        
        self.scrollViewDetails.addConstraint(leading1)
        
        
//        self.scrollViewDetails.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[view]|", options:[], metrics: nil, views: ["view":ratingChartWebView! , "itemWebView":itemDescroptionWebView!]))
        
//        self.scrollViewDetails.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]", options:[], metrics: nil, views: ["view":ratingChartWebView!]))

    }
    @IBAction func btReviewPressed(sender: AnyObject)
    {
        let width = self.scrollViewDetails.bounds.size.width
        self.scrollViewDetails.setContentOffset(CGPointMake(width, 0), animated:true)
        
        self.horizontalSepLeading.constant = 1 * self.btnAbountPartner.bounds.size.width

        self.detailBaseViewHeight.constant = self.heightForReviews
        
        
        self.detailBaseViewHeight.constant = self.heightForReviews
        
        self.btnDescroption.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
        
        self.btnReview.setTitleColor(UIColor(red:0.0/255, green:141.0/255, blue:181.0/255, alpha:1.0), forState: .Normal)
        
        self.btnAbountPartner.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
    }

    @IBAction func btnAbountPartner(sender: AnyObject)
    {
        let width = self.scrollViewDetails.bounds.size.width
        self.scrollViewDetails.setContentOffset(CGPointMake(2 * width, 0), animated:true)

        self.horizontalSepLeading.constant = 2 * self.btnAbountPartner.bounds.size.width
        self.detailBaseViewHeight.constant = self.heightForAboutPartner
        
        self.detailBaseViewHeight.constant = self.heightForAboutPartner
        
        self.btnDescroption.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
        self.btnReview.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
        self.btnAbountPartner.setTitleColor(UIColor(red:0.0/255, green:141.0/255, blue:181.0/255, alpha:1.0), forState: .Normal)


    }
    @IBAction func btnDescriptionPressed(sender: AnyObject)
    {
        self.scrollViewDetails.setContentOffset(CGPointMake(0, 0), animated:true)
        
        self.horizontalSepLeading.constant = 0 * self.btnAbountPartner.bounds.size.width
        self.detailBaseViewHeight.constant = self.heightForDescription

        self.detailBaseViewHeight.constant = self.heightForDescription
        
        self.btnDescroption.setTitleColor(UIColor(red:0.0/255, green:141.0/255, blue:181.0/255, alpha:1.0), forState: .Normal)

        self.btnReview.titleLabel?.textColor = UIColor(red:139.0/255, green:139.0/255, blue:139.0/255, alpha:1.0)
        self.btnAbountPartner.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
        
    }
    
    internal func webViewDidFinishLoad(webView: UIWebView)
    {
        let height = webView.scrollView.contentSize.height;
        
        
        self.detailBaseViewHeight.constant =
            self.detailBaseViewHeight.constant + height

        
        
        if webView == self.itemDescroptionWebView
        {
            
            self.itemWebViewHeightConstraint.constant = height
        }
        else if webView == self.ratingChartWebView
        {
         self.webViewdescHieghtConstraint.constant = height

        }
        
        self.heightForDescription =  self.itemWebViewHeightConstraint.constant +  self.webViewdescHieghtConstraint.constant + 20

    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        self.updateUI()
    }
    
    func updateUI()
    {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
          
            print(self.currentPage)
            self.horizontalSepLeading.constant = CGFloat(self.currentPage) * self.btnAbountPartner.bounds.size.width
            
            if self.currentPage == 0
            {
                self.detailBaseViewHeight.constant = self.heightForDescription
                
                self.btnDescroption.titleLabel?.textColor = UIColor(red:0.0/255, green:141.0/255, blue:181.0/255, alpha:1.0)
                self.btnReview.titleLabel?.textColor = UIColor(red:139.0/255, green:139.0/255, blue:139.0/255, alpha:1.0)
                self.btnAbountPartner.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
                
            }else  if self.currentPage == 1
            {
                self.detailBaseViewHeight.constant = self.heightForReviews
                
                self.btnDescroption.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
                self.btnReview.titleLabel?.textColor = UIColor(red:0.0/255, green:141.0/255, blue:181.0/255, alpha:1.0)
                self.btnAbountPartner.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
                
            }
            else  if self.currentPage == 2
            {
                self.detailBaseViewHeight.constant = self.heightForAboutPartner

                self.btnDescroption.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
                self.btnReview.titleLabel?.textColor = UIColor(red:139.9/255, green:139.0/255, blue:139.0/255, alpha:1.0)
                self.btnAbountPartner.titleLabel?.textColor = UIColor(red:0.0/255, green:141.0/255, blue:181.0/255, alpha:1.0)
                
            }
            
        })
    }
    @IBAction func btnBookNowPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("paymentCtrlSegue", sender:sender)

    }
}
