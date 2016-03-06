//
//  MyInfoViewController.swift
//  ThanksScreen
//
//  Created by MSP-User3 on 03/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class MyInfoViewController: UIViewController {

  @IBOutlet var nameTxtFld: UITextField!
  @IBOutlet var mobileNoTxtFld: UITextField!
  @IBOutlet var emailTxtFld: UITextField!
  @IBOutlet var maleBtn: UIButton!
  @IBOutlet var femaleBtn: UIButton!
  @IBOutlet var dateBtn: UIButton!
  @IBOutlet var userNameLbl: UILabel!
  @IBOutlet var userImageView: UIImageView!
  
  
  @IBAction func dateBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func maleBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func femaleBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func updateBtnAction(sender: AnyObject) {
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
