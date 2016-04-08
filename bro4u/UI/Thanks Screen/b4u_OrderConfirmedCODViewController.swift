//
//  b4u_OrderConfirmedCODViewController.swift
//  bro4u
//
//  Created by Rahul on 08/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OrderConfirmedCODViewController: UIViewController {

    
    @IBOutlet weak var imgViewServiceProvider: UIImageView!
    @IBOutlet weak var lblServiceProvide: UILabel!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblServiceDate: UILabel!
    @IBOutlet weak var lblTimeSlot: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblServiceStatus: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblOrderedAt: UILabel!
    @IBOutlet weak var lblHeasder: UILabel!
    @IBOutlet weak var lblSubheader: UILabel!
    @IBOutlet weak var lblOnlineAdvantage1: UILabel!
    @IBOutlet weak var lblOnlineAdvantage2: UILabel!
    @IBOutlet weak var lblOnlineAdvantage3: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func actionOngoingOrder(sender: AnyObject) {
    }

    @IBAction func actioonContinueShopping(sender: AnyObject) {
    }
    
}
