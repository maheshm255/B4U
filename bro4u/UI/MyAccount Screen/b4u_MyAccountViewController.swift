//
//  MyAccountViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class b4u_MyAccountViewController: UIViewController {

  @IBOutlet var nameLbl: UILabel!
  @IBOutlet var walletBalanceLbl: UILabel!
  @IBOutlet var userImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  
   var pListArray: NSArray = []
   var modelArr:[b4u_MyAccountModel] = Array()
   var walletBalanceValue: NSNumber = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.readPlist()
        self.getData()
        
    }
    
    func readPlist(){
        
        let path = NSBundle.mainBundle().pathForResource("MyAccount", ofType: "plist")
         pListArray = NSArray(contentsOfFile: path!)!
    }
    
    func getData()
    {
        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyAccountIndex, params:"", result:{(resultObject) -> Void in
            
            print("My Account Data Received")
            
            print(resultObject)
            
            self.updateUI()
            
            
        })
    }
    
    
    func updateUI()
    {
        if let accountDetails = bro4u_DataManager.sharedInstance.myAccountData
        {
            walletBalanceValue = accountDetails.walletBalance!
            self.walletBalanceLbl.text = "Wallet Balance Rs. \( accountDetails.walletBalance!)"
            self.nameLbl.text = accountDetails.fullName
            self.tableView.reloadData()
        }
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
    }
    

  
  //Tableview Data Source
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return pListArray.count
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return 1
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cellIdentifier = ""
    var cell  = MyAccountTableViewCell()
    
    cellIdentifier = "MyAccountTableViewCellID"
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MyAccountTableViewCell
    
    let dict = pListArray.objectAtIndex(indexPath.section) as! NSDictionary
    
    cell.accountItemTitleLbl.text = dict.objectForKey("title") as? String//
    if(indexPath.section == 1){
        cell.accountItemSubTitleLbl.text = "\(dict.objectForKey("subTitle")) \(walletBalanceValue)"
    }
    else{
        cell.accountItemSubTitleLbl.text = dict.objectForKey("subTitle") as? String //
    }
    
    cell.accountItemImageView.image = UIImage(named: (dict.objectForKey("icon") as? String)!)
    
    return cell
  }
  
  
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 105.0;
  }
  
    
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var destination = UIViewController()
        if cell != nil {
            // Set the CellID
            switch(indexPath.section){
            case 0:
                destination = storyboard.instantiateViewControllerWithIdentifier("MyOrderViewControllerID") as! MyOrderViewController

            case 1:
                destination = storyboard.instantiateViewControllerWithIdentifier("MyWalletViewControllerID") as! MyWalletViewController

            case 2:
                destination = storyboard.instantiateViewControllerWithIdentifier("MyInfoViewControllerID") as! MyInfoViewController

            case 3:
                destination = storyboard.instantiateViewControllerWithIdentifier("NotificationViewControllerID") as! b4u_NotificationViewController

            default:
                break
                
            }
            navigationController?.pushViewController(destination, animated: true)

        }
    }
//
//  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//    
//    cell.contentView.backgroundColor = UIColor.clearColor()
//    let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 90))
//    whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
//    whiteRoundedView.layer.masksToBounds = false
//    whiteRoundedView.layer.cornerRadius = 3.0
//    whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
//    whiteRoundedView.layer.shadowOpacity = 0.5
//    cell.contentView.addSubview(whiteRoundedView)
//    cell.contentView.sendSubviewToBack(whiteRoundedView)
//  }
  
    @IBAction func cancelBtnClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
}
