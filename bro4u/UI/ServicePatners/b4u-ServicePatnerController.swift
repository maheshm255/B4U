//
//  b4u-ServicePatnerController.swift
//  bro4u
//
//  Created by Tools Team India on 25/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ServicePatnerController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate ,quantityDelegate,vendorSortDelegate{
    @IBOutlet weak var btnSort: UIBarButtonItem!

    @IBOutlet weak var btnHome: UIBarButtonItem!
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var viewLoadMore: UIView!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var tableViewServicePatner: UITableView!
    var selectedCategoryObj:b4u_Category?

    var selectedImgSlide:b4u_SliderImage?

    var allPatners:[b4u_SugestedPartner] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       // self.callServicePatnerApi()
        
        self.edgesForExtendedLayout = UIRectEdge.None
      self.addLoadingIndicator()

        self.getAllServicePatners()
        self.checkLoadMoreCondition()

    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Removing Order ID from User Default
        b4u_Utility.sharedInstance.setUserDefault(nil, KeyToSave:"order_id")

        
        bro4u_DataManager.sharedInstance.selectedQualtity = nil
        bro4u_DataManager.sharedInstance.selectedSuggestedPatner = nil
        
        self.userCurrentLocaion()
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getAllServicePatners()
    {
        if let patnersResult = bro4u_DataManager.sharedInstance.suggestedPatnersResult
        {
            self.allPatners.removeAll()
            self.allPatners = patnersResult.suggestedPatners! + patnersResult.otherPatners!

            
        }
    }
    func checkLoadMoreCondition()
    {
        if let patnersResult = bro4u_DataManager.sharedInstance.suggestedPatnersResult
        {
            if patnersResult.pageLoad == "yes"
            {
//                self.btnLoadMore.setTitle("See \(patnersResult.nextPageSize!) more patners"
//, forState:UIControlState.Normal)
            }else
            {
                self.viewLoadMore.hidden = true;
            }
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "servicePartnerMapViewCtrl"
        {
           // let ctrl = segue.destinationViewController as! b4u_ServicePatnerMapViewCtrl
            
        }else if segue.identifier == "paymentCtrlSegue"
        {
            
        }
    }
    
    
    //cat_id=2&latitude=12.9718915&longitude=77.6411545

    
    func callServicePatnerApi()
    {

        b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        if let aSelectedCatObj = selectedCategoryObj , patnersResult = bro4u_DataManager.sharedInstance.suggestedPatnersResult
        {
      
            self.serviceAPIRequest(aSelectedCatObj.catId!, nextPage:patnersResult.nextPage!)
        }else if let aSelectedImgObj = self.selectedImgSlide , patnersResult = bro4u_DataManager.sharedInstance.suggestedPatnersResult
        {
            self.serviceAPIRequest(aSelectedImgObj.catId!, nextPage:patnersResult.nextPage!)
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()


        }
    }
    
    
    func serviceAPIRequest(catId:String , nextPage:NSNumber)
    {
        
       // let catId = catId

        
        
        var latitude =  "12.9718915"
        var longitude = "77.6411545"
        
        if let currentLocaiotn = bro4u_DataManager.sharedInstance.currenLocation
        {
            latitude = "\(currentLocaiotn.coordinate.latitude)"
            
            longitude = "\(currentLocaiotn.coordinate.longitude)"

        }
        
        
        let nextPage = nextPage
        
//        let params = "/\(nextPage)?cat_id=\(catId)&latitude=\(latitude)&longitude=\(longitude)"
        
        let params = "/\(nextPage)\(bro4u_DataManager.sharedInstance.userSelectedFilterParams!)&latitude=\(latitude)&longitude=\(longitude)&service_date=\(bro4u_DataManager.sharedInstance.selectedDate!)&service_time=\(bro4u_DataManager.sharedInstance.selectedTimeSlot!)"

        
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kShowServicePatnerApi, params:params, result:{(resultObject) -> Void in
            
            self.getAllServicePatners()
            self.checkLoadMoreCondition()
            self.tableViewServicePatner.reloadData()
        
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

        })
    }
  
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("servicePatnerCell") as! b4u_ServicePartnerTblViewCell
        
        
        let aPatner:b4u_SugestedPartner = self.allPatners[indexPath.section]
        
        
        cell.imgViewProfilePic.downloadedFrom(link:aPatner.profilePic!, contentMode:UIViewContentMode.ScaleToFill)

        cell.lblVendorName.text = aPatner.vendorName
      
        cell.lblVendorReiviews.text = "\(aPatner.reviewCount!) Reviews"
        cell.lblVendorDistance.text =  String(format: "%.2@ Kms away",aPatner.distance!)
         //   "\(aPatner.distance!) Kms away"
        //For Giving Border to button
        cell.btnViewProfile.layer.cornerRadius = 2
        cell.btnViewProfile.layer.borderColor = UIColor.grayColor().CGColor
        cell.btnViewProfile.layer.borderWidth = 1

        //For Giving Border to button
        cell.btnViewDetails.layer.cornerRadius = 2
        cell.btnViewDetails.layer.borderColor = UIColor.grayColor().CGColor
        cell.btnViewDetails.layer.borderWidth = 1

        
        self.navigationItem.title = aPatner.catName!

        if aPatner.catId! == "3" ||  aPatner.catId! == "4"
        {
            self.navigationItem.rightBarButtonItems = [btnSort ,btnHome]
        }else
        {
            self.navigationItem.rightBarButtonItems = [btnHome]

        }
        
        if let offerPreice = aPatner.offerPrice , let price = aPatner.price
        {
            if Double(offerPreice) > 0  && Double(price) > 0
            {
                cell.lblDiscount.text = "Rs." + aPatner.offerPrice!+"*"
                
                //            let shadow : NSShadow = NSShadow()
                //            shadow.shadowOffset = CGSizeMake(-2.0, -2.0)
                
                let attributes = [
                    NSUnderlineStyleAttributeName : 1,
                    NSForegroundColorAttributeName : UIColor(red:178.0/255, green: 178.0/255, blue: 178.0/255, alpha: 1.0),
                    NSStrokeWidthAttributeName : 3.0,
                    //NSShadowAttributeName : shadow,
                    NSStrikethroughStyleAttributeName:1
                ]
                
                let price = NSAttributedString(string:"Rs. \(aPatner.price!)", attributes: attributes) //1
                
                
                cell.lblActualPrice.attributedText = price
                
                cell.leadingConstraingDiscounLbl.constant = 10
                
            }else
            {
                cell.lblActualPrice.text = ""
                
                cell.leadingConstraingDiscounLbl.constant = 0
                cell.lblDiscount.text = "Rs." + aPatner.offerPrice!+"*"
            }
            
        }else
        {
            cell.lblActualPrice.text = ""
            
            cell.leadingConstraingDiscounLbl.constant = 0
            
            if let offerPrice = aPatner.offerPrice
            {
                cell.lblDiscount.text = "Rs." + offerPrice + "*"

            }
        }
     
