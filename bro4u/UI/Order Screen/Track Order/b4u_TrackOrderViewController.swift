//
//  b4u_TrackOrderViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 22/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_TrackOrderViewController: UIViewController {

    @IBOutlet weak var viewOrderStatus: b4u_OrderStatusView!
  @IBOutlet weak var lblStatus: UILabel!

    var selectedOrder:b4u_OrdersModel?

    var carTimer:NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
        
        viewOrderStatus.orderStatus = selectedOrder!.statusNumber!.integerValue
        self.lblStatus.text = selectedOrder!.statusDesc!
        
        carTimer =  NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector:"updateCar", userInfo:nil, repeats:true)
        
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func updateCar()
    {
        if viewOrderStatus?.carPercent <= 100
        {
            viewOrderStatus?.carPercent = viewOrderStatus.carPercent + 5.0
            viewOrderStatus?.setNeedsDisplay()
        }else
        {
            carTimer?.invalidate()
            carTimer = nil
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

  @IBAction func btnCloseClicked(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion:nil)
  }

}
