//
//  b4u-LocationViewCtrl.swift
//  bro4u
//
//  Created by Mac on 06/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


protocol locationDelegate
{
    func userSelectedLocation(locationStr:String)
}
class b4u_LocationViewCtrl: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate ,CLLocationManagerDelegate {

    @IBOutlet weak var viewCurronLocation: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    
    
    var locationManager:CLLocationManager?
    
    var delegate:locationDelegate?
    
    var map:MKMapView?
    
//    @property (nonatomic, strong) CLLocationManager *locationManager;
//    @property (nonatomic, strong) CLGeocoder *geocoder;
//    @property (nonatomic, strong) MKPlacemark *placemark;
//    
   // var searchQuery : HNKGooglePlacesAutocompleteQuery?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
   //  self.searchQuery = HNKGooglePlacesAutocompleteQuery.sharedQuery
        
    
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()
       // locationManager!.startUpdatingLocation()
        
//        map = MKMapView()
//        map?.delegate = self
//        
//        self.view.addSubview(map!)
//        if CLLocationManager.authorizationStatus() == .NotDetermined {
//            locationManager!.requestWhenInUseAuthorization()
//        }
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager!.requestAlwaysAuthorization()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Location Manage Delegates

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        bro4u_DataManager.sharedInstance.currenLocation = manager.location

        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) ->Void in
            

            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                bro4u_DataManager.sharedInstance.currentLocality = nil
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                
                bro4u_DataManager.sharedInstance.currentLocality = pm

            } else {
                print("Problem with the data received from geocoder")
                bro4u_DataManager.sharedInstance.currentLocality = nil
            }
        })
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
        
        bro4u_DataManager.sharedInstance.currenLocation = nil
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
            //stop updating location to save battery life
            locationManager!.stopUpdatingLocation()
            print(placemark.locality! )
            print(placemark.postalCode! )
            print(placemark.administrativeArea! )
            print(placemark.country! )
    }
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            

            manager.startUpdatingLocation()
            // ...
        }
    }
    
   
    
    // MARK: TableView DataSource/Delegates
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return bro4u_DataManager.sharedInstance.locationSearchPredictions.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell")
        
        let locationPredictionModel:b4u_LocationSearchModel = bro4u_DataManager.sharedInstance.locationSearchPredictions[indexPath.row]
         cell?.textLabel?.text = locationPredictionModel.lDescription!
        return cell!
    }
    
    internal  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let locationPredictionModel:b4u_LocationSearchModel = bro4u_DataManager.sharedInstance.locationSearchPredictions[indexPath.row]

        bro4u_DataManager.sharedInstance.userSelectedLocatinStr = locationPredictionModel.lDescription
        delegate!.userSelectedLocation(locationPredictionModel.lDescription!)
        
        self.dismissViewControllerAnimated(true, completion:nil)
 
    }
    
    
    // MARK: SearchBar Delegate

    internal  func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool // return NO to not become first responder
    {
       // searchBar.setShowsCancelButton(true, animated:true)
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
    
    internal  func searchBarSearchButtonClicked(searchBar: UISearchBar) // called when keyboard search button pressed
    {
        
        if let  currentLocaiton = bro4u_DataManager.sharedInstance.currenLocation
        {
            // input=New&location=12.96,77.563123&
            
            
            let input = searchBar.text!
            let latt =  currentLocaiton.coordinate.latitude
            let long = currentLocaiton.coordinate.longitude
            
            let params = "&input=\(input)&location=\(latt),\(long)"
            
            b4u_WebApiCallManager.sharedInstance.getApiCall(kLocationSearchUrl, params:params, result:{(resultObject) -> Void in
                
                self.tableView.reloadData()
                
            })
        }

        searchBar.resignFirstResponder()
    }
    
    //MARK: Button Actions
    @IBAction func backBtnClicked(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
}
