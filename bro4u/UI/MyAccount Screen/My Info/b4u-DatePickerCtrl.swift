//
//  b4u-DatePickerCtrl.swift
//  bro4u
//
//  Created by Mac on 20/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit



protocol dateSelectionDelegate: NSObjectProtocol {
    func didSelecteDate(dateStr:String?)
}

class b4u_DatePickerCtrl: UIViewController {

    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    var selectedDate:String?
    var delegate:dateSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func datePickerAction(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.stringFromDate(myDatePicker.date)
        
        
        print(strDate)
        self.selectedDate = strDate
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.delegate?.didSelecteDate(self.selectedDate)
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
