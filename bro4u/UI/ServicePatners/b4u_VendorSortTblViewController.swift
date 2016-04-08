//
//  b4u-FilterViewController.swift
//  bro4u
//
//  Created by Mac on 07/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

enum sortOpbion:Int
{
    case  kSortPriceHighToLow = 0
    case  kSortPriceLowToHigh = 1
    case  kSortNearToFar = 2
    case  kSortPopularity = 3
    case  kNone = 4
    
}

protocol vendorSortDelegate: NSObjectProtocol {
    
    func sortUsinOption(aSortOption:sortOpbion)
}


class b4u_VendorSortTblViewController: UITableViewController {
    
    
    @IBOutlet weak var imgViewCellSelection4: UIImageView!
    @IBOutlet weak var imgViewCellSelection3: UIImageView!
    @IBOutlet weak var imgViewCellSelection1: UIImageView!
    
    @IBOutlet weak var imgViewCellSelection2: UIImageView!
    
    var selectedIndexPath:NSIndexPath?
    
    var selectedSorting:sortOpbion = sortOpbion.kNone
    
    var delegate:vendorSortDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let aIndexPath = self.selectedIndexPath
        {
            switch aIndexPath.row
            {
            case sortOpbion.kSortPriceHighToLow.rawValue :
                print("hight to low")
                self.imgViewCellSelection1.image = UIImage(named:"radioGray")
            case sortOpbion.kSortPriceLowToHigh.rawValue :
                print("low to high")
                self.imgViewCellSelection2.image = UIImage(named:"radioGray")
            case sortOpbion.kSortNearToFar.rawValue :
                print("Near to far")
                self.imgViewCellSelection3.image = UIImage(named:"radioGray")
            case sortOpbion.kSortPopularity.rawValue :
                self.imgViewCellSelection4.image = UIImage(named:"radioGray")
                print("by popularity")
            default :
                print("Default sorting")
            }
            
        }
        
        
        
        switch indexPath.row
        {
        case sortOpbion.kSortPriceHighToLow.rawValue :
            print("hight to low")
            self.imgViewCellSelection1.image = UIImage(named:"radioBlue")
            selectedSorting = sortOpbion.kSortPriceHighToLow
        case sortOpbion.kSortPriceLowToHigh.rawValue :
            print("low to high")
            self.imgViewCellSelection2.image = UIImage(named:"radioBlue")
            selectedSorting = sortOpbion.kSortPriceLowToHigh

        case sortOpbion.kSortNearToFar.rawValue :
            print("Near to far")
            self.imgViewCellSelection3.image = UIImage(named:"radioBlue")
            selectedSorting = sortOpbion.kSortNearToFar

        case sortOpbion.kSortPopularity.rawValue :
            self.imgViewCellSelection4.image = UIImage(named:"radioBlue")
            selectedSorting = sortOpbion.kSortPopularity

            print("by popularity")
        default :
            print("Default sorting")
            selectedSorting = sortOpbion.kNone

        }
        
        self.selectedIndexPath = indexPath

    }
    
    @IBAction func btnSortAction(sender: AnyObject)
    {
        delegate?.sortUsinOption(self.selectedSorting)
        self.dismissViewControllerAnimated(true, completion:nil)
    }
}
