//
//  b4u_CancelOrderViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 22/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit


protocol orderCancelDelegate: NSObjectProtocol
{
    func cancelOrder(order:b4u_OrdersModel , selectedIssue:String , reason:String)
    func didCloseCancelIssue()
}

class b4u_CancelOrderViewController: UIViewController,singleSelectionDelegate,UIPopoverPresentationControllerDelegate {
    
    
    @IBOutlet weak var txtViewReason: UITextView!
    
    @IBOutlet weak var bntCancelOrder: UIButton!
    
    @IBOutlet weak var btnSelectReason: UIButton!
    
    var selectedOrder:b4u_OrdersModel?
    
    @IBOutlet weak var btnClose: UIButton!
    
    var delegate:orderCancelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        
//        self.bntCancelOrder.layer.borderColor = UIColor.lightGrayColor().CGColor
//        self.bntCancelOrder.layer.borderWidth = 1.0
//        
        self.btnSelectReason.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.btnSelectReason.layer.borderWidth = 1.0
        
        self.btnClose.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.btnClose.layer.borderWidth = 1.0
        
        
        txtViewReason.layer.cornerRadius = 5
        txtViewReason.layer.borderColor = UIColor.grayColor().CGColor
        txtViewReason.layer.borderWidth = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func callBro4uBtnAction(sender: AnyObject)
    {
        b4u_Utility.callAt(b4uNumber)

    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnCloseClicked(sender: AnyObject) {
        
        delegate?.didCloseCancelIssue()
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func btnCancelOrderClicked(sender: AnyObject)
    {
        
        guard let selectedIssue = self.btnSelectReason.titleLabel?.text where selectedIssue != "Select Reason to Cancel" else
        {
            self.view.makeToast(message:"Please enter reason", duration:1.0, position: HRToastPositionDefault)
            return
        }
        
        guard let comments = self.txtViewReason.text where comments != "" else
        {
            self.view.makeToast(message:"Please enter reason", duration:1.0, position: HRToastPositionDefault)
            return
        }
        
        
        self.delegate?.cancelOrder(selectedOrder!, selectedIssue:selectedIssue, reason: comments)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
  
    @IBAction func btnSelectReasonPressed(sender: AnyObject) {
        self.showIssuesPopUp()

    }
    
    @IBAction func btnSelectReasonActon(sender: AnyObject)
    {
        self.showIssuesPopUp()
    }
    
    
    func showIssuesPopUp()
    {
        
        let  alertViewCtrl = storyboard!.instantiateViewControllerWithIdentifier("b4uSingleSelectionTblCtrl") as! b4u_SingleSelectionTblCtrl
        
                
        alertViewCtrl.inputArray = ["Price issue","No response" , "I'm unavailable" , "Better deal","Others"]
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
    
    func didSelect(selectedString:String)
    {
        self.btnSelectReason.setTitle(selectedString, forState:UIControlState.Normal)
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
}
