//
//  b4u-CategoryTblViewCtrl1.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit


protocol categroyTblDelegate: NSObjectProtocol
{
    func didSelecteCategory(selectedCategory:b4u_Category , attributeOptions:b4u_AttributeOptions?)
}

class b4u_CategoryTblViewCtrl1: UIViewController,UITableViewDataSource,UITableViewDelegate ,tableViewCustomDelegate {

    @IBOutlet weak var tableViewCategory: b4u_CateforyTblView!
    
    var categoryAndSubOptions:[b4u_Category] = Array()

    var delegate:categroyTblDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableViewCategory.separatorInset = UIEdgeInsetsZero
        self.tableViewCategory.layoutMargins = UIEdgeInsetsZero
        
        self.tableViewCategory.customTblDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "interMediateSegue1"
        {
            if let indexPath:NSIndexPath = (sender as! NSIndexPath)
            {
                let categoryObj = self.categoryAndSubOptions[indexPath.section]
                
                let navCtrl = segue.destinationViewController as! UINavigationController
                
                let intermediateScreenCtrlObj = navCtrl.topViewController as! b4u_IntermediateViewCtrl
                intermediateScreenCtrlObj.selectedCategoryObj = categoryObj
                
                if categoryObj.attributeOptins?.count > 0
                {
                    intermediateScreenCtrlObj.selectedAttributeOption = categoryObj.attributeOptins![indexPath.row]
                }
                
            }
        }
    }


    
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (categoryAndSubOptions.count)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let categoryObj = categoryAndSubOptions[section]
        
        if categoryObj.attributeOptins?.count > 0
        {
            
            if (self.tableViewCategory.sectionOpen != NSNotFound && section == self.tableViewCategory.sectionOpen) {
                return (categoryObj.attributeOptins?.count)!
            }
        }
        return 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
     let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! b4u_CategoryTblViewCell
        
        let categoryObj = categoryAndSubOptions[indexPath.section]

        let attrubuteOption = categoryObj.attributeOptins![indexPath.row]
        
       // cell.iconImgView?.image = UIImage(named:"downArrow")
        cell.lblTitle?.text = attrubuteOption.optionName
        
       return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = b4u_CategoryHeaderView(tableView: self.tableViewCategory, section: section)
        headerView.backgroundColor = UIColor.whiteColor()
        
        
        let categoryObj = categoryAndSubOptions[section]

         let imgViewIcon:UIImageView = UIImageView()
        
        imgViewIcon.frame = CGRectMake(10, 18, 35,CGRectGetHeight(headerView.frame)-35)
        
         imgViewIcon.downloadedFrom(link:categoryObj.catIcon!, contentMode:UIViewContentMode.ScaleAspectFit)

    
        headerView.addSubview(imgViewIcon)

        
        let label = UILabel(frame:CGRectMake(CGRectGetWidth(imgViewIcon.frame) + 30, 0, CGRectGetWidth(headerView.frame),CGRectGetHeight(headerView.frame)))
        
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont(name: "Helvetica Neue", size: 19)
        label.textColor = UIColor.blackColor()
        
        headerView.addSubview(label)

        label.text =  categoryObj.catName
        
        return headerView
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        let categoryObj = self.categoryAndSubOptions[indexPath.section]
        
        
        var attributeOptions:b4u_AttributeOptions?
        
        if categoryObj.attributeOptins?.count > 0
        {
           attributeOptions = categoryObj.attributeOptins![indexPath.row]
        }
        
        
        self.delegate?.didSelecteCategory(categoryObj, attributeOptions: attributeOptions)
        
        
//        self.performSegueWithIdentifier("interMediateSegue1", sender:indexPath)

        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01;
        
    }
    
    func didSelectRowAt(section:Int)
    {
        
        let categoryObj = self.categoryAndSubOptions[section]
        
        self.delegate?.didSelecteCategory(categoryObj, attributeOptions:nil)
       
        
//        self.performSegueWithIdentifier("interMediateSegue1", sender:NSIndexPath(forRow:0, inSection:section))

    }
    

}
