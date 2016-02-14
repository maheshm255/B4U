//
//  b4u-CategoryListTblViewCell.swift
//  bro4u
//
//  Created by Tools Team India on 08/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CategoryListTblViewCell: UITableViewCell {

    @IBOutlet weak var lblCategoryDesc: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellData(dataModel:bro4u_MainCategory)
    {
        lblCategoryName.text = dataModel.manCatName
        lblCategoryDesc.text = dataModel.mainCatDesc
        imgIcon.downloadedFrom(link:dataModel.catIcon!, contentMode:UIViewContentMode.ScaleToFill)
    }

}
