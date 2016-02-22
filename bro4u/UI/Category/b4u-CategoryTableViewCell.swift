//
//  b4u-CategoryTableViewCell.swift
//  bro4u
//
//  Created by Tools Team India on 19/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(attributeOptions:b4u_AttributeOptions)
    {
        lblCategoryName.text = attributeOptions.fieldName
//        imgIcon.downloadedFrom(link:categoryObject.catIcon!, contentMode:UIViewContentMode.ScaleAspectFill)
    }
    
    func configureData1(categoryObject:b4u_Category)
    {
        lblCategoryName.text = categoryObject.catName
        imgIcon.downloadedFrom(link:categoryObject.catIcon!, contentMode:UIViewContentMode.ScaleAspectFill)
    }

}
