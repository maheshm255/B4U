//
//  b4u_ReOrderTableViewCell.swift
//  ThanksScreen
//
//  Created by Rahul on 11/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class b4u_ReOrderTableViewCell: UITableViewCell {

   
    @IBOutlet weak var btnReOrder: UIButton!
    @IBOutlet weak var btnViewOrderDetails: UIButton!
    @IBOutlet weak var btnOrderDelete: UIButton!
    
    @IBOutlet weak var vendorImageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var subTitleLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var orderIDLbl: UILabel!
    @IBOutlet var timeSlotLbl: UILabel!
    @IBOutlet var amountLbl: UILabel!
    
    
    @IBAction func deleteAction(sender: AnyObject) {
    
        let tableView = self.superview?.superview as! UITableView
        
        let indexPath = tableView.indexPathForCell(self)

        let reOrderModel:b4u_ReOrderModel = bro4u_DataManager.sharedInstance.myReorderData[indexPath!.section]
        
        
        
        let filedName = reOrderModel.orderID!
        
        
        let params = "/\(filedName)"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kReOrderDeleteIndex, params:params, result:{(resultObject) -> Void in
            
            
        })

    }
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureData(reOrderDataModel:b4u_ReOrderModel)
    {
        if let vendorImageUrl = reOrderDataModel.profilePic
        {
            self.vendorImageView.downloadedFrom(link:vendorImageUrl, contentMode:UIViewContentMode.ScaleToFill)
        }
        if let categoryName = reOrderDataModel.catName
        {
            self.titleLbl.text = categoryName
        }
        if let itemName = reOrderDataModel.itemName
        {
            self.subTitleLbl.text = itemName
        }
        if let serviceDate = reOrderDataModel.serviceDate
        {
            self.dateLbl.text = serviceDate
        }
        if let orderID = reOrderDataModel.orderID
        {
            self.orderIDLbl.text = "#\(orderID)"
        }
        if let timeSlot = reOrderDataModel.serviceTime
        {
            self.timeSlotLbl.text = timeSlot
        }
        if let amount = reOrderDataModel.subTotal //Need to check Key
        {
            self.amountLbl.text = "Rs. \(amount).00"
        }
    }
    
   
}
