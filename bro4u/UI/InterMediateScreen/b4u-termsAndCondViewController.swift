//
//  b4u-termsAndCondViewController.swift
//  bro4u
//
//  Created by Mac on 11/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_termsAndCondViewController: UIViewController {

    @IBOutlet weak var lblCondition3: UILabel!
    @IBOutlet weak var lblCondition2: UILabel!
    @IBOutlet weak var lblCondition1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.preferredContentSize = CGSize(width:300, height: 200)
        
        self.updateUI()
    }

    
    func updateUI()
    {
        if let tAndCOb = bro4u_DataManager.sharedInstance.interMediateScreenDataObj?.termsAndConditions
        {
          let bulletSign = "\u{2022}"
          lblCondition1.text =  " \(bulletSign) \(tAndCOb[0]) "
            
            if tAndCOb.count > 1
            {
                lblCondition2.text = " \(bulletSign) \(tAndCOb[1]) "
            }
            
            if tAndCOb.count > 2
            {
                lblCondition3.text = " \(bulletSign) \(tAndCOb[2]) "
            }
            
            
        }
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
