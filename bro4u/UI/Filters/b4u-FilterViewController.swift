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

class b4u_FilterViewController: UIViewController ,UIPopoverPresentationControllerDelegate , calendarDelegate,timeSlotDelegate ,quickBookDelegate{
    
    @IBOutlet weak var expandableTblView: b4u_ExpandableTableView!
    
    var dateBtn:UIButton?
    var timeBtn:UIButton?
    
    var selectedCategoryObj:b4u_Category?
    
    var selectedImgSlide:b4u_SliderImage?
    
    var selectedAttributeOption:b4u_AttributeOptions?
    
    var sectionNumberForRadioInputs = Set<Int>();
    
    
    var selectedIndexPath:Dictionary<String ,[NSIndexPath]> = Dictionary()
    var textBoxGroupVaues:Dictionary<NSIndexPath ,String> = Dictionary()
    
    var numberOfItems:Int = 0
    
    var hederViews:Dictionary<String ,b4u_ExpandableTblHeaderView> = Dictionary()
    
    var selectionDict:Dictionary<String , String> = Dictionary()
    
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
        
        
        bro4u_DataManager.sharedInstance.catlogFilterObj = nil
        
        
        bro4u_DataManager.sharedInstance.timeSlots = nil
        self.callFilterApi()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.addLoadingIndicator()
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
            
            var optionId =  ""
            var filedName = ""
            
            if  let aSelectedAttributeOption = selectedAttributeOption
            {
                if let aOptionId = aSelectedAttributeOption.optionId
                {
                    optionId = aOptionId
                }
                
                if let aFieldName = aSelectedAttributeOption.fieldName
                {
                    filedName = aFieldName
                    
                }
            }else
            {
                if let aOptionId = aSelectedCatObj.optionId
                {
                    optionId = aOptionId
                }
                
                if let aFieldName = aSelectedCatObj.fieldName
                {
                    filedName = aFieldName
                    
                }
            }
            
            
            
            self.view.userInteractionEnabled = false
            //   self.view.alpha = 0.7
            
            
            let params = "?cat_id=\(catId)&option_id=\(optionId)&field_name=\(filedName)&\(kAppendURLWithApiToken)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(filterApi, params:params, result:{(resultObject) -> Void in
                
                
                self.view.userInteractionEnabled = true
                //  self.view.alpha = 1.0
                
