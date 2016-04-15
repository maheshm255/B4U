//
//  b4u-SearchResultTblCell.swift
//  bro4u
//
//  Created by Tools Team India on 16/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_SearchResultTblCell: UITableViewCell {
    
    @IBOutlet weak var imgViewIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(aSearchResultObj:b4u_SearchResult)
    {
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero

        
       self.lblTitle.text = aSearchResultObj.catName
       
        self.imgViewIcon.downloadedFrom(link:aSearchResultObj.catIcon!, contentMode:UIViewContentMode.ScaleAspectFit)
    }

}
