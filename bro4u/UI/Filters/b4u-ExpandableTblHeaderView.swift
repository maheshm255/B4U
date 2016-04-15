//
//  b4u-ExpandableTblHeaderView.swift
//  bro4u
//
//  Created by Tools Team India on 22/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

protocol ExpandableTblHeaderViewDelegate: NSObjectProtocol {
    func headerViewOpen(section:Int)
    func headerViewClose(section:Int)
}

class b4u_ExpandableTblHeaderView: UIView {
    
    var delegate:ExpandableTblHeaderViewDelegate?
    var section:Int?
    var tableView:b4u_ExpandableTableView?
    var arrowImgView:UIImageView?
    var seperatorImgView:UIImageView?
    var toggleButton = UIButton()
    
   internal  var lblTitle:UILabel?
   internal  var lblSelectedItems:UILabel?
    
    required init(tableView:b4u_ExpandableTableView, section:Int){
        
        let height = tableView.delegate?.tableView!(tableView, heightForHeaderInSection: section)
        let frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), height!)
        
        super.init(frame: frame)
        
        
        
        lblTitle = UILabel()
        lblTitle!.frame = CGRectMake(10, 0, CGRectGetWidth(tableView.frame) - 60, height!)
        
        lblTitle!.textAlignment = NSTextAlignment.Left
        lblTitle!.font = UIFont(name: "Helvetica", size: 18)
        lblTitle!.textColor = UIColor(red:45.0/255, green: 45.0/255, blue: 45.0/255, alpha:1.0)
        lblTitle!.backgroundColor = UIColor.clearColor()
        
        self.addSubview(lblTitle!)
        
        
        lblSelectedItems = UILabel()
        lblSelectedItems!.frame = CGRectMake(10, 30, CGRectGetWidth(tableView.frame) - 60, height!)
        
        lblSelectedItems!.textAlignment = NSTextAlignment.Left
        lblSelectedItems!.font = UIFont(name: "Helvetica", size: 14)
        

        lblSelectedItems!.textColor = UIColor(red:119.0/255, green: 119.0/255, blue: 119.0/255, alpha:1.0)

        
        lblSelectedItems!.text = "Selected Items"
        lblSelectedItems!.backgroundColor = UIColor.clearColor()
        
        self.addSubview(lblSelectedItems!)
        
        
        toggleButton.addTarget(self, action: "toggle:", forControlEvents: UIControlEvents.TouchUpInside)
        toggleButton.backgroundColor = UIColor.clearColor()
        toggleButton.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        self.addSubview(toggleButton)
        
        
        self.arrowImgView = UIImageView(frame:CGRectMake(CGRectGetWidth(tableView.frame)-32, height!/2-3.5, 14, 7))
        self.arrowImgView?.image = UIImage(named:"downArrow")
        self.addSubview(self.arrowImgView!)
        
        self.seperatorImgView = UIImageView(frame:CGRectMake(CGRectGetWidth(tableView.frame) - 50, 10, 1, height!-20))
        self.seperatorImgView!.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(self.seperatorImgView!)
        
        self.tableView = tableView
        self.delegate = tableView
        self.section = section
        
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
    func toggle(sender:AnyObject){
        
        if self.tableView!.sectionOpen != section! {
            self.arrowImgView?.image = UIImage(named:"upArrow")
            self.delegate?.headerViewOpen(section!)
        } else if self.tableView!.sectionOpen != NSNotFound {
            self.arrowImgView?.image = UIImage(named:"downArrow")
            self.delegate?.headerViewClose(self.tableView!.sectionOpen)
        }
    }
}
