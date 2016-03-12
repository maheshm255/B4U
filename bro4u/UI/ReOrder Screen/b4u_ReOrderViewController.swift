//
//  b4u_ReOrderViewController.swift
//  ThanksScreen
//
//  Created by Rahul on 11/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class b4u_ReOrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.getData()
        
    }
    @IBAction func btnCancelClicked(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    func getData()
    {
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReOrderIndex, params:"", result:{(resultObject) -> Void in
            
            print("My Info Data Received")
            
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
    

    //Tableview Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cellIdentifier = "ReOrderTableViewCellID"
        let cell:b4u_ReOrderTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! b4u_ReOrderTableViewCell
        
        return cell
    }
    
    
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 105.0;
//    }
    
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        cell.contentView.backgroundColor = UIColor.clearColor()
//        let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 90))
//        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
//        whiteRoundedView.layer.masksToBounds = false
//        whiteRoundedView.layer.cornerRadius = 3.0
//        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
//        whiteRoundedView.layer.shadowOpacity = 0.5
//        cell.contentView.addSubview(whiteRoundedView)
//        cell.contentView.sendSubviewToBack(whiteRoundedView)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
