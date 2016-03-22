//
//  b4u_OrderDetailViewController.swift
//  bro4u
//
//  Created by MSP-User3 on 22/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OrderDetailViewController: UIViewController {

  @IBOutlet weak var lblVendorName: UILabel!
  @IBOutlet weak var lblVendorDetail: UILabel!
  @IBOutlet weak var lbluserName: UILabel!
  @IBOutlet weak var lbluserEmail: UILabel!
  @IBOutlet weak var lblAddress: UILabel!
  @IBOutlet weak var lblSubTotal: UILabel!
  @IBOutlet weak var lblGrandTotal: UILabel!

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

  @IBAction func btnCloseClicked(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion:nil)
  }
  


}
