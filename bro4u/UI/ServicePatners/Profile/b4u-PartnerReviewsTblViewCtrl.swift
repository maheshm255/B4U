//
//  b4u-PartnerReviewsTblViewCtrl.swift
//  bro4u
//
//  Created by Mac on 03/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_PartnerReviewsTblViewCtrl: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if let reviews = bro4u_DataManager.sharedInstance.vendorProfile?.reviews
        {
            if reviews.count > 0
            {
                return reviews.count + 1
            }
        }
       
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("reviewSummaryCell", forIndexPath: indexPath) as! b4u_PartnerReviewsSummaryTblCell
            // Configure the cell...
            let reviewsModel:b4u_VendorReviews = (bro4u_DataManager.sharedInstance.vendorProfile?.reviews![indexPath.section])!
            
            cell.configureData(reviewsModel)
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewTblCell", forIndexPath: indexPath) as! b4u_PartnerReviewTblCell
        // Configure the cell...
        let reviewsModel:b4u_VendorReviews = (bro4u_DataManager.sharedInstance.vendorProfile?.reviews![indexPath.section])!
        
        cell.configureData(reviewsModel)
        
        cell.btnReadMore.tag = indexPath.section
        
        cell.btnReadMore.addTarget(self, action:"btnReadMorePressed:", forControlEvents:UIControlEvents.TouchUpInside)
//        

        return cell
    }
    
    override  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 165.0
        }
        return 117.0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        if section == 0
        {
            return 1.0
        }
        return 18.0
    }
    
//    func btnReadMorePressed(sender:AnyObject)
//    {
//        self.showReadMore()
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func showReadMore()
    {
        let storyboard : UIStoryboard = self.storyboard!
        
        let  alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("readMoreCtrl") as! b4u_ReviewReadMoreCtrl
        
        alertViewCtrl.modalPresentationStyle = .Popover
        alertViewCtrl.preferredContentSize = CGSizeMake(300, 400)
        
        let popoverMenuViewController = alertViewCtrl.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
       // popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.frame),
            y: CGRectGetMidY(self.view.frame),
            width: 1,
            height: 1)
        presentViewController(
            alertViewCtrl,
            animated: true,
            completion: nil)
        
    }
  
    
    @IBAction func btnReadMorePressed(sender: AnyObject)
    {
        self.showReadMore()

    }
  
}
