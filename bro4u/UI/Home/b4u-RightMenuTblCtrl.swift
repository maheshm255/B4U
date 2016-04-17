//
//  b4u-RightMenuTblCtrl.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//
import UIKit
import FBSDKLoginKit

class b4u_RightMenuTblCtrl: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        NSString *phoneNumber = [@"tel://" stringByAppendingString:mymobileNO.titleLabel.text];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    
    @IBOutlet weak var lblLogin: UILabel!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        let hasLoggedInd:Bool = NSUserDefaults.standardUserDefaults().boolForKey("isUserLogined")
        if hasLoggedInd
        {
            lblLogin.text = "Logout"
        }else
        {
            lblLogin.text = "Login"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        
        if segue.identifier == "loginSegue"
        {
            let navCtrl = segue.destinationViewController as! UINavigationController
            
            let loginCtrl = navCtrl.topViewController as! b4u_LoginViewCtrl
            
            loginCtrl.loginForm = loginFormScreen.kRightMenu
            
        }
        
    }

    
    internal override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5 {
            NSNotificationCenter.defaultCenter().postNotificationName(kRightMenuNotification, object: indexPath)
        }
        
        if indexPath.row == 1
        {
            let url = NSURL(string:"tel://08030323232")!
            
            if UIApplication.sharedApplication().canOpenURL(url)
            {
                UIApplication.sharedApplication().openURL(url)
            }else
            {
                print("Call is not supported")
            }
        } //Rahul
        else if indexPath.row == 4
        {
         
          let url = NSURL(string:"https://itunes.apple.com/de/app/x-gift/id839686104?mt=8&uo=4")!
          
          if UIApplication.sharedApplication().canOpenURL(url)
          {
            UIApplication.sharedApplication().openURL(url)
          }else
          {
            print("No App available")
          }
        }
        else if(indexPath.row == 6)
        {
            let hasLoggedInd:Bool = NSUserDefaults.standardUserDefaults().boolForKey("isUserLogined")
            if hasLoggedInd
            {
                if bro4u_DataManager.sharedInstance.loginInfo?.loginType == "OTP"
                {
                                       
                }else if bro4u_DataManager.sharedInstance.loginInfo?.loginType == "googleSignIn"
                {
                      GIDSignIn.sharedInstance().signOut()
                }else if  bro4u_DataManager.sharedInstance.loginInfo?.loginType == "facebook"
                {
                    FBSDKLoginManager().logOut()
                    
                }
                
                NSUserDefaults.standardUserDefaults().removeObjectForKey("isUserLogined")
                lblLogin.text = "Login"
                bro4u_DataManager.sharedInstance.loginInfo = nil
                print("LoggeOut Successfully")
                
                NSNotificationCenter.defaultCenter().postNotificationName(kLoginDismissed, object:nil)

            }else
            {
                dispatch_async(dispatch_get_main_queue(), {
                    self.performSegueWithIdentifier("loginSegue", sender:nil)
                })
            }
            
        }
    }
    
}
