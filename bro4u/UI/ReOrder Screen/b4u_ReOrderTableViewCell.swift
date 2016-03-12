//
//  b4u_ReOrderTableViewCell.swift
//  ThanksScreen
//
//  Created by Rahul on 11/03/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

import UIKit

class b4u_ReOrderTableViewCell: UITableViewCell {

   
    @IBOutlet weak var vendorImageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var subTitleLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var orderIDLbl: UILabel!
    @IBOutlet var timeSlotLbl: NSLayoutConstraint!
    @IBOutlet var amountLbl: UILabel!
    
    
    
    @IBAction func viewDetailAction(sender: AnyObject) {
    }
    
    @IBAction func deleteAction(sender: AnyObject) {
    }
    
    @IBAction func reOrderAction(sender: AnyObject) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
