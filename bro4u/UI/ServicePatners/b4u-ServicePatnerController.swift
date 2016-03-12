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

    var allPatners:[b4u_SugestedPartner] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       // self.callServicePatnerApi()
        
        self.getAllServicePatners()
        self.checkLoadMoreCondition()
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
            let catId = aSelectedCatObj.catId!
            let latitude =  "12.9718915"
            let longitude = "77.6411545"
            let nextPage = patnersResult.nextPage
            
            let params = "/\(nextPage!)?cat_id=\(catId)&latitude=\(latitude)&longitude=\(longitude)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(kShowServicePatnerApi, params:params, result:{(resultObject) -> Void in
                
                self.getAllServicePatners()
                self.checkLoadMoreCondition()
                self.tableViewServicePatner.reloadData()
            })
        }
    }
    
  
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("servicePatnerCell") as! b4u_ServicePartnerTblViewCell
        
        
//        let aPatner:b4u_SugestedPartner = (bro4u_DataManager.sharedInstance.suggestedPatnersResult?.suggestedPatners![indexPath.section])!

        let aPatner:b4u_SugestedPartner = self.allPatners[indexPath.section]

        
         cell.imgViewProfilePic.downloadedFrom(link:aPatner.profilePic!, contentMode:UIViewContentMode.ScaleAspectFit)
        
          cell.lblVendorName.text = aPatner.vendorName
          cell.lblDiscount.text = aPatner.offerPrice
          cell.lblActualPrice.text = aPatner.custPrice
          cell.lblVendorReiviews.text = aPatner.reviewCount
          cell.lblVendorDistance.text = aPatner.distance
        
        cell.contentView.layer.borderColor = UIColor.grayColor().CGColor
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.shadowColor = UIColor.blackColor().CGColor
        cell.contentView.layer.shadowOpacity = 0.1
        
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

    @IBAction func btnLoadMoreClicked(sender: AnyObject)
    {
        self.callServicePatnerApi()
    }
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
        {
         return 182.0
    }
}
