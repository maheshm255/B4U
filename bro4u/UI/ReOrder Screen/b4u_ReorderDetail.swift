//
//  b4u_ReorderDetail.swift
//  bro4u
//
//  Created by MACBookPro on 5/1/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import Foundation

class b4u_ReOrderDetail: UIViewController {
    
    @IBOutlet weak var lblCategoryDetail: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblSubTotal: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.congigureUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionGotIT(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion:nil)

    }
    
    func congigureUI()
    {
        
        if let selectedPartner:b4u_SugestedPartner = bro4u_DataManager.sharedInstance.selectedSuggestedPatner{
            
            lblCategoryDetail.text = selectedPartner.itemName!
            lblCategory.text = selectedPartner.vendorName!
            lblSubTotal.text = selectedPartner.custPrice!
        }
    }



    
}