                self.updateUI()
                
            })
        }else if let aSelectedSlideImg = self.selectedImgSlide
        {
            b4u_Utility.sharedInstance.activityIndicator.startAnimating()
            
            let catId = aSelectedSlideImg.catId!
            let optionId =  aSelectedSlideImg.optionId!
            
            self.view.userInteractionEnabled = false
            
            let params = "?cat_id=\(catId)&option_id=\(optionId)&\(kAppendURLWithApiToken)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(filterApi, params:params, result:{(resultObject) -> Void in
                
                self.view.userInteractionEnabled = true
                
                self.updateUI()
                
            })
        }
        
    }
    
    func callTimeSlotApi(selectedDateStr:String)
    {
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        self.view.userInteractionEnabled = false
        
        var catId:String?
        
        if let aSelectedCatObj = selectedCategoryObj
        {
            
            catId = aSelectedCatObj.catId!
        }
        else if bro4u_DataManager.sharedInstance.interMediateScreenDataObj != nil{
            
            let interScreenModel:b4u_IntermediateScreenDataModel = bro4u_DataManager.sharedInstance.interMediateScreenDataObj!
            
            catId = interScreenModel.catID
            
        }

        
        let params = "/\(catId!)?date=\(selectedDateStr)&\(kAppendURLWithApiToken)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kTimeSlotApi, params:params, result:{(resultObject) -> Void in
            
            self.view.userInteractionEnabled = true
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            
        })
    }
    func updateUI()
    {
        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
        
        if inputArray?.count > 0
        {
            self.expandableTblView.reloadData()
            
            let headerView = self.hederViews["0"]
            
            headerView?.toggle((headerView?.toggleButton)!)
       }
        
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
        
        let rowsAmount: Int =  tableView.numberOfRowsInSection(indexPath.section)

        if indexPath.section  < inputArray?.count
        {
            let catFilterAttributes:b4u_CatFilterAttributes = self.inputArray![indexPath.section] as! b4u_CatFilterAttributes
            let aItem = catFilterAttributes.catFilterAttributeOptions![indexPath.row]
            
            var cell:b4u_ExpandableTblViewCell!
            
            if catFilterAttributes.inputType == inputType.radio.rawValue
            {
                
                let radioBoxIdentifier = "radioCell"
                
                cell = tableView.dequeueReusableCellWithIdentifier(radioBoxIdentifier, forIndexPath: indexPath) as! b4u_ExpandableTblViewCell
                
                self.sectionNumberForRadioInputs.insert(indexPath.section)
              
                cell.iconImgView?.image = UIImage(named:"radioGray")

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
                
                
            }
            else if catFilterAttributes.inputType == inputType.textBoxGroup.rawValue
            {
                
                self.sectionNumberForRadioInputs.insert(indexPath.section)
                
                let checkBoxCellIdentifier = "textBoxGroupCell"
                
                cell = tableView.dequeueReusableCellWithIdentifier(checkBoxCellIdentifier, forIndexPath: indexPath) as! b4u_ExpandableTblViewCell
                cell.lblTitle?.text =  aItem.optionName
                
                
                cell.btnMinus.addTarget(self, action:"minusBtnClicked:", forControlEvents: .TouchUpInside)
                
                
                cell.btnPlus.addTarget(self, action:"plusBtnClicked:", forControlEvents:.TouchUpInside)
                
                cell.btnPlus.tag = indexPath.section
                cell.btnMinus.tag = indexPath.section
                
                cell.btnPlus.indexPath = indexPath
                cell.btnMinus.indexPath = indexPath
                
                if let value = self.textBoxGroupVaues[indexPath]
                {
                    cell.lblCount.text = value
                    
                }else
                {
                    cell.lblCount.text = "0"
                    
                }
                
            }
          
            if (indexPath.row == rowsAmount - 1) {
              b4u_Utility.shadowEffectToView(cell)
            }
            else
            {
              cell.layer.shadowOpacity = 0.0;
            }

            if  (selectedIndexPath["\(indexPath.section)"]?.count > 0)
            {
              self.updateHeaderForSection(indexPath.section)
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
            
            
            cell.btnSelectDate.layer.cornerRadius = 2.0
            cell.btnSelectDate.layer.borderColor = UIColor(red:193.0/255, green:195.0/255, blue: 193.0/255, alpha:1.0).CGColor
            cell.btnSelectDate.layer.borderWidth = 1.0
            
            
            
            cell.btnSelectTime.layer.cornerRadius = 2.0
            cell.btnSelectTime.layer.borderColor = UIColor(red:193.0/255, green:195.0/255, blue: 193.0/255, alpha:1.0).CGColor
            
            cell.btnSelectTime.layer.borderWidth = 1.0
            
            b4u_Utility.shadowEffectToView(cell)
          
            return cell
            
        }
        
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = b4u_ExpandableTblHeaderView(tableView: self.expandableTblView, section: section)
        
  
        
        headerView.backgroundColor = UIColor(red:249.0/255, green:249.0/255, blue: 249.0/255, alpha:1.0)
        
        headerView.layer.cornerRadius = 1.0
        
        headerView.layer.borderWidth = 1.0
        
        headerView.layer.borderColor = UIColor(red:221.0/255, green:221.0/255, blue: 221.0/255, alpha:1.0).CGColor
        
        
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
                
                self.updateHeaderForSection(indexPath.section)
                
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
                
                self.updateHeaderForSection(indexPath.section)
                
            }
            
        }
        else
        {
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        if inputArray!.count  == indexPath.section
        {
            return 70
        }
        return 44.0
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
        calendarController.selectedDate = NSDate()

        
        if  bro4u_DataManager.sharedInstance.catlogFilterObj?.todaysTimeSlot?.count > 0
        {
            calendarController.selectedDate = NSDate()
        }
        else{
            calendarController.selectedDate = NSDate().dateByAddingTimeInterval(60*60*24*1)
        }
        let popoverMenuViewController = calendarController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.frame),
            y: CGRectGetMidY(self.view.frame),
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
        quickBookViewCtrl.preferredContentSize = CGSizeMake(300, 300)
        quickBookViewCtrl.delegate = self
        
        let popoverMenuViewController = quickBookViewCtrl.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.bounds),
            y: CGRectGetMidY(self.view.bounds),
            width: 1,
            height: 1)
        presentViewController(
            quickBookViewCtrl,
            animated: true,
            completion: nil)
        
    }
    
    func minusBtnClicked(sender:AnyObject)
    {
        let btn = sender as! b4u_Button
        
        
        let indexPath = btn.indexPath!
        
        
        let cell = self.expandableTblView.cellForRowAtIndexPath(indexPath) as! b4u_ExpandableTblViewCell
        
        
        var count:Int =  Int(cell.lblCount.text!)!
        
        if count > 0
        {
            count = count - 1
            
            // self.expandableTblView.reloadData()
            
            cell.lblCount.text = "\(count)"
            
            self.textBoxGroupVaues[indexPath] = cell.lblCount.text
            
            
        }
        if count == 0
        {
            cell.lblCount.text = "\(count)"
            
            if  self.selectedIndexPath["\(btn.tag)"]?.count > 0
            {
                //This is on click of same Cell
                if (selectedIndexPath["\(indexPath.section)"]!.contains(indexPath)) {
                    let i = selectedIndexPath["\(indexPath.section)"]?.indexOf(indexPath)
                    selectedIndexPath["\(indexPath.section)"]?.removeAtIndex(i!)
                    
                    self.textBoxGroupVaues.removeValueForKey(indexPath)
                }
            }
            
            
        }
    }
    
    func plusBtnClicked(sender:AnyObject)
    {
        let btn = sender as! b4u_Button
        // numberOfItems += 1
        
        
        let indexPath = btn.indexPath!
        
        
        let cell = self.expandableTblView.cellForRowAtIndexPath(indexPath) as! b4u_ExpandableTblViewCell
        
        let value = Int(cell.lblCount.text!)!
        
        if value < 5
        {
            cell.lblCount.text = "\(Int(cell.lblCount.text!)! + 1)"
            
            
            if   self.selectedIndexPath["\(btn.tag)"]?.count > 0
            {
                //This is on click of same Cell
                if (selectedIndexPath["\(indexPath.section)"]!.contains(indexPath)) {
                    
                    self.textBoxGroupVaues[indexPath] = cell.lblCount.text
                    
                }else
                {
                    selectedIndexPath["\(indexPath.section)"]?.append(indexPath)
                    self.textBoxGroupVaues[indexPath] = cell.lblCount.text
                    
                }
            }
                
            else
            {
                selectedIndexPath["\(indexPath.section)"] = [indexPath]
                self.textBoxGroupVaues[indexPath] = cell.lblCount.text
            }
        }
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
            
            let height = (bro4u_DataManager.sharedInstance.timeSlots?.timeSlots?.count)!  * 44
            timeSlotController.preferredContentSize = CGSizeMake(150, CGFloat(height))
            
            timeSlotController.delegate = self
            //  timeSlotController.delegate = self
            
            let popoverMenuViewController = timeSlotController.popoverPresentationController
            popoverMenuViewController?.permittedArrowDirections = .Down
            popoverMenuViewController?.delegate = self
            popoverMenuViewController?.sourceView = btn
            popoverMenuViewController?.sourceRect = CGRect(
                x: CGRectGetMidX(btn.bounds),
                y: CGRectGetMidY(btn.bounds),
                width: 1,
                height: 1)
            presentViewController(
                timeSlotController,
                animated: true,
                completion: nil)
            
        }else
        {
            self.view.makeToast(message:"Please Select Date First", duration:1.0, position:HRToastPositionDefault)
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
        
    
        self.textBoxGroupVaues.removeAll()
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
        
        var latitude =  "12.9718915"
        var longitude = "77.6411545"
        
    //    TODO - Uncomment below line for device
        
//        if let currentLocaiotn = bro4u_DataManager.sharedInstance.currenLocation
//        {
//            latitude = "\(currentLocaiotn.coordinate.latitude)"
//            
//            longitude = "\(currentLocaiotn.coordinate.longitude)"
//            
//        }
        
        var params = "?cat_id=\(catId)&\(kAppendURLWithApiToken)"
        
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
                    
                    let key = "\(catFilterAttributes.fieldName!)_\(attributeOption.optionId!)"
                    self.selectionDict[key] = "\(attributeOption.optionId!)"
                    
                }
            }
            
            if catFilterAttributes.inputType == inputType.radio.rawValue
            {
                for (_ , indexPath) in (selectedIndexPath[key]?.enumerate())!
                {
                    let attributeOption:b4u_CatFilterAttributeOptions =  catFilterAttributes.catFilterAttributeOptions![indexPath.row]
                    
                    params = params + "&\(catFilterAttributes.fieldName!)=\(attributeOption.optionId!)"
                    
                    let key = "\(catFilterAttributes.fieldName!)"
                    self.selectionDict[key] = "\(attributeOption.optionId!)"
                }
            }
            if catFilterAttributes.inputType == inputType.textBoxGroup.rawValue
            {
                for (_ , indexPath) in (selectedIndexPath[key]?.enumerate())!
                {
                    
                    let attributeOption:b4u_CatFilterAttributeOptions =  catFilterAttributes.catFilterAttributeOptions![indexPath.row]
                    
                    let value = self.textBoxGroupVaues[indexPath]
                    
                    params = params + "&option_\(attributeOption.optionId!)=\(value!)"
                    
                    let key = "option_\(attributeOption.optionId!)"
                    self.selectionDict[key] = "\(value!))"
                    
                }
            }
            
        }
        
        
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(self.selectionDict, options: NSJSONWritingOptions.PrettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            
            let datastring = NSString(data:jsonData, encoding:NSUTF8StringEncoding) as String?
            
            bro4u_DataManager.sharedInstance.filterSelectionDict = self.selectionDict
            bro4u_DataManager.sharedInstance.selectedFilterSelectionInJsonFormat = datastring
            
            
        } catch let error as NSError {
            print(error)
        }
        
        
        bro4u_DataManager.sharedInstance.userSelectedFilterParams = params
        
        let dateStr = NSDate.dateFormat().stringFromDate(selectedDate)
        
        params = params + "&service_date=\(dateStr)"
        
        params = params + "&service_time=\(selectedTimeSlot)"
        
        params = params + "&latitude=\(latitude)&longitude=\(longitude)&\(kAppendURLWithApiToken)"
        
        
        bro4u_DataManager.sharedInstance.suggestedPatnersResult = nil
        
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        self.view.userInteractionEnabled = false
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kShowServicePatnerApi, params:params, result:{(resultObject) -> Void in
            
            self.view.userInteractionEnabled = true
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            
            self.moveToSuggestedPatner()
            //         self.performSelectorOnMainThread("moveToSuggestedPatner", withObject:nil, waitUntilDone:true)
            
        })
    }
    
    func moveToSuggestedPatner()
    {
        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
        
        if bro4u_DataManager.sharedInstance.suggestedPatnersResult?.suggestedPatners?.count > 0
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
        
        if self.sectionNumberForRadioInputs.isSubsetOf(selectedSectons)
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
    
    func addLoadingIndicator ()
    {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
    
    
    
    @IBAction func homeBtnPressed(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func quickBookSuccess(isSuccess:Bool)
    {
        
        let quickBookThanksCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("b4uQuickBookThanksCtrl") as! b4u_QuickBookThanksCtrl
        
        quickBookThanksCtrl.selectedCategoryObj = self.selectedCategoryObj
        self.navigationController?.pushViewController(quickBookThanksCtrl, animated:true)
    }
    
}
