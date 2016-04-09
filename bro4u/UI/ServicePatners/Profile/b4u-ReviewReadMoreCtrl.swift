//
//  b4u-ReviewReadMoreCtrl.swift
//  bro4u
//
//  Created by Mac on 09/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ReviewReadMoreCtrl: UIViewController {

    @IBOutlet weak var imgViewStar5: UIImageView!
    @IBOutlet weak var imgViewStar4: UIImageView!
    @IBOutlet weak var imgViewStar3: UIImageView!
    @IBOutlet weak var imgViewStar2: UIImageView!
    @IBOutlet weak var imgViewStar1: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var lblReviewerName: UILabel!
    @IBOutlet weak var imgViewIcon: UIImageView!
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

    @IBAction func btnGotItPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
