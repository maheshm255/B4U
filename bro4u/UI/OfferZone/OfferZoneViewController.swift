//
//  OfferZoneViewController.swift
//  ThanksScreen
//
//  Created by Rahul on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class OfferZoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Offer Zone"
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

    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let textCellIdentifier = "OfferZoneTableViewCellID"
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.grayColor().CGColor
        
        return cell
    }
    
    
}
