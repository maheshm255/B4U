//
//  OngoingOrdersTableViewCell.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit



class OngoingOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnReshedule: UIButton!
    @IBOutlet weak var btnTrack: UIButton!
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
    
  
  
  

  
  
  @IBOutlet var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        btnCancel.layer.cornerRadius = 5
        btnCancel.layer.borderColor = UIColor.grayColor().CGColor
        btnCancel.layer.borderWidth = 1
        
        btnReshedule.layer.cornerRadius = 5
        btnReshedule.layer.borderColor = UIColor.grayColor().CGColor
        btnReshedule.layer.borderWidth = 1
        
//        btnTrack.layer.cornerRadius = 5
//        btnTrack.layer.borderColor = UIColor.grayColor().CGColor
//        btnTrack.layer.borderWidth = 1
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
