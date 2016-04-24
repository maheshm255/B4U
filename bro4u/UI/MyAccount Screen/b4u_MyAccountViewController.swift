//
//  MyAccountViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class b4u_MyAccountViewController: UIViewController {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewUserNotLoggedIn: UIView!
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loginDismissed", name:kUserDataReceived, object:nil);

     
        
        
        self.validateUser()
    }
   
    
    func validateUser()
    {
        self.viewTop.hidden = true
        
        let isUserLoggedIn =   NSUserDefaults.standardUserDefaults().objectForKey("isUserLogined")
        
        if let hasLogin:Bool = isUserLoggedIn as? Bool
        {
            if hasLogin
            {
                self.viewUserNotLoggedIn.hidden = true

                self.addLoadingIndicator()
                
                self.readPlist()
                self.getData()
                
            }
        }else
        {
            self.viewUserNotLoggedIn.hidden = false
            self.viewTop.hidden = true
        }
        
    }
    
    func readPlist(){
        
        let path = NSBundle.mainBundle().pathForResource("MyAccount", ofType: "plist")
         pListArray = NSArray(contentsOfFile: path!)!
    }
    
    func getData()
    {
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        var user_id = ""
      
        if let loginInfoData:b4u_LoginInfo = bro4u_DataManager.sharedInstance.loginInfo{
        
        user_id = loginInfoData.userId! //Need to use later
        
      }
      
//        user_id = "8"

      let params = "?user_id=\(user_id)"

        b4u_WebApiCallManager.sharedInstance.getApiCall(kMyAccountIndex, params:params, result:{(resultObject) -> Void in
            
            print("My Account Data Received")
            
            print(resultObject)
            
            self.viewTop.hidden = false

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
       b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

    }
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller
        
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
        cell.accountItemSubTitleLbl.text = "\(dict.objectForKey("subTitle")!) \(walletBalanceValue)"
    }
    else{
        cell.accountItemSubTitleLbl.text = dict.objectForKey("subTitle") as? String //
    }
    
    cell.accountItemImageView.image = UIImage(named: (dict.objectForKey("icon") as? String)!)
    
    return cell
  }
  
  
  
//  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//    return 105.0;
//  }
  
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0
        {
            return 3.0;
        }
        else
        {
            return 5.0;
        }
        
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

                self.performSegueWithIdentifier("walletCtrlSegue", sender:nil)

                return
            case 2:
                
                self.performSegueWithIdentifier("myInfoCtrl", sender:nil)

                return
            case 3:

                self.performSegueWithIdentifier("notificatinSegue", sender:nil)
                
                return
                
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
    
//    @IBAction func cancelBtnClicked(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion:nil)
//    }
    
    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
    
    @IBAction func okButtonClicked(sender: AnyObject)
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.performSegueWithIdentifier("accountloginSegue", sender:nil)
        })
    }
    
    func loginDismissed()
    {
        self.validateUser()
    }
    
}
