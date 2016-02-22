//
//  b4u-CategoryTblViewCtrl.swift
//  bro4u
//
//  Created by Tools Team India on 19/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CategoryTblViewCtrl: UITableViewController ,HeaderViewDelegate{

    var categoryAndSubOptions:[b4u_Category] = Array()
    var sectionOpen:Int = NSNotFound

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // let categoryObj = self.categoryAndSubOptions[section]
       //(categoryObj.attributeOptins?.count)!
        return categoryAndSubOptions.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryTblCell", forIndexPath: indexPath) as! b4u_CategoryTableViewCell

        // Configure the cell...

        let categoryObj = self.categoryAndSubOptions[indexPath.row]
        cell.configureData1(categoryObj)
        return cell
    }


//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        
//        let categoryObj = self.categoryAndSubOptions[section]
//
//        return b4u_CategoryTblHeaderVIew(tableViewCtrl:self, section:section, categoryObj:categoryObj)
//    }
//    
//    
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
    
    func headerViewOpen(section:Int)
    {
        if self.sectionOpen != NSNotFound {
            headerViewClose(self.sectionOpen)
        }
        
     
        self.sectionOpen = section
        let numberOfRows =   self.categoryAndSubOptions[section].attributeOptins!.count//self.tableView.dataSource?.tableView(self.tableView, numberOfRowsInSection:section)
        var indexesPathToInsert:[NSIndexPath] = []
        
        for var i = 0; i < numberOfRows; i++ {
            indexesPathToInsert.append(NSIndexPath(forRow: i, inSection: section))
        }
        
        self.tableView.beginUpdates()
        
        if indexesPathToInsert.count > 0 {
            self.tableView.beginUpdates()
           self.tableView.insertRowsAtIndexPaths(indexesPathToInsert, withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.endUpdates()
        }
    }
    func headerViewClose(section:Int)
    {
        
        let numberOfRows =   self.tableView.dataSource?.tableView(self.tableView, numberOfRowsInSection:section)
        var indexesPathToDelete:[NSIndexPath] = []
        self.sectionOpen = NSNotFound
        
        for var i = 0 ; i < numberOfRows; i++ {
            indexesPathToDelete.append(NSIndexPath(forRow: i, inSection: section))
        }
        
        if indexesPathToDelete.count > 0 {
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths(indexesPathToDelete, withRowAnimation: UITableViewRowAnimation.Top)
            self.tableView.endUpdates()
        }
    }
    
    internal override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)

    {
        self.performSegueWithIdentifier("interMediateSegue", sender:nil)
    }
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
        
        if segue.identifier == "interMediateSegue"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let categoryObj = self.categoryAndSubOptions[indexPath.row]
                
                let navCtrl = segue.destinationViewController as! UINavigationController
                
                let intermediateScreenCtrlObj = navCtrl.topViewController as! b4u_IntermediateViewCtrl
                intermediateScreenCtrlObj.selectedCategoryObj = categoryObj
   
            }
        }
    }
    

}
