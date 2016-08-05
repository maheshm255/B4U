//
//  PastOrdersTableViewCell.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class PastOrdersTableViewCell: UITableViewCell {

  
  @IBOutlet var vendorImageView: UIImageView!
  @IBOutlet var titleLbl: UILabel!
  @IBOutlet var subTitleLbl: UILabel!
  @IBOutlet var dateLbl: UILabel!
  @IBOutlet var timeSlotLbl: UILabel!
  @IBOutlet var dateTimeLbl: UILabel!
  @IBOutlet var orderIDLbl: UILabel!
  @IBOutlet var serviceStatusLbl: UILabel!
  @IBOutlet var bookingLbl: UILabel!
  @IBOutlet var priceLbl: UILabel!
  
    @IBOutlet weak var btnWriteReview: UIButton!
  
    @IBOutlet weak var btnRaiseIssue: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.serviceStatusLbl.layer.borderColor = UIColor.grayColor().CGColor
        self.serviceStatusLbl.layer.borderWidth = 1
    }
  

    func configureData(orderDataModel:b4u_OrdersModel)
    {
        if let vendorImageUrl = orderDataModel.profilePic
        {
            self.vendorImageView.downloadedFrom(link:vendorImageUrl, contentMode:UIViewContentMode.ScaleToFill)
        }
        if let categoryName = orderDataModel.catName
        {
            self.titleLbl.text = categoryName
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
            self.serviceStatusLbl.text = " \(orderStatus) "
            
            if orderStatus == "Cancelled"
            {
                self.btnWriteReview.hidden = true
            }
            else{
                self.btnWriteReview.hidden = false
            }
        }
        if let price = orderDataModel.finalTotal //Need to check Key
        {
            self.priceLbl.text = "Rs. \(price).00"
        }
        
        if orderDataModel.onTime! == "yes" || (orderDataModel.serviceQuality?.characters.count)! > 0 ||
        orderDataModel.rating != "0" || (orderDataModel.feedback?.characters.count)! > 0 {
        
            self.btnWriteReview.setTitle("EDIT REVIEW", forState: UIControlState.Normal)
 
        }
        else{
            self.btnWriteReview.setTitle("WRITE REVIEW", forState: UIControlState.Normal)

        }
        
        
    }
  

}
