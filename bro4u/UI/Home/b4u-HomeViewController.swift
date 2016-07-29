//
//  b4u-HomeViewController.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//
import UIKit
import CoreLocation

class b4u_HomeViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate ,locationDelegate ,CLLocationManagerDelegate {

    @IBOutlet weak var viewLocation: UIView!
    var locationManager:CLLocationManager?

    @IBOutlet weak var btnCurrentLocation: UIButton!
    @IBOutlet weak var BtnRightMenu: UIBarButtonItem!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var tableViewCategory: UITableView!
    
    var selectedImgSliderObj:b4u_SliderImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableViewCategory.separatorInset = UIEdgeInsetsZero
        self.tableViewCategory.layoutMargins = UIEdgeInsetsZero
        
        self.viewLocation.layer.cornerRadius = 1.0
        self.tableViewCategory.layer.cornerRadius = 1.0
        
        self.getLocatoin()
        
        self.addLoadingIndicator()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"pushCategoryScreen:", name:kPushServicesScreen, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pushScreenForRightMenu:", name: kRightMenuNotification, object: nil)

       
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
            BtnRightMenu.target = self.revealViewController()
            BtnRightMenu.action = "rightRevealToggle:"
            
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            

        }
        
        self.revealViewController().rearViewRevealWidth = 108
        
        self.revealViewController().rightViewRevealWidth = 170
        
        //1. To delay for Network Test
        self.performSelector("getData", withObject: nil, afterDelay: 0.2)

//         self.getData()
    
        //self.callInterMediateApi()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //Turn off the automatic gesture to go back a view with a navigation controller
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        
        //Removing Order ID from User Default
        b4u_Utility.sharedInstance.setUserDefault(nil, KeyToSave:"order_id")
    }

    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func getLocatoin()
    {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager!.requestAlwaysAuthorization()
        }
    }
    
    //Network Reachable Test
    func getData()
    {
        //2. Checking for Network reachability

        if(AFNetworkReachabilityManager.sharedManager().reachable){
          
          b4u_Utility.sharedInstance.activityIndicator.startAnimating()
          let params = "?\(kAppendURLWithApiToken)"
          b4u_WebApiCallManager.sharedInstance.getApiCall(kHomeSCategory, params:params, result:{(resultObject) -> Void in
            
            print("Category Data Received")
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            self.tableViewCategory.backgroundColor = UIColor.whiteColor()
            print(resultObject)
            self.createImagSlideShowUI()
            
            self.tableViewCategory.reloadData()
            
          })
          //5.Remove observer if any remain
          NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)

        }else{
            //3. First Remove any existing Observer 
            //Add Observer for No network Connection

            NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(b4u_HomeViewController.getData), name: "NoNetworkConnectionNotification", object: nil)
          
            //4.Adding View for Retry
            let noNetworkView = NoNetworkConnectionView(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.height))
            self.view.addSubview(noNetworkView)

            return
        }
        
      
    }
      
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        

        
        if segue.identifier == "categoryScreenSegue"
        {
            if let indexPath = self.tableViewCategory.indexPathForSelectedRow
            {
                let categoryViewCtrlObj = segue.destinationViewController as! b4u_CategoryViewCtrl
                
                categoryViewCtrlObj.selectedMainCategory = bro4u_DataManager.sharedInstance.mainCategories[indexPath.row]
                
                categoryViewCtrlObj.selectedIndex = indexPath.row
            }
            
        }
        else if segue.identifier == "locationCtrlSegue"
        {
            
            bro4u_DataManager.sharedInstance.locationSearchPredictions.removeAll()
            let locatinCtrlObj = segue.destinationViewController as! b4u_LocationViewCtrl

            locatinCtrlObj.delegate = self
        }else if segue.identifier == "intermediateScreenSegue1"
        {
           
                let selectedImgSlideObj = sender as! b4u_SliderImage
                
              //  let navCtrl = segue.destinationViewController as! UINavigationController
                
                let intermediateScreenCtrlObj = segue.destinationViewController as! b4u_IntermediateViewCtrl
            
                intermediateScreenCtrlObj.selectedImgSlide = selectedImgSlideObj
                
        }
    }
    

    
    //MARK: TableView Delegate and DataSource
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bro4u_DataManager.sharedInstance.mainCategories.count
    }

    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! b4u_CategoryListTblViewCell
        
        cell.configureCellData(bro4u_DataManager.sharedInstance.mainCategories[indexPath.row])
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        return cell

    }
    
     internal func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1
    }
     internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 65.0
    }
    
    internal  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //Modified for Toggle on click of any Main Category
        if self.revealViewController().frontViewPosition == FrontViewPosition.Right
        {
            NSNotificationCenter.defaultCenter().postNotificationName(kPushServicesScreen, object:indexPath)

        }
        else if self.revealViewController().frontViewPosition == FrontViewPosition.LeftSide
        {
            NSNotificationCenter.defaultCenter().postNotificationName(kRightMenuNotification, object: indexPath)
        }


      self.performSegueWithIdentifier("categoryScreenSegue", sender: nil)

      
