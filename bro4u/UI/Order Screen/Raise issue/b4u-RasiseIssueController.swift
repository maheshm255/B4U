//
//  b4u-RasiseIssueController.swift
//  bro4u
//
//  Created by Mac on 11/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit


protocol orderRaiseIssueDelegate: NSObjectProtocol
{
    func raiseIssue(order:b4u_OrdersModel , selectedIssue:String , reason:String)
    func didCloseRaiseIssue()
}

class b4u_RasiseIssueController: UIViewController  , UIPopoverPresentationControllerDelegate ,singleSelectionDelegate {

    @IBOutlet weak var btnRasieIssue: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnIssues: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textViewComments: UITextView!

    
    var delegate:orderRaiseIssueDelegate?
    var selectedOrder:b4u_OrdersModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.congigureData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func congigureData()
    {
        self.lblTitle.text = "Issues? Tell Us Here \n We will promise to comeback with in 15 Minutes"
        
        self.btnIssues.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.btnIssues.layer.borderWidth = 1.0
       
        self.textViewComments.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.textViewComments.layer.borderWidth = 1.0
       
        self.btnClose.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.btnClose.layer.borderWidth = 1.0
        
        self.btnIssues.setTitle("Select Issue Type", forState:UIControlState.Normal)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnRaiseIssuePressed(sender: AnyObject)
    {
        
        guard let selectedIssue = self.btnIssues.titleLabel?.text where selectedIssue != "Select Issue Type" else
        {
            self.view.makeToast(message:"Please enter reason", duration:1.0, position: HRToastPositionDefault)
            return
        }
        
        guard let comments = self.textViewComments.text where comments != "" else
        {
            self.view.makeToast(message:"Please enter reason", duration:1.0, position: HRToastPositionDefault)
            return
        }
        
        
        self.delegate?.raiseIssue(selectedOrder!, selectedIssue:selectedIssue, reason: comments)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
  
  
    @IBAction func btnIssuesPressed(sender: AnyObject)
    {
        self.showIssuesPopUp()

    }
    @IBAction func btnClosePressed(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showIssuesPopUp()
    {
        
        let  alertViewCtrl = storyboard!.instantiateViewControllerWithIdentifier("b4uSingleSelectionTblCtrl") as! b4u_SingleSelectionTblCtrl
        
     
        
        alertViewCtrl.inputArray = ["No Response","Re-Schedules" , "Price" , "Issues","Others"]
        alertViewCtrl.modalPresentationStyle = .Popover
        alertViewCtrl.preferredContentSize = CGSizeMake(300, 250)
        
        alertViewCtrl.delegate = self
        
        let popoverMenuViewController = alertViewCtrl.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection.Up
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: CGRectGetMidX(self.view.bounds),
            y: CGRectGetMidY(self.view.bounds),
            width: 1,
            height: 1)
        presentViewController(
            alertViewCtrl,
            animated: true,
            completion: nil)
    }

    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    func didSelect(selectedString:String)
    {
        self.btnIssues.setTitle(selectedString, forState:UIControlState.Normal)
    }
}
