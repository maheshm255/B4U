//
//  b4u-CategoryHeaderView.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

protocol categoryHeaderViewDelegate: NSObjectProtocol {
    func headerViewOpen(section:Int)
    func headerViewClose(section:Int)
}

class b4u_CategoryHeaderView: UIView {
    
    var delegate:categoryHeaderViewDelegate?
    var section:Int?
    var tableView:b4u_CateforyTblView?
    var arrowImgView:UIImageView?
    

    
    var seperatorImgView:UIImageView?
    var toggleButton = UIButton()
    required init(tableView:b4u_CateforyTblView, section:Int){
        
        let height = tableView.delegate?.tableView!(tableView, heightForHeaderInSection: section)
        let frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), height!)
        
        super.init(frame: frame)
        
        toggleButton.addTarget(self, action: "toggle:", forControlEvents: UIControlEvents.TouchUpInside)
        toggleButton.backgroundColor = UIColor.clearColor()
        toggleButton.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        self.addSubview(toggleButton)
        
        
        self.arrowImgView = UIImageView(frame:CGRectMake(CGRectGetWidth(tableView.frame)-32, height!/2-3.5, 14, 7))
        self.arrowImgView?.image = UIImage(named:"downArrow")
        self.addSubview(self.arrowImgView!)
        
        self.seperatorImgView = UIImageView(frame:CGRectMake(CGRectGetWidth(tableView.frame) - 50, 4, 1, height!-8))
        self.seperatorImgView!.backgroundColor = UIColor.lightGrayColor()
     //   self.addSubview(self.seperatorImgView!)
        
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
