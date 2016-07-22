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
    var selectedReorderTag:Int?
    
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

        if let reOrderModel:b4u_ReOrderModel = bro4u_DataManager.sharedInstance.myReorderData[selectedReorderTag!]{
            
            lblCategoryDetail.text = reOrderModel.itemName!
            lblCategory.text = reOrderModel.vendorName!
            lblSubTotal.text = "\(reOrderModel.subTotal!)"
        }
    }



    
}
