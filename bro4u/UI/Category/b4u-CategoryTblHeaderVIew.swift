//
//  b4u-CategoryTblHeaderVIew.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: NSObjectProtocol {
    func headerViewOpen(section:Int)
    func headerViewClose(section:Int)
}

class b4u_CategoryTblHeaderVIew: UIView {

    var delegate:HeaderViewDelegate?
    var section:Int?
    var tableViewCtrl:b4u_CategoryTblViewCtrl?
    var tableView:UITableView?

    required init(tableViewCtrl:b4u_CategoryTblViewCtrl, section:Int , categoryObj:b4u_Category){
        
        tableView = tableViewCtrl.tableView
        let height = tableView!.delegate?.tableView!(tableView!, heightForHeaderInSection: section)
        let frame = CGRectMake(0, 0, CGRectGetWidth(tableView!.frame), height!)
         super.init(frame: frame)
  
        let toggleButton = UIButton()
        toggleButton.addTarget(self, action: "toggle:", forControlEvents: UIControlEvents.TouchUpInside)
        toggleButton.backgroundColor = UIColor.clearColor()
        toggleButton.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        self.addSubview(toggleButton)
        
        
        let iconImgView = UIImageView(frame:CGRectMake(5, 5, 40, 40))
        iconImgView.downloadedFrom(link:categoryObj.catIcon!, contentMode:UIViewContentMode.ScaleToFill)
        
        self.addSubview(iconImgView)

        let lblTitle = UILabel(frame:CGRectMake(CGRectGetMaxX(iconImgView.frame)+10, 5, self.frame.width-60, 40))
        lblTitle.text = categoryObj.catName
        
        self.addSubview(lblTitle)
        
        
        self.tableViewCtrl = tableViewCtrl
        self.delegate = tableViewCtrl
        self.section = section
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
 
    }
    
    func toggle(sender:AnyObject){
        print("clicked on toogle button")
        
        if self.tableViewCtrl!.sectionOpen != section! {
            self.delegate?.headerViewOpen(section!)
        } else if self.tableViewCtrl!.sectionOpen != NSNotFound {
            self.delegate?.headerViewClose(self.tableViewCtrl!.sectionOpen)
        }
    }
}
