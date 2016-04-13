//
//  b4u-FilterViewController.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

enum inputType:String
{
    case radio = "radio"
    case checkBox = "checkbox"
    case textBoxGroup = "textboxgroup"
}

class b4u_FilterViewController: UIViewController ,UIPopoverPresentationControllerDelegate , calendarDelegate,timeSlotDelegate {

    @IBOutlet weak var expandableTblView: b4u_ExpandableTableView!

    var dateBtn:UIButton?
    var timeBtn:UIButton?
    
    var selectedCategoryObj:b4u_Category?
    
    var selectedImgSlide:b4u_SliderImage?

    
    var sectionNumberForRadioInputs = Set<Int>();

    
    var selectedIndexPath:Dictionary<String ,[NSIndexPath]> = Dictionary()
    var numberOfItems:Int = 0
    
    var hederViews:Dictionary<String ,b4u_ExpandableTblHeaderView> = Dictionary()

    var inputArray:[AnyObject]?{
        
        var array:[b4u_CatFilterAttributes] = Array()
        
        if let filteredAttributeArray =  bro4u_DataManager.sharedInstance.catlogFilterObj?.filterAttributes
        {
            array.appendContentsOf(filteredAttributeArray)
        }
        
        if let varientAttributeArray =  bro4u_DataManager.sharedInstance.catlogFilterObj?.variantAttributes
        {
            array.appendContentsOf(varientAttributeArray)
        }
        
        if let priceAttributeArray =  bro4u_DataManager.sharedInstance.catlogFilterObj?.pricingAttributes
        {
            array.appendContentsOf(priceAttributeArray)
        }
        return array
    }
    var sections:Int{
        
        let filterAttributes:Int = (bro4u_DataManager.sharedInstance.catlogFilterObj?.filterAttributes?.count)!
        let varientAttributes:Int = (bro4u_DataManager.sharedInstance.catlogFilterObj?.variantAttributes?.count)!
        
        let prisingAttributes:Int = (bro4u_DataManager.sharedInstance.catlogFilterObj?.pricingAttributes?.count)!
        
        return filterAttributes + varientAttributes + prisingAttributes
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addLoadingIndicator()

        bro4u_DataManager.sharedInstance.timeSlots = nil
        self.callFilterApi()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func callFilterApi()
    {
        
        if let aSelectedCatObj = selectedCategoryObj
        {
            b4u_Utility.sharedInstance.activityIndicator.startAnimating()

            let catId = aSelectedCatObj.catId!
            let optionId =  aSelectedCatObj.optionId!
            let filedName = aSelectedCatObj.fieldName!
            
            
            let params = "?cat_id=\(catId)&option_id=\(optionId)&field_name=\(filedName)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(filterApi, params:params, result:{(resultObject) -> Void in
                
                self.updateUI()
                
            })
        }else if let aSelectedSlideImg = self.selectedImgSlide
        {
            b4u_Utility.sharedInstance.activityIndicator.startAnimating()

            let catId = aSelectedSlideImg.catId!
            let optionId =  aSelectedSlideImg.optionId!
            
            
            let params = "?cat_id=\(catId)&option_id=\(optionId)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(filterApi, params:params, result:{(resultObject) -> Void in
                
                self.updateUI()
                
            })
        }
        
    }
    
    func callTimeSlotApi(selectedDateStr:String)
    {
            let params = "?date=\(selectedDateStr)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(kTimeSlotApi, params:params, result:{(resultObject) -> Void in
                
                
            
                
            })
    }
    func updateUI()
    {
        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

        self.expandableTblView.reloadData()
        
        let headerView = self.hederViews["0"]
        
        headerView?.toggle((headerView?.toggleButton)!)
    }
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (inputArray?.count)! + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == (inputArray?.count)!
        {
            return 1
        }
        else
        {
            if section <  inputArray?.count
            {
            let catFilterAttributes:b4u_CatFilterAttributes = self.inputArray![section] as! b4u_CatFilterAttributes
            let items = catFilterAttributes.catFilterAttributeOptions
            if (!items!.isEmpty) {
                if (self.expandableTblView.sectionOpen != NSNotFound && section == self.expandableTblView.sectionOpen) {
                    return items!.count
                }
            }
            }else
            {
                return 1
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
      
        if indexPath.section  < inputArray?.count
        {
            let catFilterAttributes:b4u_CatFilterAttributes = self.inputArray![indexPath.section] as! b4u_CatFilterAttributes
            let aItem = catFilterAttributes.catFilterAttributeOptions![indexPath.row]
            
            var cell:b4u_ExpandableTblViewCell!

            if catFilterAttributes.inputType == inputType.radio.rawValue
            {
                
                let radioBoxIdentifier = "radioCell"
                
                cell = tableView.dequeueReusableCellWithIdentifier(radioBoxIdentifier, forIndexPath: indexPath) as! b4u_ExpandableTblViewCell
                
                cell.iconImgView?.image = UIImage(named:"radioGray")
                
                self.sectionNumberForRadioInputs.insert(indexPath.section)
                if selectedIndexPath["\(indexPath.section)"]?.count > 0
                {
                    if (selectedIndexPath["\(indexPath.section)"]!.contains(indexPath)) {
                        cell.iconImgView?.image = UIImage(named:"radioBlue")
                    }
                }
                cell.lblTitle?.text =  aItem.optionName
                
                
            }else if catFilterAttributes.inputType == inputType.checkBox.rawValue
            {
                
                let checkBoxCellIdentifier = "checkBoxCell"
                
                cell = tableView.dequeueReusableCellWithIdentifier(checkBoxCellIdentifier, forIndexPath: indexPath) as! b4u_ExpandableTblViewCell
                
                cell.iconImgView?.image = UIImage(named:"squareGray")
                
                if selectedIndexPath["\(indexPath.section)"]?.count > 0
                {
                    if (selectedIndexPath["\(indexPath.section)"]!.contains(indexPath)) {
                        cell.iconImgView?.image = UIImage(named:"squareBlue")
                    }
                }
                cell.lblTitle?.text =  aItem.optionName
                
                
            }else if catFilterAttributes.inputType == inputType.textBoxGroup.rawValue
            {
                
                self.sectionNumberForRadioInputs.insert(indexPath.section)

                let checkBoxCellIdentifier = "textBoxGroupCell"
                
                cell = tableView.dequeueReusableCellWithIdentifier(checkBoxCellIdentifier, forIndexPath: indexPath) as! b4u_ExpandableTblViewCell
                cell.lblTitle?.text =  aItem.optionName
                
                
                cell.btnMinus.addTarget(self, action:"minusBtnClicked:", forControlEvents: .TouchUpInside)
                
                
                cell.btnPlus.addTarget(self, action:"plusBtnClicked:", forControlEvents:.TouchUpInside)
                
                cell.btnPlus.tag = indexPath.section
                cell.btnMinus.tag = indexPath.section
                
                cell.lblCount.text = "\(numberOfItems)"
                
            }
            return cell

        }
        else
        {
            var cell:b4u_DateAndTImeSelectionTblCell!

            let dateAndTimeCell = "dateAndTimeCelll"
            
            cell = tableView.dequeueReusableCellWithIdentifier(dateAndTimeCell, forIndexPath: indexPath) as! b4u_DateAndTImeSelectionTblCell
            
            cell.btnSelectDate.addTarget(self, action:"btnSelectDateClicked:", forControlEvents:UIControlEvents.TouchUpInside)
            
            cell.btnSelectTime.addTarget(self, action:"btnSelectTimeClicked:", forControlEvents:UIControlEvents.TouchUpInside)
            
            self.dateBtn = cell.btnSelectDate
            self.timeBtn = cell.btnSelectTime
            
            return cell

        }
      
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = b4u_ExpandableTblHeaderView(tableView: self.expandableTblView, section: section)
        headerView.backgroundColor = UIColor.whiteColor()

//        let label = UILabel(frame:CGRectMake(10, 0, CGRectGetWidth(headerView.frame)-30,CGRectGetHeight(headerView.frame)))
//
//        label.textAlignment = NSTextAlignment.Left
//        label.font = UIFont(name: "HelveticaNeue-neue", size: 14)
//        label.textColor = UIColor.blackColor()
//        
//        label.backgroundColor = UIColor.blueColor()
//        
//        headerView.addSubview(label)
//        
//        
//        
//        let selectedItems = UILabel(frame:CGRectMake(10, 20, CGRectGetWidth(headerView.frame)-30,CGRectGetHeight(headerView.frame)))
//        
//        selectedItems.textAlignment = NSTextAlignment.Left
//        selectedItems.font = UIFont(name: "HelveticaNeue-neue", size: 14)
//        selectedItems.textColor = UIColor.blackColor()
//        
//        selectedItems.text = "Selected Items"
//        selectedItems.backgroundColor = UIColor.greenColor()
//        
//        headerView.addSubview(selectedItems)

       headerView.lblSelectedItems!.text = ""

        
        if section < inputArray?.count
        {
      
        let catFilterAttributes:b4u_CatFilterAttributes = self.inputArray![section] as! b4u_CatFilterAttributes
            
        
        
        headerView.lblTitle!.text =  catFilterAttributes.attrName!
            
            
            
            if catFilterAttributes.inputType == inputType.radio.rawValue  ||  catFilterAttributes.inputType == inputType.textBoxGroup.rawValue
            {
                self.sectionNumberForRadioInputs.insert(section)
            }
       
        }else
        {
            headerView.lblTitle!.text =  "When do you need service?"
            
            headerView.toggleButton.enabled = false
        }
        
        self.hederViews["\(section)"] = headerView
        
        return headerView

    }
    

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        if indexPath.section < inputArray?.count
        {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! b4u_ExpandableTblViewCell
        
          let catFilterAttributes:b4u_CatFilterAttributes = self.inputArray![indexPath.section] as! b4u_CatFilterAttributes
        
    
        
        if catFilterAttributes.inputType == inputType.checkBox.rawValue
        {
            if  selectedIndexPath["\(indexPath.section)"]?.count > 0
            {
                //This is on click of same Cell
                if (selectedIndexPath["\(indexPath.section)"]!.contains(indexPath)) {
                    let i = selectedIndexPath["\(indexPath.section)"]?.indexOf(indexPath)
                    selectedIndexPath["\(indexPath.section)"]?.removeAtIndex(i!)
                    cell.iconImgView.image = UIImage(named: "squareGray")
                }else
                {
                    cell.iconImgView.image = UIImage(named: "squareBlue")
                    selectedIndexPath["\(indexPath.section)"]?.append(indexPath)
                    
                }
            }
                
            else
            {
                cell.iconImgView.image = UIImage(named: "squareBlue")
                
                selectedIndexPath["\(indexPath.section)"] = [indexPath]
            }
        }
        else if catFilterAttributes.inputType == inputType.radio.rawValue
        {
            //This is on click of same Cell
            
            if  selectedIndexPath["\(indexPath.section)"]?.count > 0
            {
                if (selectedIndexPath["\(indexPath.section)"]!.contains(indexPath)) {
                    let i = selectedIndexPath["\(indexPath.section)"]?.indexOf(indexPath)
                    selectedIndexPath["\(indexPath.section)"]?.removeAtIndex(i!)
                    cell.iconImgView.image = UIImage(named: "radioGray")
                }
                else
                {
                    let i = selectedIndexPath["\(indexPath.section)"]?.first
                    
                    let previosuCell = tableView.cellForRowAtIndexPath(i!) as! b4u_ExpandableTblViewCell

                    previosuCell.iconImgView.image = UIImage(named: "radioGray")
                    
                    cell.iconImgView.image = UIImage(named: "radioBlue")
                    selectedIndexPath["\(indexPath.section)"] = [indexPath]
                }
            }else
            {
                cell.iconImgView.image = UIImage(named: "radioBlue")
                selectedIndexPath["\(indexPath.section)"] = [indexPath]
            }
        }
            
            self.updateHeaderForSection(indexPath.section)
        }
        else
        {
            
        }
    
    }
    
    
    func updateHeaderForSection(section:Int)
    {
        var indexPaths = self.selectedIndexPath["\(section)"]
        
       indexPaths =  indexPaths!.sort { $0.row < $1.row }

        let catFilterAttributes:b4u_CatFilterAttributes = self.inputArray![section] as! b4u_CatFilterAttributes

        var selectedItems = ""
        for (_,indexPath) in (indexPaths?.enumerate())!
        {
            let attributeOptions = catFilterAttributes.catFilterAttributeOptions![indexPath.row]
            
            if selectedItems == ""
            {
              selectedItems = selectedItems + attributeOptions.optionName!
            }else
            {
                selectedItems = selectedItems +  " , " + attributeOptions.optionName!

            }
        }
        
        
        let headerView = self.hederViews["\(section)"]
        headerView!.lblSelectedItems?.text = selectedItems
        
        if selectedItems.length > 0
        {
            let frame:CGRect = CGRectMake(10, 0, CGRectGetWidth((headerView!.lblTitle?.frame)!), CGRectGetHeight((headerView!.frame))/2 - 5)
            
            headerView!.lblTitle?.frame = frame
            
            headerView?.lblSelectedItems?.frame = CGRectMake(10, CGRectGetHeight((headerView!.frame))/2, CGRectGetWidth((headerView!.lblTitle?.frame)!), CGRectGetHeight((headerView!.frame))/2 )
        }else
        {
            let frame:CGRect = CGRectMake(10, 0, CGRectGetWidth((headerView!.lblTitle?.frame)!), CGRectGetHeight((headerView!.frame)))
            
            headerView!.lblTitle?.frame = frame
        }
        print(selectedItems)
    }
    
    func btnSelectDateClicked(sender:AnyObject)
    {
    
        let btn = sender as! UIButton
        
        self.dateBtn = btn
        let storyboard : UIStoryboard = self.storyboard!
        
        let calendarController:b4u_CalendarViewCtrl = storyboard.instantiateViewControllerWithIdentifier("b4uCalendarViewCtrl") as! b4u_CalendarViewCtrl
        
        calendarController.modalPresentationStyle = .Popover
        calendarController.preferredContentSize = CGSizeMake(300, 400)
        calendarController.delegate = self
        
        
        if  bro4u_DataManager.sharedInstance.catlogFilterObj?.todaysTimeSlot?.count > 0
        {
            calendarController.selectedDate = NSDate()
        }
        else{
            calendarController.selectedDate = NSDate().dateByAddingTimeInterval(60*60*24*1)
        }
        let popoverMenuViewController = calendarController.popoverPresentationController
         popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = sender as? UIView
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(btn.frame),
            y: CGRectGetMidY(btn.frame),
            width: 1,
            height: 1)
        presentViewController(
            calendarController,
            animated: true,
            completion: nil)
        
        
      //  UIPopoverArrowDirection(rawValue: 0)


    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    
    func showQuicBookingView()
    {
        let storyboard : UIStoryboard = self.storyboard!
        
        let quickBookViewCtrl:b4u_QuickBookOrderCtrl = storyboard.instantiateViewControllerWithIdentifier("quickBookViewCtrl") as! b4u_QuickBookOrderCtrl
        
        quickBookViewCtrl.modalPresentationStyle = .Popover
        quickBookViewCtrl.preferredContentSize = CGSizeMake(300, 400)
       // quickBookViewCtrl.delegate = self
        
        let popoverMenuViewController = quickBookViewCtrl.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.frame),
            y: CGRectGetMidY(self.view.frame),
            width: 1,
            height: 1)
        presentViewController(
           quickBookViewCtrl,
            animated: true,
            completion: nil)

    }
  
    func minusBtnClicked(sender:AnyObject)
    {
        let btn = sender as! UIButton

        if numberOfItems > 0
        {
            numberOfItems -= 1
            
            self.expandableTblView.reloadData()
        }
        if numberOfItems == 0
        {
            self.selectedIndexPath.removeValueForKey("\(btn.tag)")
        }
    }
    
    func plusBtnClicked(sender:AnyObject)
    {
        let btn = sender as! UIButton
        numberOfItems += 1
        
        self.selectedIndexPath["\(btn.tag)"] = [NSIndexPath(forRow:0, inSection:btn.tag)]
        
        
//        if  selectedIndexPath["\(btn.tag)"]?.count > 0
//        {
//       
//        }
//            
//        else
//        {
//            cell.iconImgView.image = UIImage(named: "squareBlue")
//            
//            selectedIndexPath["\(indexPath.section)"] = [indexPath]
//        }

        
        
        
        self.expandableTblView.reloadData()
    }
    
    func btnSelectTimeClicked(sender:AnyObject)
    {
        if  bro4u_DataManager.sharedInstance.timeSlots?.timeSlots?.count > 0
        {
            let btn = sender as! UIButton
            
            
            self.timeBtn = btn
            let storyboard : UIStoryboard = self.storyboard!
            
            //        UIStoryboard(name:"Main",bundle: nil)
            
            let timeSlotController:b4u_TimeSlotViewCtrl = storyboard.instantiateViewControllerWithIdentifier("b4uTimeSlotCtrl") as! b4u_TimeSlotViewCtrl
            
            timeSlotController.modalPresentationStyle = .Popover
            timeSlotController.preferredContentSize = CGSizeMake(150, 300)
            
            timeSlotController.delegate = self
            //  timeSlotController.delegate = self
            
            let popoverMenuViewController = timeSlotController.popoverPresentationController
            popoverMenuViewController?.permittedArrowDirections = .Up
            popoverMenuViewController?.delegate = self
            popoverMenuViewController?.sourceView = btn
            popoverMenuViewController?.sourceRect = CGRect(
                x: CGRectGetMidX(btn.bounds),
                y: CGRectGetMidY(btn.frame),
                width: 1,
                height: 1)
            presentViewController(
                timeSlotController,
                animated: true,
                completion: nil)
            
        }
    }
    @IBAction func clearBtnClicked(sender: AnyObject) {
        
        if let tiemBtn = self.timeBtn
        {
            tiemBtn.setTitle("Select Time", forState:UIControlState.Normal)
        }
        
        if let dateBtn = self.dateBtn
        {
            dateBtn.setTitle("Select Date", forState:UIControlState.Normal)
            
        }
        
        self.selectedIndexPath.removeAll()
        
        bro4u_DataManager.sharedInstance.selectedDate = nil
        bro4u_DataManager.sharedInstance.selectedTimeSlot = nil
        
        self.expandableTblView.reloadData()
    }
    
    
    func callServicePatnerApi()
    {
        
        guard let selectedDate = bro4u_DataManager.sharedInstance.selectedDate , let selectedTimeSlot = bro4u_DataManager.sharedInstance.selectedTimeSlot else
        {
            print("Select Date And Time")
            
            self.view.makeToast(message:"Please select your preferred time.", duration:1.0 , position: HRToastPositionDefault)

            return
        }
        
        

        var catId:String?
        if let aSelectedCatObj = selectedCategoryObj
        {
            catId = aSelectedCatObj.catId
        }else if let aSlidingImgObj = self.selectedImgSlide
        {
            catId = aSlidingImgObj.catId

        }
        
        self.servicePatnerAPIRequest(catId!, selectedDate:selectedDate, selectedTimeSlot: selectedTimeSlot)
    }
    
    
    func servicePatnerAPIRequest(catId:String ,selectedDate:NSDate ,selectedTimeSlot:String )
    {
        let catId = catId
        let latitude =  "12.9718915"
        let longitude = "77.6411545"
        
        var params = "?cat_id=\(catId)"
        
      
        
        
        print(selectedIndexPath)
        
        
        let keys = selectedIndexPath.keys
        
        for (_ , key) in keys.enumerate()
        {
            print(key)
            
            
            let catFilterAttributes:b4u_CatFilterAttributes =   self.inputArray![Int(key)!] as! b4u_CatFilterAttributes
            
            if catFilterAttributes.inputType == inputType.checkBox.rawValue
            {
                for (_ , indexPath) in (selectedIndexPath[key]?.enumerate())!
                {
                    let attributeOption:b4u_CatFilterAttributeOptions =  catFilterAttributes.catFilterAttributeOptions![indexPath.row]
                    
                    params = params + "&\(catFilterAttributes.fieldName!)[]=\(attributeOption.optionId!)"
                    
                    print(attributeOption)
                }
            }
            
            if catFilterAttributes.inputType == inputType.radio.rawValue
            {
                for (_ , indexPath) in (selectedIndexPath[key]?.enumerate())!
                {
                    let attributeOption:b4u_CatFilterAttributeOptions =  catFilterAttributes.catFilterAttributeOptions![indexPath.row]
                    
                    params = params + "&\(catFilterAttributes.fieldName!)=\(attributeOption.optionId!)"
                    
                    
                }
            }
            if catFilterAttributes.inputType == inputType.textBoxGroup.rawValue
            {
                for (_ , indexPath) in (selectedIndexPath[key]?.enumerate())!
                {
                    
                    let attributeOption:b4u_CatFilterAttributeOptions =  catFilterAttributes.catFilterAttributeOptions![indexPath.row]
                    
                    params = params + "&\(catFilterAttributes.fieldName!)_\(numberOfItems)=\(attributeOption.optionId!)"
                    
                    
                }
            }
            
        }
      
      
      bro4u_DataManager.sharedInstance.userSelectedFilterParams = params
      
      let dateStr = NSDate.dateFormat().stringFromDate(selectedDate)
      
      params = params + "&service_date=\(dateStr)"
      
      params = params + "&service_time=\(selectedTimeSlot)"
      
      params = params + "&latitude=\(latitude)&longitude=\(longitude)"
      
      
        bro4u_DataManager.sharedInstance.suggestedPatnersResult = nil
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        b4u_WebApiCallManager.sharedInstance.getApiCall(kShowServicePatnerApi, params:params, result:{(resultObject) -> Void in
          
         self.performSelectorOnMainThread("moveToSuggestedPatner", withObject:nil, waitUntilDone:true)
            
        })
    }
    
    func moveToSuggestedPatner()
    {
        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

        if bro4u_DataManager.sharedInstance.suggestedPatnersResult?.suggestedPatners?.count >= 0
        {
            self.performSegueWithIdentifier("servicePatnerSegue", sender:nil)
            
        }else
        {
            //TODO
            
            self.showQuicBookingView()
        }
    }
    
    @IBAction func showServicePatnerBtnClicked(sender: AnyObject)
    {
        var selectedSectons = Set<Int>();

        for (_ , section) in self.selectedIndexPath.keys.enumerate()
        {
            selectedSectons.insert(Int(section)!)
        }
        
        if  self.sectionNumberForRadioInputs.isSubsetOf(selectedSectons)
        {
            self.callServicePatnerApi()
        }else
        {
            // TODO 
            
            print("ALL mandatory radio box are not selected")
            
            self.view.makeToast(message:"Please select all the filters", duration:1.0 , position: HRToastPositionDefault)

        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "servicePatnerSegue"
        {
            let servicePatnerCtrl = segue.destinationViewController as! b4u_ServicePatnerController
            servicePatnerCtrl.selectedCategoryObj  = self.selectedCategoryObj
        }
    }
  
    func didSelectDate(date:NSDate)
    {
        
        let dateFormat = NSDate.dateFormat() as NSDateFormatter
        
        let currentDate =  dateFormat.stringFromDate(date)
        
        self.dateBtn!.setTitle(currentDate, forState:UIControlState.Normal)
        
        self.callTimeSlotApi(currentDate)
        
        if let tiemBtn = self.timeBtn
        {
            tiemBtn.setTitle("Select Time", forState:UIControlState.Normal)
        }
    }

    func didSelectTimeSlot(tiemSlot:String)
    {
        self.timeBtn!.setTitle(tiemSlot, forState:UIControlState.Normal)

    }
    
    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
    

    
    
}
