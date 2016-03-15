//
//  OngoingOrdersTableViewCell.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit



class OngoingOrdersTableViewCell: UITableViewCell {

  @IBOutlet var vendorImageView: UIImageView!
  @IBOutlet var tiltleLbl: UILabel!
  @IBOutlet var subTitleLbl: UILabel!
  @IBOutlet var dateLbl: UILabel!
  @IBOutlet var timeSlotLbl: UILabel!
  @IBOutlet var dateTimeLbl: UILabel!
  @IBOutlet var orderIDLbl: UILabel!
  @IBOutlet var statusLbl: UILabel!
  @IBOutlet var bookingLbl: UILabel!
  @IBOutlet var priceLbl: UILabel!
  
  
  
  @IBAction func cancelBtnAction(sender: AnyObject) {
  
    let tableView = self.superview?.superview as! UITableView
    
    let indexPath = tableView.indexPathForCell(self)
    
    let orderModel:b4u_OrdersModel = bro4u_DataManager.sharedInstance.orderData[indexPath!.row]
    var metaDataModel:b4u_ReOrder_MetaItemModel?
    if orderModel.metaItemReOrder?.count > 0{
        
        metaDataModel = orderModel.metaItemReOrder?.first
        
        let params = "?order_id=\(orderModel.orderID!)&user_id=\(metaDataModel!.userID!)&vendor_id=\(orderModel.vendorID!)&cancel_message=\("Text")"//Need to pass the textfield Message from popup
        
        b4u_WebApiCallManager.sharedInstance.getApiCall(kCancelOrderIndex, params:params, result:{(resultObject) -> Void in

        })
    }


    tableView.reloadData()
  }
  
  @IBAction func trackBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func rescheduledBtnAction(sender: AnyObject) {
  }
  
  
  @IBAction func callBro4uAction(sender: AnyObject) {
  }
  
  
  @IBAction func payOnlineAction(sender: AnyObject) {
  }
  
  
  
  @IBOutlet var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(orderDataModel:b4u_OrdersModel)
    {
        if let vendorImageUrl = orderDataModel.profilePic
        {
            self.vendorImageView.downloadedFrom(link:vendorImageUrl, contentMode:UIViewContentMode.ScaleToFill)
        }
        if let categoryName = orderDataModel.catName
        {
            self.tiltleLbl.text = categoryName
        }
        if let vendorName = orderDataModel.vendorName
        {
            self.subTitleLbl.text = vendorName
        }
        if let serviceDate = orderDataModel.serviceDate
        {
            self.dateLbl.text = serviceDate
        }
        if let orderID = orderDataModel.orderID
        {
            self.orderIDLbl.text = "#\(orderID)"
        }
        if let timeSlot = orderDataModel.serviceTime
        {
            self.timeSlotLbl.text = timeSlot
        }
        if let timeStamp = orderDataModel.timestamp
        {
            self.dateTimeLbl.text = timeStamp
        }
        if let orderStatus = orderDataModel.statusDesc
        {
            self.statusLbl.text = orderStatus
        }
        if let price = orderDataModel.finalTotal //Need to check Key
        {
            self.priceLbl.text = "Rs. \(price).00"
        }
    }

}
