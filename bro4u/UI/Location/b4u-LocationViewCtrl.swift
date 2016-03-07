//
//  b4u-LocationViewCtrl.swift
//  bro4u
//
//  Created by Mac on 06/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_LocationViewCtrl: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    
   // var searchQuery : HNKGooglePlacesAutocompleteQuery?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
     //   self.searchQuery = HNKGooglePlacesAutocompleteQuery.sharedQuery
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return 3
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell")
        
         cell?.textLabel?.text = "current location"
        return cell!
    }
    
    
    internal  func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool // return NO to not become first responder
    {
        searchBar.setShowsCancelButton(true, animated:true)
      return true
    }
    internal func searchBarTextDidBeginEditing(searchBar: UISearchBar) // called when text starts editing
    {
        
//        
//         self.searchQuery.fetchPlacesForSearchQuery(searchBar.text ,^(places, error)
//            {
//            
//            }
//        )
//        [self.searchQuery fetchPlacesForSearchQuery: searchText
////            completion:^(NSArray *places, NSError *error) {
//            if (error) {
//            NSLog(@"ERROR: %@", error);
//            [self handleSearchError:error];
//            } else {
//            self.searchResults = places;
//            [self.tableView reloadData];
//            }
//            }];
        
//        
//        fetchPlacesForSearchQuery:(NSString *)searchQuery
//        completion:(HNKGooglePlacesAutocompleteQueryCallback)completion;
    }
    
    internal  func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool // return NO to not resign first responder
    {
        return true
    }
     internal func searchBarTextDidEndEditing(searchBar: UISearchBar) // called when text ends editing
    {
        
    }
}