//        if let currentLocation = bro4u_DataManager.sharedInstance.currenLocation
//        {
//            
//            print(currentLocation.coordinate.latitude)
//            print(currentLocation.coordinate.longitude)
//
//            self.performSegueWithIdentifier("categoryScreenSegue", sender: nil)
//
//        }else
//        {
//            self.showAlertToGetEnbleCurrentLocaion()
//        }
    }


    func  showAlertToGetEnbleCurrentLocaion()
    {
        let alertControl = UIAlertController(title:"Location Service Disabled", message:"The location service is off please enable now", preferredStyle:.Alert)
        
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        //Create and add the Cancel action
        let setting: UIAlertAction = UIAlertAction(title: "Setting", style:.Default) { action -> Void in
            //Just dismiss the action sheet
            
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)

        }
        
        alertControl.addAction(setting)
        alertControl.addAction(cancelAction)
        
        self.presentViewController(alertControl, animated:true, completion: nil)
        
    }
    func createImagSlideShowUI()
    {
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        for (index ,sliderImageInfoObj)in bro4u_DataManager.sharedInstance.sliderImages.enumerate()
        {
            let sliderImg = UIImageView(frame: CGRectMake(scrollViewWidth*CGFloat(index), 0,scrollViewWidth, scrollViewHeight))
            
              sliderImg.userInteractionEnabled = true
              sliderImg.tag = index
            
            sliderImg.downloadedFrom(link:sliderImageInfoObj.imageName!, contentMode:UIViewContentMode.ScaleAspectFill)
            
            sliderImg.layer.cornerRadius = 1.0
            
            self.scrollView.addSubview(sliderImg)

            let slideImgTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:"imageSlideClicked:")
            
            slideImgTapGesture.numberOfTapsRequired = 1;
            
            sliderImg.addGestureRecognizer(slideImgTapGesture)
            
        }
        
        let totalImage = bro4u_DataManager.sharedInstance.sliderImages.count
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * CGFloat(totalImage), self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = totalImage
        
//        self.scrollView.delaysContentTouches = true
        self.scrollView.scrollEnabled = true
        
