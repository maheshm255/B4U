//
//  b4u-ServicePatnerController.swift
//  bro4u
//
//  Created by Tools Team India on 25/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ServicePatnerController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var tableViewServicePatner: UITableView!
    var selectedCategoryObj:b4u_Category?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.callServicePatnerApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if let aSelectedCatObj = selectedCategoryObj
        {
            let catId = aSelectedCatObj.catId!
            let latitude =  "12.9718915"
            let longitude = "77.6411545"
            
            
            let params = "?cat_id=\(catId)&latitude=\(latitude)&longitude=\(longitude)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(kShowServicePatnerApi, params:params, result:{(resultObject) -> Void in
                
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
        
        
        let aPatner:b4u_SugestedPartner = (bro4u_DataManager.sharedInstance.suggestedPatnersResult?.suggestedPatners![indexPath.section])!
        
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
        
        if let suggestedPatners = bro4u_DataManager.sharedInstance.suggestedPatnersResult?.suggestedPatners
        {
            return suggestedPatners.count
        }
        return 0

    }// Default is 1 if

    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
        {
         return 182.0
    }
}
