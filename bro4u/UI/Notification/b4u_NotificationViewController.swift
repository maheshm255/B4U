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
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    self.title = "Notification"
    mainTableView.rowHeight = UITableViewAutomaticDimension
    mainTableView.estimatedRowHeight = 160.0
    self.addLoadingIndicator()

    self.getData()

  }
    
    
    func getData()
    {
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        var user_id = ""
        
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
            
            user_id = loginInfoData.userId! //Need to use later
            
        }
        
        let deviceID = "asdkfi"
        //user_id = "1626"

        let params = "?device_id=\(deviceID)&user_id=\(user_id)&\(kAppendURLWithApiToken)"

        b4u_WebApiCallManager.sharedInstance.getApiCall(kOrderNotificationIndex , params:params, result:{(resultObject) -> Void in
            
            print(" Notification Data Received")
            
            print(resultObject)
            
            self.congigureUI()
            
        })
    }
    
    
    func congigureUI()
    {
      mainTableView.reloadData()
      b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

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
  
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return bro4u_DataManager.sharedInstance.notificationData.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }

  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCellWithIdentifier("NotificationTableViewCellID") as! b4u_NotificationTableViewCell
    
    let notificationModelObj:b4u_NotificationModel = bro4u_DataManager.sharedInstance.notificationData[indexPath.section]

    cell.configureData(notificationModelObj)

    cell.layer.borderWidth = 1.0
    cell.layer.borderColor = UIColor.grayColor().CGColor

    b4u_Utility.shadowEffectToView(cell)

    return cell
  }
  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }

  
}
