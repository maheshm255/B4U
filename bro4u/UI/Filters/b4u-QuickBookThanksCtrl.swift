//
//  b4u-QuickBookThanksCtrl.swift
//  bro4u
//
//  Created by Mac on 21/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_QuickBookThanksCtrl: UIViewController {

    @IBOutlet weak var btnCheckOurOtherServices: UIButton!
    @IBOutlet weak var btnCallBro4U: UIButton!
    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCatName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgViewCenterIcon: UIImageView!
    @IBOutlet weak var imgViewBackground: UIImageView!
    
    var selectedCategoryObj:b4u_Category?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.updateUIdata()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func updateUIdata()
    {
        self.lblCatName.text = self.selectedCategoryObj?.catName!
        
        if let selectedDate = bro4u_DataManager.sharedInstance.selectedDate
        {
            self.lblDate.text = NSDate.dateFormat().stringFromDate(selectedDate)
        }
        
        self.lblTime.text = bro4u_DataManager.sharedInstance.selectedTimeSlot
        
        self.lblTitle.text = self.selectedCategoryObj?.catName!
        
        self.imgViewCenterIcon.downloadedFrom(link:(self.selectedCategoryObj?.catIcon)!, contentMode: .ScaleToFill)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

   
    @IBAction func btnCallBro4uPressed(sender: AnyObject)
    {
        let url = NSURL(string:"tel://08030323232")!
        
        if UIApplication.sharedApplication().canOpenURL(url)
        {
            UIApplication.sharedApplication().openURL(url)
        }else
        {
            print("Call is not supported")
        }
    }
    @IBAction func btnBackPressed(sender: AnyObject)
    {
        self.navigationController?.popToRootViewControllerAnimated(true)

    }
    @IBAction func btnCheckOtherServicesPressed(sender: AnyObject)
    {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
