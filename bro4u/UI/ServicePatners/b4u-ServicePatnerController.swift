//
//  b4u-ServicePatnerController.swift
//  bro4u
//
//  Created by Tools Team India on 25/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ServicePatnerController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var viewLoadMore: UIView!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var tableViewServicePatner: UITableView!
    var selectedCategoryObj:b4u_Category?

    var selectedImgSlide:b4u_SliderImage?

    var allPatners:[b4u_SugestedPartner] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       // self.callServicePatnerApi()
        
        self.edgesForExtendedLayout = UIRectEdge.None
      self.addLoadingIndicator()
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        self.getAllServicePatners()
        self.checkLoadMoreCondition()
      b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getAllServicePatners()
    {
        if let patnersResult = bro4u_DataManager.sharedInstance.suggestedPatnersResult
        {
            self.allPatners.removeAll()
            self.allPatners = patnersResult.suggestedPatners! + patnersResult.otherPatners!

        }
    }
    func checkLoadMoreCondition()
    {
        if let patnersResult = bro4u_DataManager.sharedInstance.suggestedPatnersResult
        {
            if patnersResult.pageLoad == "yes"
            {
                self.btnLoadMore.setTitle("See \(patnersResult.nextPageSize!) more patners"
, forState:UIControlState.Normal)
            }else
            {
                self.viewLoadMore.hidden = true;
            }
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "servicePartnerMapViewCtrl"
        {
           // let ctrl = segue.destinationViewController as! b4u_ServicePatnerMapViewCtrl
            
        }
    }
    
    
    //cat_id=2&latitude=12.9718915&longitude=77.6411545

    
    func callServicePatnerApi()
    {

        if let aSelectedCatObj = selectedCategoryObj , patnersResult = bro4u_DataManager.sharedInstance.suggestedPatnersResult
        {
      
            self.serviceAPIRequest(aSelectedCatObj.catId!, nextPage:patnersResult.nextPage!)
        }else if let aSelectedImgObj = self.selectedImgSlide , patnersResult = bro4u_DataManager.sharedInstance.suggestedPatnersResult
        {
            self.serviceAPIRequest(aSelectedImgObj.catId!, nextPage:patnersResult.nextPage!)

        }
    }
    
    
    func serviceAPIRequest(catId:String , nextPage:NSNumber)
    {
        let catId = catId

        let latitude =  "12.9718915"
        let longitude = "77.6411545"
        let nextPage = nextPage
        
        let params = "/\(nextPage)?cat_id=\(catId)&latitude=\(latitude)&longitude=\(longitude)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kShowServicePatnerApi, params:params, result:{(resultObject) -> Void in
            
            self.getAllServicePatners()
            self.checkLoadMoreCondition()
            self.tableViewServicePatner.reloadData()
        })
    }
  
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("servicePatnerCell") as! b4u_ServicePartnerTblViewCell
        
        
        let aPatner:b4u_SugestedPartner = self.allPatners[indexPath.section]
        
        
        cell.imgViewProfilePic.downloadedFrom(link:aPatner.profilePic!, contentMode:UIViewContentMode.ScaleAspectFit)
        
        cell.lblVendorName.text = aPatner.vendorName
        cell.lblDiscount.text = aPatner.offerPrice
        cell.lblActualPrice.text = aPatner.custPrice
        cell.lblVendorReiviews.text = aPatner.reviewCount
        cell.lblVendorDistance.text = "\(aPatner.distance!) Kms away"
        
//        cell.contentView.layer.borderColor = UIColor.grayColor().CGColor
//        //cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.shadowColor = UIColor.blackColor().CGColor
//        cell.contentView.layer.shadowOpacity = 0.1
        
        
        if aPatner.premiumPartner == "yes"
        {
            cell.btnKing.hidden = false
        }else
        {
            cell.btnKing.hidden = true
 
        }
        
        cell.btnLike.addTarget(self, action:"btnShare:", forControlEvents:UIControlEvents.TouchUpInside)
        cell.btnLike.tag = indexPath.section
        
        return cell
    }
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        
//        if let suggestedPatners = bro4u_DataManager.sharedInstance.suggestedPatnersResult?.suggestedPatners
//        {
            return self.allPatners.count
//        }
        return 0

    }// Default is 1 if

    func btnShare(sender: AnyObject)
    {
        let textToShare = "Look at this awesome website for aspiring iOS Developers!"
        let myWebsite = NSURL(string: "http://www.codingexplorer.com/")
        let itemArr : NSArray = [textToShare,myWebsite!]
        let shareCntrlr = UIActivityViewController(activityItems: itemArr as [AnyObject], applicationActivities: nil)
        presentViewController(shareCntrlr, animated: true, completion: nil)
    }
    @IBAction func btnLoadMoreClicked(sender: AnyObject)
    {
        self.callServicePatnerApi()
    }
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
        {
         return 182.0
    }
    
      func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 1.0
            
        }
        return 10.0
    }
//      func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
//    {
//        if section == 0
//        {
//            return 0.001
//
//        }
//        return 4.0
//
//    }
  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }

}
