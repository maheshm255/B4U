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
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCatName: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgViewCenterIcon: UIImageView!
    @IBOutlet weak var imgViewBackground: UIImageView!
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

   
    @IBAction func btnCallBro4uPressed(sender: AnyObject) {
    }
    @IBAction func btnBackPressed(sender: AnyObject) {
    }
    @IBAction func btnCheckOtherServicesPressed(sender: AnyObject) {
    }
}