//        let leftSwipeGesture = UISwipeGestureRecognizer(target:self, action:"leftSwipe")
//        leftSwipeGesture.delaysTouchesBegan  = true
//        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.Left
//        self.scrollView.addGestureRecognizer(leftSwipeGesture)
//        leftSwipeGesture.cancelsTouchesInView = false
//        
//        let rightSwipeGesture = UISwipeGestureRecognizer(target:self, action:"rightSwipe")
//        rightSwipeGesture.delaysTouchesBegan  = true
//        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.Right
//        self.scrollView.addGestureRecognizer(rightSwipeGesture)
//        rightSwipeGesture.cancelsTouchesInView = false
    }
    
    func imageSlideClicked(gesttureObj:UITapGestureRecognizer)
    {
        print(gesttureObj.view?.tag)
        
        let sliderImgObj:b4u_SliderImage =  bro4u_DataManager.sharedInstance.sliderImages[(gesttureObj.view?.tag)!]
        
        self.performSegueWithIdentifier("intermediateScreenSegue1", sender: sliderImgObj)

    }
    
    func leftSwipe()
    {
        self.moveToNextPage()
    }
    
    func rightSwipe()
    {
        self.moveToPrevousPage()
        
    }
    func moveToNextPage (){
        
        // Move to next page
        let totalImage = bro4u_DataManager.sharedInstance.sliderImages.count

        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
        let maxWidth:CGFloat = pageWidth * CGFloat(totalImage)
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
            // Each time you move back to the first slide, you may want to hide the button, uncomment the animation below to do so
            //            UIView.animateWithDuration(0.5, animations: { () -> Void in
            //                self.startButton.alpha = 0.0
            //            })
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
    }
    
    
    func moveToPrevousPage(){
        
        
        // Move to next page
        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
      //  let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset - pageWidth
        
        if  contentOffset - pageWidth == 0{
            slideToX = 0
            // Each time you move back to the first slide, you may want to hide the button, uncomment the animation below to do so
            //            UIView.animateWithDuration(0.5, animations: { () -> Void in
            //                self.startButton.alpha = 0.0
            //            })
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
        
    }
   
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView){
        
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
    }
    
     internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) // called when scroll view grinds to a halt
     {
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
    }
    func userSelectedLocation(locationStr:String)
    {
      self.btnCurrentLocation.setTitle(locationStr, forState:.Normal)
    }
    @IBAction func locationBtnSelected(sender: AnyObject)
    {
        self.performSegueWithIdentifier("locationCtrlSegue", sender:nil)
    }
    
    func pushScreenForRightMenu(notification:NSNotification){
        if let index = notification.object as? NSIndexPath{
            //print("index \(index.row)")
            if index.row == 2 {
                self.performSegueWithIdentifier(kAboutUSVCID, sender:nil)
            }else if index.row == 3 {
                self.performSegueWithIdentifier(kWalletVCID, sender:nil)
            }else if index.row == 5 {
                self.performSegueWithIdentifier(kOfferZoneVCID, sender:nil)
            }
        }
    }
    
    func pushCategoryScreen(notification:NSNotification)
    {
        if let index = notification.object as? NSIndexPath{
            if index.row == 1 {
                //Modified for Home Screen Navigation after click on Sevices
                self.navigationController?.popToRootViewControllerAnimated(true)
//                self.performSegueWithIdentifier("categoryScreenSegue", sender:nil)
            }else if index.row == 2 {
                self.performSegueWithIdentifier("reOrderID", sender:nil)
            }else if index.row == 3 {
                self.performSegueWithIdentifier("myOrderID", sender:nil)
            }else if index.row == 4 {
                self.performSegueWithIdentifier("shareAndEarnID", sender:nil)
            }else if index.row == 5 {
                self.performSegueWithIdentifier("myAccountID", sender:nil)
            }
            
        }
    }
    
    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
    
    
    func userCurrentLocaion()
    {
        
//        if let lastSearchedLocation = NSUserDefaults.standardUserDefaults().objectForKey("customLocation")
//        {
//            self.btnCurrentLocation.setTitle(lastSearchedLocation as? String, forState:.Normal)
//            
//            bro4u_DataManager.sharedInstance.userSelectedLocatinStr = lastSearchedLocation as! String
//
//        }else{
//            if let currentLocality = bro4u_DataManager.sharedInstance.currentLocality
//            {
//                
//                if let loclity = currentLocality.locality
//                {
//                    if let  subLocality = currentLocality.subLocality
//                    {
//                        self.btnCurrentLocation.setTitle("\(subLocality),\(loclity)", forState:.Normal)
//                    }else
//                    {
//                        self.btnCurrentLocation.setTitle("\(loclity)", forState:.Normal)
//                        
//                    }
//                }
//            }else
//            {
//                self.btnCurrentLocation.setTitle("Current Location", forState:.Normal)
//            }
//        }
      
            if let currentLocality = bro4u_DataManager.sharedInstance.currentLocality
            {

                if let loclity = currentLocality.locality
                {
                    if let  subLocality = currentLocality.subLocality
                    {
                        self.btnCurrentLocation.setTitle("\(subLocality),\(loclity)", forState:.Normal)
                    }else
                    {
                        self.btnCurrentLocation.setTitle("\(loclity)", forState:.Normal)

                    }
                }
            }else
            {
                self.btnCurrentLocation.setTitle("Current Location", forState:.Normal)
            }

      
    }

  
    //MARK: - Location Delegates
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        self.locationManager?.startUpdatingLocation()

        bro4u_DataManager.sharedInstance.currenLocation = manager.location
        
        
        print("\(manager.location?.coordinate.latitude )  ....  \(manager.location?.coordinate.longitude )")
        CLGeocoder().reverseGeocodeLocation((manager.location)!, completionHandler: {(placemarks, error) ->Void in
          
            
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
            
            self.userCurrentLocaion()

        })
        
        self.locationManager?.stopUpdatingLocation()
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

}

extension b4u_HomeViewController{
    
    @IBAction func unwindToHomeView(segue: UIStoryboardSegue) {
        
    }
}
