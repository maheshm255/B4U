//
//  b4u-SearchResultTblCtrl.swift
//  bro4u
//
//  Created by Tools Team India on 16/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_SearchResultTblCtrl: UITableViewController ,UISearchResultsUpdating,UISearchBarDelegate{

    var searchController:UISearchController!     // Search Controller replacement for UISearchDisplayController  from iOS 8.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.layoutMargins = UIEdgeInsetsZero
        
        bro4u_DataManager.sharedInstance.searchResult.removeAll()
        
        self.createSearchController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    /*
    Argument      : none
    Functionality : Called form ConfigureUi Funciton
    
    @This function create searchContrller Oject and do necessary setting to searchController
    
    */
    private func createSearchController()
    {
        self.searchController = ({
            // Setup One: This setup present the results in the current view.
            let controller = UISearchController(searchResultsController:nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.Black
            controller.searchBar.barTintColor = UIColor.whiteColor()
            controller.searchBar.backgroundColor = UIColor.clearColor()
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.delegate = self
            controller.searchBar.becomeFirstResponder()
            controller.searchBar.placeholder = "Search for Services"
            return controller
        })()
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.definesPresentationContext = true
        self.searchController.searchBar.delegate = self;
        
    }
    
    //MARK:- Private funcitons
    
    func callSearchApi(searchKeyword:String)
    {
        
        let latt =  12.9718915
        let long = 77.6411545
        let searchStr = searchKeyword.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!

        let params = "?latitude=\(latt)&longitude=\(long)&search_keyword=\(searchStr)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kSearchApi, params:params, result:{(resultObject) -> Void in
            
            
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
        })
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bro4u_DataManager.sharedInstance.searchResult.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath) as! b4u_SearchResultTblCell

        // Configure the cell...
        
        cell.configureData(bro4u_DataManager.sharedInstance.searchResult[indexPath.row])

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
        self.performSegueWithIdentifier("interMediateSegue1", sender:nil)

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60.0
    }
    
    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01;

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
        
        
        if segue.identifier == "interMediateSegue1"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let searchObject = bro4u_DataManager.sharedInstance.searchResult[indexPath.row]
                
                let categoryObj:b4u_Category = b4u_Category()
                
                categoryObj.catDesc = searchObject.catDesc
                categoryObj.catIcon = searchObject.catIcon
                categoryObj.catId = searchObject.catId
                categoryObj.catName = searchObject.catName
                categoryObj.fieldName = searchObject.fieldName
                categoryObj.mainCatId = searchObject.mainCatId
                categoryObj.optionId = searchObject.optionId
                categoryObj.optionName = searchObject.optionName
                categoryObj.sort_order = searchObject.sort_order
                
                let intermediateScreenCtrlObj = segue.destinationViewController as! b4u_IntermediateViewCtrl
                
                intermediateScreenCtrlObj.selectedCategoryObj = categoryObj
                
            }
        }

    }

    @IBAction func cancelBtnClicked(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
    }

    
    //MARK: UISearchResultsUpdating Delegate Method
    
    internal func updateSearchResultsForSearchController(searchController: UISearchController)
    {
       // bro4u_DataManager.sharedInstance.searchResult.removeAll()

        //let searchString = searchController.searchBar.text;
     

    }
    
    internal func searchBar(searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    {
        let searchString = searchController.searchBar.text!
        
        if searchString.length > 0
        {
            self.callSearchApi(searchString)
            
        }
        
    }

    
     internal func searchBarSearchButtonClicked(searchBar: UISearchBar)
     {
        
        let searchString = searchController.searchBar.text!
        
        if searchString.length > 0
        {
            self.callSearchApi(searchString)
            
        }
    }// called when keyboard search button pressed

  
  //Implimented to remove crash on click of list after cancel
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {

    bro4u_DataManager.sharedInstance.searchResult.removeAll()
    
    self.tableView.reloadData()

  }
}
