//
//  b4u-quantityViewController.swift
//  bro4u
//
//  Created by Mac on 06/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

protocol quantityDelegate: NSObjectProtocol {
    func selectedQuanitty(quantity:String?)
}


class b4u_quantityViewController: UIViewController , UIPickerViewDelegate ,UIPickerViewDataSource{

    
    let quantitiyData = ["1","2","3","4","5"]
    
    var selectedQuantity:String?
    var delegate:quantityDelegate?
    
    @IBOutlet weak var pickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.pickerView.selectedRowInComponent(0)
        
        selectedQuantity = "1"
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
    @IBAction func cancelButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }

    @IBAction func setButtonAction(sender: AnyObject) {
        
        delegate?.selectedQuanitty(self.selectedQuantity)
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    // returns the number of 'columns' to display.
    internal func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    // returns the # of rows in each component..
    internal func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 5
    }
    
     internal func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return quantitiyData[row]
    }
  
     internal func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selectedQuantity = self.quantitiyData[row]
    }
}
