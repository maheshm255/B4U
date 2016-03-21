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

    
    var selectedIndexPath:Dictionary<String ,[NSIndexPath]> = Dictionary()
    var numberOfItems:Int = 0
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
        
        bro4u_DataManager.sharedInstance.timeSlots = nil
        self.callFilterApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func callFilterApi()
    {
        
        if let aSelectedCatObj = selectedCategoryObj
        {
            let catId = aSelectedCatObj.catId!
            let optionId =  aSelectedCatObj.optionId!
            let filedName = aSelectedCatObj.fieldName!
            
            
            let params = "?cat_id=\(catId)&option_id=\(optionId)&field_name=\(filedName)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(filterApi, params:params, result:{(resultObject) -> Void in
                
                self.updateUI()
                
            })
        }else if let aSelectedSlideImg = self.selectedImgSlide
        {
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
        self.expandableTblView.reloadData()
    }
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
                
                let checkBoxCellIdentifier = "textBoxGroupCell"
                
                cell = tableView.dequeueReusableCellWithIdentifier(checkBoxCellIdentifier, forIndexPath: indexPath) as! b4u_ExpandableTblViewCell
                cell.lblTitle?.text =  aItem.optionName
                
                cell.btnMinus.addTarget(self, action:"minusBtnClicked:", forControlEvents:.TouchUpInside)
                
                
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

        let label = UILabel(frame:CGRectMake(10, 0, CGRectGetWidth(headerView.frame),CGRectGetHeight(headerView.frame)))

        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont(name: "HelveticaNeue-neue", size: 14)
        label.textColor = UIColor.blackColor()
        
        headerView.addSubview(label)
        
        if section < inputArray?.count
        {
      
        let catFilterAttributes:b4u_CatFilterAttributes = self.inputArray![section] as! b4u_CatFilterAttributes
        label.text =  catFilterAttributes.attrName!
       
        }else
        {
            label.text =  "When do you need service?"
            
            headerView.toggleButton.enabled = false
        }
        
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
        }
        else
        {
            
        }
    
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

    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    
    func minusBtnClicked(sender:AnyObject)
    {
        if numberOfItems > 0
        {
            numberOfItems--
            
            self.expandableTblView.reloadData()
        }
    }
    
    func plusBtnClicked(sender:AnyObject)
    {
        let btn = sender as! UIButton
        numberOfItems++
        
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
    }
    
    
    func callServicePatnerApi()
    {
        
       guard let selectedDate = bro4u_DataManager.sharedInstance.selectedDate , let selectedTimeSlot = bro4u_DataManager.sharedInstance.selectedTimeSlot else
        {
               print("Select Date And Time")
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
        
        var params = "?cat_id=\(catId)&latitude=\(latitude)&longitude=\(longitude)"
        
        
        
        
        let dateStr = NSDate.dateFormat().stringFromDate(selectedDate)
        
        params = params + "&service_date=\(dateStr)"
        
        params = params + "&service_time=\(selectedTimeSlot)"
        
        
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
        
        bro4u_DataManager.sharedInstance.suggestedPatnersResult = nil
        b4u_WebApiCallManager.sharedInstance.getApiCall(kShowServicePatnerApi, params:params, result:{(resultObject) -> Void in
            
            
            
            self.performSelectorOnMainThread("moveToSuggestedPatner", withObject:nil, waitUntilDone:true)
            
        })
    }
    
    func moveToSuggestedPatner()
    {
        if let suggestedPatners = bro4u_DataManager.sharedInstance.suggestedPatnersResult?.suggestedPatners
        {
            self.performSegueWithIdentifier("servicePatnerSegue", sender:nil)
            
        }else
        {
            //TODO
        }
    }
    
    @IBAction func showServicePatnerBtnClicked(sender: AnyObject)
    {
        self.callServicePatnerApi()
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
    
    
}
