//
//  b4u_ReviewServiceViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 01/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ReviewServiceViewController: UIViewController {

    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnThumbsUP: UIButton!
    @IBOutlet weak var btnThumbsDown: UIButton!
    @IBOutlet weak var btnPoor: UIButton!

    @IBOutlet weak var btnGreat: UIButton!
    @IBOutlet weak var lblVendorName: UILabel!
    
    @IBOutlet weak var btnStar3: UIButton!
    
    @IBOutlet weak var textViewComments: UITextField!
    @IBOutlet weak var lblStarSelectionMessage: UILabel!
    @IBOutlet weak var btnStar5: UIButton!
    @IBOutlet weak var btnStar4: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStr1: UIButton!
    
    var selectedOrder:b4u_OrdersModel?

    var partnerCameOnTime:String?
    var qualityFlag:String?
    var starSelected:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.qualityFlag = selectedOrder?.serviceQuality
        
        self.textViewComments.text = selectedOrder?.feedback
        
        self.starSelected = selectedOrder?.rating
        
        self.partnerCameOnTime = selectedOrder?.onTime
        
        
        self.lblVendorName.text = selectedOrder?.vendorName
        
        self.refreshComeOnTime()
        self.refreshQualityUI()
        self.refreshStarSelection()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refreshComeOnTime()
    {
        if  let vendorCameOnTime = self.partnerCameOnTime
        {
            if vendorCameOnTime == "yes"
            {
                self.btnThumbsUP.setImage(UIImage(named:"likePressed"), forState:.Normal)
                self.btnThumbsUP.backgroundColor = UIColor.yellowColor()
                self.btnThumbsDown.setImage(UIImage(named:"dislikeGrey"), forState:.Normal)
                self.btnThumbsDown.backgroundColor = UIColor.whiteColor()

            }else
            {
                self.btnThumbsDown.setImage(UIImage(named:"dislike"), forState:.Normal)
                self.btnThumbsDown.backgroundColor = UIColor.yellowColor()
                self.btnThumbsUP.setImage(UIImage(named:"like"), forState:.Normal)
                self.btnThumbsUP.backgroundColor = UIColor.whiteColor()

            }
        }else
        {
            self.btnThumbsUP.setImage(UIImage(named:"like"), forState:.Normal)
            self.btnThumbsDown.setImage(UIImage(named:"dislikeGrey"), forState:.Normal)

        }
    }

    
    func refreshQualityUI()
    {
        if let aQFlag = self.qualityFlag
        {
            if aQFlag == "poor"
            {
                self.btnPoor.setImage(UIImage(named:"angryYellow"), forState:.Normal)
                self.btnOk.setImage(UIImage(named:"poor"), forState:.Normal)
                self.btnGreat.setImage(UIImage(named:"smiley"), forState:.Normal)
                
            }else if aQFlag == "okay"
            {
                self.btnPoor.setImage(UIImage(named:"angry"), forState:.Normal)
                self.btnOk.setImage(UIImage(named:"poorPressed"), forState:.Normal)
                self.btnGreat.setImage(UIImage(named:"smiley"), forState:.Normal)
                
            }else if aQFlag == "great"
            {
                self.btnPoor.setImage(UIImage(named:"angry"), forState:.Normal)
                self.btnOk.setImage(UIImage(named:"poor"), forState:.Normal)
                self.btnGreat.setImage(UIImage(named:"smileyPressed"), forState:.Normal)
            }
            
        }
    }
    
    func refreshStarSelection()
    {
        if let aStarSelected = self.starSelected
        {
            
            switch aStarSelected
            {
            case "1" :
                print("One Star")
                
                self.btnStr1.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar2.setImage(UIImage(named:"starGrey"), forState:.Normal)
                self.btnStar3.setImage(UIImage(named:"starGrey"), forState:.Normal)
                self.btnStar4.setImage(UIImage(named:"starGrey"), forState:.Normal)
                self.btnStar5.setImage(UIImage(named:"starGrey"), forState:.Normal)

            case "2" :
                print("One Star")
                
                self.btnStr1.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar2.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar3.setImage(UIImage(named:"starGrey"), forState:.Normal)
                self.btnStar4.setImage(UIImage(named:"starGrey"), forState:.Normal)
                self.btnStar5.setImage(UIImage(named:"starGrey"), forState:.Normal)

            case "3" :
                print("One Star")
                self.btnStr1.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar2.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar3.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar4.setImage(UIImage(named:"starGrey"), forState:.Normal)
                self.btnStar5.setImage(UIImage(named:"starGrey"), forState:.Normal)
            case "4" :
                print("One Star")
                self.btnStr1.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar2.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar3.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar4.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar5.setImage(UIImage(named:"starGrey"), forState:.Normal)
            case "5" :
                print("One Star")
                self.btnStr1.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar2.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar3.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar4.setImage(UIImage(named:"star"), forState:.Normal)
                self.btnStar5.setImage(UIImage(named:"star"), forState:.Normal)
            default :
                print("no star")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnThumbsDown(sender: AnyObject)
    {
        self.partnerCameOnTime = "no"
        self.refreshComeOnTime()
    }
    @IBAction func btnThumbsPressed(sender: AnyObject)
    {
        self.partnerCameOnTime = "yes"

        self.refreshComeOnTime()

    }
    @IBAction func greatrBtnPressed(sender: AnyObject)
    {
        self.qualityFlag = "great"
        self.refreshQualityUI()
    }
    @IBAction func okayBtnPressed(sender: AnyObject)
    {
        self.qualityFlag = "okay"
        self.refreshQualityUI()

    }

    @IBAction func poorBtnPressed(sender: AnyObject)
    {
        self.qualityFlag = "poor"
        self.refreshQualityUI()

    }
    @IBAction func btnStar5Pressed(sender: AnyObject)
    {
        self.starSelected = "5"
        self.lblStarSelectionMessage.text = "Thanks! see you again"

        self.refreshStarSelection()
    }
    @IBAction func btnStar4Pressed(sender: AnyObject)
    {
        self.starSelected = "4"
        self.lblStarSelectionMessage.text = "Happy to serve"

        self.refreshStarSelection()


    }
    @IBAction func btnStar3Pressed(sender: AnyObject)
    {
        self.starSelected = "3"
        self.lblStarSelectionMessage.text = "We will improve for sure"

        self.refreshStarSelection()


    }
    @IBAction func btnStar2Pressed(sender: AnyObject) {
        self.starSelected = "2"
        
        self.lblStarSelectionMessage.text = "Ohh! really really sorry"

        self.refreshStarSelection()


    }
    @IBAction func btnStar1Pressed(sender: AnyObject) {
        self.starSelected = "1"
        
        self.lblStarSelectionMessage.text = "We screwed it! So sorry"
        self.refreshStarSelection()


    }
    @IBAction func sumbmitBtnAction(sender: AnyObject)
    {
        
        guard let selectedRating = self.starSelected else {
        
             self.view.makeToast(message:"Please Select Rating", duration:1.0, position:HRToastPositionDefault)
            
            return
        }
        
        //index.php/order/add_order_review/14348?user_id=1626&service_quality=good&on_time=yes&rating=4&feedback=34
        
        var serviceQuality = ""
        
        if let aQuality = self.qualityFlag
        {
            serviceQuality = aQuality
        }
        
        var onTime = ""
        
        if let aOnTime = self.partnerCameOnTime
        {
            onTime = aOnTime
        }
        
        var comments = ""
        
        if let aComment = self.textViewComments.text
        {
            comments = aComment
        }
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
        
        let params = "\(self.selectedOrder!.orderID!)?user_id=\(bro4u_DataManager.sharedInstance.loginInfo!.userId!)&service_quality=\(serviceQuality)&on_time=\(onTime)&feedback=\(comments)&rating=\(selectedRating)"
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kRateAndReviewOrderIndex, params:params, result:{(resultObject) -> Void in
            
            
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            
            self.view.makeToast(message:"Reveiw Submited Successfully", duration:2.0, position:HRToastPositionDefault)

            
            self.navigationController?.popViewControllerAnimated(true)
            
            
            
        })
        
    }
}
