//
//  OngoingOrdersTableViewCell.swift
//  MyOrder
//
//  Created by MSP-User3 on 02/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit



class OngoingOrdersTableViewCell: UITableViewCell {
    @IBOutlet weak var btnCallBro4u: UIButton!
    @IBOutlet weak var lblCallBro4u: UILabel!
    @IBOutlet weak var btnPayOnline: UIButton!

    @IBOutlet weak var viewPayOnLine: UIView!
    @IBOutlet weak var ViewCallB4u: UIView!
    @IBOutlet weak var viewHr1: UIView!
    @IBOutlet weak var btnRaiseIssue: UIButton!
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
    
    @IBOutlet weak var lblOfferPrice: UILabel!
    @IBOutlet weak var lblFinalPriceText: UILabel!
  
    @IBOutlet weak var lblFinalPrice: UILabel!
  
    @IBOutlet weak var lblOnLinePayMessage: UILabel!
  
    var constraintY:NSLayoutConstraint?
    var topConstraint:NSLayoutConstraint?
  
  
  @IBOutlet var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
//        btnCancel.layer.cornerRadius = 2
//        btnCancel.layer.borderColor = UIColor.grayColor().CGColor
//        btnCancel.layer.borderWidth = 1
        
        btnReshedule.layer.cornerRadius = 2
        btnReshedule.layer.borderColor = UIColor.grayColor().CGColor
        btnReshedule.layer.borderWidth = 1
        
        btnTrack.layer.cornerRadius = 2
        btnTrack.layer.borderColor = UIColor.grayColor().CGColor
        btnTrack.layer.borderWidth = 1
        
        self.statusLbl.layer.borderWidth = 1
        self.statusLbl.layer.borderColor = UIColor.darkGrayColor().CGColor
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
            self.statusLbl.text = " \(orderStatus) "
        }
       
        
        //OPRC - Order in processing 
        
        if (orderDataModel.statusCode == "OPRC") && (orderDataModel.paymentType == "cod" ||
          (orderDataModel.paymentType == "online" && orderDataModel.paymentStatus == "success"))
        {
            if Double(orderDataModel.offerPrice!) > 0 && Double(orderDataModel.actualPrice!)  > Double(orderDataModel.offerPrice!)
            {
                self.lblOnLinePayMessage.text = "Online payment 2% Off"
                self.lblOfferPrice.text =  "\(orderDataModel.offerPrice!)"
                
                
                if  let aConstraintY = self.constraintY
                {
                    self.removeConstraint(aConstraintY)
                }
//               topConstraint = NSLayoutConstraint(item:self.lblOnLinePayMessage, attribute: NSLayoutAttribute.Top, relatedBy:.Equal, toItem:self.viewHr1, attribute:.Bottom, multiplier:1.0, constant:2)
//                
//                self.addConstraint(topConstraint!)
                
            }else
            {
                self.lblOnLinePayMessage.text = ""
                self.lblOfferPrice.text =  ""

                if  let aConstraintY = self.constraintY
                {
                    self.removeConstraint(aConstraintY)
                }
                
                constraintY = NSLayoutConstraint(item:self.lblFinalPriceText, attribute: NSLayoutAttribute.CenterY, relatedBy:.Equal, toItem:self.statusLbl, attribute:.CenterY, multiplier:1.0, constant:0)
                
                self.addConstraint(constraintY!)
            }
        }else
        {
            self.lblOnLinePayMessage.text = ""
            self.lblOfferPrice.text =  ""
            
            if  let aConstraintY = self.constraintY
            {
                self.removeConstraint(aConstraintY)
            }
             constraintY = NSLayoutConstraint(item:self.lblFinalPriceText, attribute: NSLayoutAttribute.CenterY, relatedBy:.Equal, toItem:self.statusLbl, attribute:.CenterY, multiplier:1.0, constant:0)
            
            self.addConstraint(constraintY!)
        }
       
        
        self.lblFinalPriceText.text = "Actual Price"
        self.lblFinalPrice.text = "\(orderDataModel.actualPrice!)"
        
        
        if orderDataModel.statusCode == "OREQ" || orderDataModel.statusCode == "OTRNF" || orderDataModel.statusCode == "OVREJ"
        {
            self.lblCallBro4u.text = "Call Bro4u"
            
            self.ViewCallB4u.tag = 1
        }
        
        if orderDataModel.statusCode == "OACC" || orderDataModel.statusCode == "OPRC" || orderDataModel.statusCode == "OACL"
        {
            self.lblCallBro4u.text = "Call Service partner"

            self.ViewCallB4u.tag = 2

        }
        

    }
  
    @IBAction func btnPayOnlineAction(sender: AnyObject) {
    }
    
    @IBAction func btnCallBro4u(sender: AnyObject) {
    }
    
  


}
