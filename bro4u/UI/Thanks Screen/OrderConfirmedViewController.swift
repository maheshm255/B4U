//
//  OrderConfirmedViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 01/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class OrderConfirmedViewController: UIViewController {

  @IBOutlet var userImageView: UIImageView!
  @IBOutlet var titleLbl: UILabel!
  @IBOutlet var subTitleLbl: UILabel!
  @IBOutlet var dateLbl: UILabel!
  @IBOutlet var timeSlotLbl: UILabel!
  @IBOutlet var orderIDLbl: UILabel!
  @IBOutlet var serviceStatusLbl: UILabel!
  @IBOutlet var orderedAtDateLbl: UILabel!
  
  
  
  @IBAction func callBro4uAction(sender: AnyObject) {
  }
  
  
  @IBAction func payOnlineAction(sender: AnyObject) {
  }
  
  
  @IBAction func checkOtherServicesAction(sender: AnyObject) {
  }
  
  
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

}
