//
//  MyOrderViewController.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyOrderViewController: UIViewController {

  
  
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
  
  //Tableview Data Source
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 2
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return 1
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cellIdentifier = ""
    var cell  = UITableViewCell()
    
    if indexPath.row == 0 && indexPath.section == 0
    {
      cellIdentifier = "OngoingOrdersTableViewCellID"
      cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! OngoingOrdersTableViewCell

    }
    else if indexPath.row == 0 && indexPath.section == 1
    {
      cellIdentifier = "PastOrdersTableViewCellID"
      cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PastOrdersTableViewCell
    }

    

    return cell
  }
  
  
//  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let  headerCell = tableView.dequeueReusableCellWithIdentifier("OngoingOrdersTableViewCellID") as! OngoingOrdersTableViewCell
//    headerCell.backgroundColor = UIColor.yellowColor()
//    
//    switch (section) {
//    case 0:
//      headerCell.headerLabel.text = "Ongoing Orders(1)";
//      //return sectionHeaderView
////    case 1:
////      headerCell.headerLabel.text = "Past Orders(1)";
////      //return sectionHeaderView
////    case 2:
////      headerCell.headerLabel.text = "South America";
////      //return sectionHeaderView
//    default:
//      headerCell.headerLabel.text = "Past Orders(1)";
//    }
//    
//    return headerCell
//  }
  
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let vw = UIView()
    
    vw.backgroundColor = UIColor.yellowColor()
    
    return vw
  }
  
}
