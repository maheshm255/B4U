//
//  MyOrderViewController.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyOrderViewController: UIViewController {

    @IBOutlet weak var orderTableView: UITableView!
  
    var onGoingOrderArray:[b4u_OrdersModel]?
    var pastOrdersArray:[b4u_OrdersModel]?
    
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
        
        self.onGoingOrderArray = self.filterContent("Completed", orderType:orderTypes.kOnGoingOrders)

        self.pastOrdersArray = self.filterContent("Completed", orderType:orderTypes.kCompetedOrders)

     //   self.onGoingOrderArray = self.filterContent("Completed", scope:"")
        
        print(onGoingOrderArray)
        orderTableView.reloadData()
        
    }
    
    private func filterContent(searchText:String , orderType:orderTypes)->[b4u_OrdersModel]?
        
    {
        let allOreders =  bro4u_DataManager.sharedInstance.orderData
        
        var filteredItems:[b4u_OrdersModel]?
        if ( allOreders.count > 0)
        {
            
            filteredItems =   allOreders.filter({m in
                
                if let orderDesc = m.statusDesc
                    
                {
                    switch orderType
                    {
                    case .kOnGoingOrders:
                        return orderDesc.contains(searchText)
                    case .kCompetedOrders:
                        return !orderDesc.contains(searchText)

                    }
                    
                }else
                    
                {
                    return false
                }
                
            })
            
        }
        
        return filteredItems
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
    if section == 0 && self.onGoingOrderArray?.count>0 {
        return (self.onGoingOrderArray?.count)!

    }
    else if section == 1 && self.pastOrdersArray?.count>0{
        return (self.pastOrdersArray?.count)!
    }
    
    return 0
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cellIdentifier = ""
    let reOrderModel:b4u_OrdersModel?
    
    if indexPath.section == 0
    {
      cellIdentifier = "OngoingOrdersTableViewCellID"
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! OngoingOrdersTableViewCell
    
      cell.configureData(self.onGoingOrderArray![indexPath.row])

      return cell
    }
    else{
        cellIdentifier = "PastOrdersTableViewCellID"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PastOrdersTableViewCell
        
        cell.configureData(self.pastOrdersArray![indexPath.row])

        return cell

    }
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
