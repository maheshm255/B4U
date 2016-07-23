//
//  NoNetworkConnectionView.swift
//  bro4u
//
//  Created by shahnawaz on 22/07/2016.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class NoNetworkConnectionView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var objNetworkStatusView : UIView?
    
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = UIColor.blackColor()
        self.alpha = 0.5
        addNoNetworkView()
     }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func addNoNetworkView(){
        
        let dummyLabel = UILabel(frame: CGRectMake(0, 10, self.frame.size.width, 42))
        dummyLabel.text = "No Network, Please check your internet connection!"
        dummyLabel.textAlignment = .Center
        dummyLabel.numberOfLines = 2
        dummyLabel.lineBreakMode = .ByWordWrapping
        
        let okButton = UIButton(type: .System)
        okButton.frame = CGRectMake(75,100, 200, 30)
        okButton.setTitle("Try Again!", forState: .Normal)
        okButton.addTarget(self, action: "handleNoNetworkCase", forControlEvents: .TouchUpInside)
        
        
        objNetworkStatusView = UIView(frame:CGRectMake(0, 400, self.frame.size.width, self.frame.size.height))
        objNetworkStatusView?.backgroundColor = UIColor.lightGrayColor()
        objNetworkStatusView!.tag = 1111
        
        objNetworkStatusView?.addSubview(dummyLabel)
        objNetworkStatusView?.addSubview(okButton)
        self.addSubview(objNetworkStatusView!)
    }
    
    func handleNoNetworkCase(){

        self.removeFromSuperview()
        NSNotificationCenter.defaultCenter().postNotificationName("NoNetworkConnectionNotification", object: nil)
    }

}