//        cell.contentView.layer.borderColor = UIColor.grayColor().CGColor
//        //cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.shadowColor = UIColor.blackColor().CGColor
//        cell.contentView.layer.shadowOpacity = 0.1
        
        
        if aPatner.premiumPartner != "yes"
        {
            cell.btnKing.hidden = false
        }else
        {
            cell.btnKing.hidden = true
 
        }
        
        cell.btnLike.addTarget(self, action:"btnShare:", forControlEvents:UIControlEvents.TouchUpInside)
        cell.btnLike.tag = indexPath.section

        cell.btnViewDetails.addTarget(self, action:"btnBookNowClicked:", forControlEvents:UIControlEvents.TouchUpInside)
        cell.btnViewDetails.tag = indexPath.section
        
        cell.btnViewProfile.addTarget(self, action:"btnViewProfileClicked:", forControlEvents:UIControlEvents.TouchUpInside)

        cell.btnViewProfile.tag = indexPath.section

        cell.btnViewProfile.layer.cornerRadius = 2.0
        cell.btnViewProfile.layer.borderColor = UIColor.lightGrayColor().CGColor

        cell.btnViewProfile.layer.borderWidth = 1.0
        
        cell.lblVendorFeedBack.text = "\(aPatner.averageRatingPercent!)% Positive"
        
        if let deliveryCharge = aPatner.deliveryCharge where Double(deliveryCharge) > 0
        {
            cell.lblCharges.text = "*Delivery Charge + \(deliveryCharge)"
            cell.topConstraintChargesLbl.constant = 10
            
        }else if let chargesStr = aPatner.chargeTitle where chargesStr != ""
        {
            cell.lblCharges.text = "*" + chargesStr
            cell.topConstraintChargesLbl.constant = 10

        }else
        {
            cell.lblCharges.text = ""
            cell.topConstraintChargesLbl.constant = 0

        }
        return cell
    }
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        
//        if let suggestedPatners = bro4u_DataManager.sharedInstance.suggestedPatnersResult?.suggestedPatners
//        {
            return self.allPatners.count
