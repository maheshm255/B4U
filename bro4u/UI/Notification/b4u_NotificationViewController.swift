//
//  b4u_NotificationViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_NotificationViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

  @IBOutlet var mainTableView: UITableView!
  var dataSource: NSArray = []
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    self.title = "Notification"
    mainTableView.rowHeight = UITableViewAutomaticDimension
    mainTableView.estimatedRowHeight = 160.0
    
    self.dataSource = ["Hi Rahul Singh, Your order 30198 for Laundary Services is placed. Date 3-Mar at 1 PM-3PM. Amount Rs. 199 COD. Your request is in process & will receive updates from service partner shortly.",
      "Hi Rahul Singh, Your order 30053 for Plumbers is placed. date 1-Mar at 3PM-5PM. Visiting charge RS. 149 COD. Final quote will be provided upon inspection. Your request is in process & will receive updates from service partner shortly.",
      "Hi Handy Fix, Order ID 30053 has been cancelled by customer.We apologize for inconvenience caused",
      "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which lo  oks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
    ];
    self.getData()

  }
    
    
    func getData()
    {
        b4u_WebApiCallManager.sharedInstance.getApiCall(kOrderNotificationIndex, params:"", result:{(resultObject) -> Void in
            
            print("Notification Received")
            
            print(resultObject)
            
//            self.congigureUI()
            
            
        })
    }
    
    
    func congigureUI()
    {
        
        for (_ , mainData) in bro4u_DataManager.sharedInstance.myInfoData.enumerate()
        {
            
            
            if let filteredData = self.filterContent(mainData)
            {
                //                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("b4uCategoryTableView") as! b4u_CategoryTblViewCtrl
                
                let vc =  self.storyboard?.instantiateViewControllerWithIdentifier("MyInfoViewControllerID") as! MyInfoViewController
                
                vc.myInfoModelArr = filteredData
            }
        }
        
    }
    
    //Need to Implement
    private func filterContent(mainModelObj:b4u_MyInfoModel) -> [b4u_MyInfoModel]?
    {
        let filteredItems:[b4u_MyInfoModel]?
        if bro4u_DataManager.sharedInstance.myInfoData.count > 0
        {
            
            return nil
            
        }else
        {
            return nil
        }
        
        
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
  
  //pragma mark - Cell Setup
  
  
  func setUpCell(cell: b4u_NotificationTableViewCell , indexPath: NSIndexPath ){
    
    cell.notificationTxtLbl.text = self.dataSource.objectAtIndex(indexPath.row) as? String
    
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCellWithIdentifier("NotificationTableViewCellID") as! b4u_NotificationTableViewCell
    self.setUpCell(cell, indexPath: indexPath)
    
    return cell
  }
  
  
//  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//    
//    cell.contentView.backgroundColor = UIColor.clearColor()
//    let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, tableView.rowHeight-1))
//    whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
//    whiteRoundedView.layer.masksToBounds = false
//    whiteRoundedView.layer.cornerRadius = 3.0
//    whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
//    whiteRoundedView.layer.shadowOpacity = 0.5
//    cell.contentView.addSubview(whiteRoundedView)
//    cell.contentView.sendSubviewToBack(whiteRoundedView)
//    
//    
//  }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
