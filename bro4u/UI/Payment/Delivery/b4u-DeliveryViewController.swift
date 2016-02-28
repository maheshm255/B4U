//
//  b4u-DeliveryViewController.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_DeliveryViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    
    
    
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

    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        switch indexPath.section
        {
        case 0 :
            let cellIdentifier = "dateAndTimeCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_DateAndTImeSelectionTblCell
            
            return cell
        case 1:
            let cellIdentifier = "addressCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_AddressTblCell
            
            cell.addAddressBtn.addTarget(self, action:"btnAddAddressSelected", forControlEvents:UIControlEvents.TouchUpInside)
            return cell
            
        case 2 :
            let cellIdentifier = "commentsCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_CommentTableViewCell
            
            return cell
            
        default:
            
            let cellIdentifier = "commentsCell"

            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
            
            return cell
        }

        
    }
    
  
    
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch indexPath.section
        {
        case 0 :
            return 90.0

        case 1:
            return 150.0

            
        case 2 :
            return 50.0

            
        default:
            return 0.0
        }
    }
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        
    }
    


    @IBAction func proceedToPaymetnBtnClicked(sender: AnyObject) {
    }
    
    
    func btnAddAddressSelected()
    {
        
    }
}
