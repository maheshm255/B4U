//
//  b4u-CategoryTblViewCell.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CategoryTblViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero
    }

}
