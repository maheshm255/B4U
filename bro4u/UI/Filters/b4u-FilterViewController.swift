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

class b4u_FilterViewController: UIViewController {

    @IBOutlet weak var expandableTblView: b4u_ExpandableTableView!
    
    var selectedCategoryObj:b4u_Category?

    var selectedIndexPath:Dictionary<String ,[NSIndexPath]> = Dictionary()
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
        
        let dateFormat = NSDate.dateFormat() as NSDateFormatter
        
       let currentDate =  dateFormat.stringFromDate(NSDate())
        
        btn.setTitle(currentDate, forState:UIControlState.Normal)
        
        self.callTimeSlotApi("26-02-2016")
    
       
    }
    
    func btnSelectTimeClicked(sender:AnyObject)
    {
        
    }
    @IBAction func clearBtnClicked(sender: AnyObject) {
    }
    @IBAction func showServicePatnerBtnClicked(sender: AnyObject) {
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


}
