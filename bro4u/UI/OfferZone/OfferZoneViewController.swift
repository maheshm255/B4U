//
//  OfferZoneViewController.swift
//  ThanksScreen
//
//  Created by Rahul on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class OfferZoneViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var offerZoneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        
        //user_id = "1"
        let deviceID = "kdsflasdf"
        
        let params = "?device_id=\(deviceID)&user_id=\(user_id)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kOfferZoneIndex , params:params, result:{(resultObject) -> Void in
            
            print(" Offer Zone Data Received")
            
            print(resultObject)
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            self.congigureUI()
            
        })
    }
    
    
    func congigureUI()
    {
        offerZoneTableView.reloadData()
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
        return bro4u_DataManager.sharedInstance.offerZoneData.count
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let textCellIdentifier = "OfferZoneTableViewCellID"
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! OfferZoneTableViewCell
      
        let offerZoneModel:b4u_OfferZoneModel = bro4u_DataManager.sharedInstance.offerZoneData[indexPath.section]

        cell.configureData(offerZoneModel)

        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.grayColor().CGColor

      
        return cell
    }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
    if section == 0
    {
      return 1.0;
    }
    else
    {
      return 10.0;
    }

  }


  
  @IBAction func cancelBtnClicked(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion:nil)
  }
  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }


}