//        }
        return 0

    }// Default is 1 if

    func btnViewProfileClicked(sender: AnyObject)
    {
        
        let btn:UIButton = sender as! UIButton
        
        bro4u_DataManager.sharedInstance.selectedSuggestedPatner = self.allPatners[btn.tag]
        
        self.performSegueWithIdentifier("viewProfileSegue", sender:sender)
    }
    
    
    
    func btnBookNowClicked(sender: AnyObject)
    {
        
        let btn:UIButton = sender as! UIButton
        
        bro4u_DataManager.sharedInstance.selectedSuggestedPatner = self.allPatners[btn.tag]
        
        
        if bro4u_DataManager.sharedInstance.selectedQualtity == nil &&  bro4u_DataManager.sharedInstance.selectedSuggestedPatner?.quantityActive == "yes"
        {
          self.showQuantityRequired()
        }else
        {
            self.performSegueWithIdentifier("paymentCtrlSegue", sender:sender)
        }
    }
    
    
    func btnShare(sender: AnyObject)
    {
        let textToShare = "Look at this awesome website for aspiring iOS Developers!"
        let myWebsite = NSURL(string: "http://www.codingexplorer.com/")
        let itemArr : NSArray = [textToShare,myWebsite!]
        let shareCntrlr = UIActivityViewController(activityItems: itemArr as [AnyObject], applicationActivities: nil)
        presentViewController(shareCntrlr, animated: true, completion: nil)
    }
    @IBAction func btnLoadMoreClicked(sender: AnyObject)
    {
        self.callServicePatnerApi()
    }
    
    
    
    func showQuantityRequired()
    {
        let storyboard : UIStoryboard = self.storyboard!
        
        let quantityCtrl:b4u_quantityViewController = storyboard.instantiateViewControllerWithIdentifier("quantityRequiredCtrl") as! b4u_quantityViewController
        
        quantityCtrl.modalPresentationStyle = .Popover
        quantityCtrl.preferredContentSize = CGSizeMake(300, 400)
        quantityCtrl.delegate = self
        
        let popoverMenuViewController = quantityCtrl.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.frame),
            y: CGRectGetMidY(self.view.bounds),
            width: 1,
            height: 1)
        presentViewController(
            quantityCtrl,
            animated: true,
            completion: nil)
        
    }
    
    func selectedQuanitty(quantity:String?)
    {
        bro4u_DataManager.sharedInstance.selectedQualtity = quantity
    }
    
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
        {
         return 200.0
    }
    
      func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 1.0
            
        }
        return 10.0
    }
//      func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
//    {
//        if section == 0
//        {
//            return 0.001
//
//        }
//        return 4.0
//
//    }
  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    @IBAction func filterButtonAction(sender: AnyObject)
    {
        self.showSortOptions()
    }
    
    func showSortOptions()
    {
        let storyboard : UIStoryboard = self.storyboard!
        
        let sortController:b4u_VendorSortTblViewController = storyboard.instantiateViewControllerWithIdentifier("vendorSortViewController") as! b4u_VendorSortTblViewController
        
        sortController.modalPresentationStyle = .Popover
        sortController.preferredContentSize = CGSizeMake(300, 230)
         sortController.delegate = self
        
        let popoverMenuViewController = sortController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.frame),
            y: CGRectGetMidY(self.view.bounds),
            width: 1,
            height: 1)
        presentViewController(
            sortController,
            animated: true,
            completion: nil)
        
    }
    
    func sortUsinOption(aSortOption:sortOpbion)
    {
        print(aSortOption)
        
        switch aSortOption
        {
        case sortOpbion.kSortPriceHighToLow :
            print("hight to low")
            
            self.allPatners.sortInPlace({ Double($0.sortingPrice!) > Double($1.sortingPrice! )})
            self.tableViewServicePatner.reloadData()
            
        case sortOpbion.kSortPriceLowToHigh :
            print("low to high")
            
            self.allPatners.sortInPlace({ Double($0.sortingPrice!) < Double($1.sortingPrice! )})
            self.tableViewServicePatner.reloadData()
            
        case sortOpbion.kSortNearToFar :
            print("Near to far")
            
            self.allPatners.sortInPlace({ Double($0.distance!) < Double($1.distance! )})

            self.tableViewServicePatner.reloadData()
            
        case sortOpbion.kSortPopularity :
         
            self.allPatners.sortInPlace({ Int($0.reviewCount!) > Int($1.reviewCount! )})
            
            self.tableViewServicePatner.reloadData()
            
            print("by popularity")

            
        default :
            print("Default sorting")
            
        }
        
        
        self.tableViewServicePatner.scrollToRowAtIndexPath( NSIndexPath(forRow:0, inSection: 0)
, atScrollPosition:.Top, animated:true)
    }
    
    
    
    func userCurrentLocaion()
    {
        if let currentLocality = bro4u_DataManager.sharedInstance.currentLocality
        {
            
            if let loclity = currentLocality.locality
            {
                if let  subLocality = currentLocality.subLocality
                {
                    self.lblCurrentLocation.text = "\(subLocality),\(loclity)"
                }else
                {
                    self.lblCurrentLocation.text = "\(loclity)"

                }
            }
            
    
            
        }else
        {
            self.lblCurrentLocation.text = "Current Location"
            
        }
    }
    @IBAction func homeBtnPressed(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)

    }
}
