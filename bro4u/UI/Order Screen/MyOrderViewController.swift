//
//  MyOrderViewController.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyOrderViewController: UIViewController {

  
    var myOrderModelArr:[b4u_MyInfoModel] = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.getData()
        
    }
    
    func getData()
    {
        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyOrdersIndex, params:"", result:{(resultObject) -> Void in
            
            print("My Order Data Received")
            
            print(resultObject)
            
            self.congigureUI()
            
            
        })
    }
    
    
    func congigureUI()
    {
        
     
        
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
//       cell = OngoingOrdersTableViewCell()
      cellIdentifier = "OngoingOrdersTableViewCellID"
      cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! OngoingOrdersTableViewCell

    }
    else if indexPath.row == 0 && indexPath.section == 1
    {
//        cell = PastOrdersTableViewCell()
      cellIdentifier = "PastOrdersTableViewCellID"
      cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PastOrdersTableViewCell
    }

    

    return cell
  }
  
  
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        if indexPath.section == 0
        {
            return 350;
        }
        else if indexPath.section == 1
        {
            return 221;
        }
        
        return 0
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
  
  @IBAction func cancelBtnClicked(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion:nil)
  }

  
}
