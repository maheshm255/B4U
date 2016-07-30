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
        self.backgroundColor = UIColor.grayColor()
        self.alpha = 0.7
        addNoNetworkView()
     }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func addNoNetworkView(){
        
        let dummyLabel = UILabel(frame: CGRectMake(8, 5, self.frame.size.width/2, 40))
        dummyLabel.text = "No Connection"
        dummyLabel.textColor = UIColor.whiteColor()
//        dummyLabel.textAlignment = .Center
//        dummyLabel.numberOfLines = 2
        dummyLabel.lineBreakMode = .ByWordWrapping
        
        let okButton = UIButton(type: .System)
        okButton.frame = CGRectMake(self.frame.size.width/2+5,5, self.frame.size.width/2, 40)
        okButton.setTitle("RETRY", forState: .Normal)
        okButton.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        okButton.addTarget(self, action: "handleNoNetworkCase", forControlEvents: .TouchUpInside)
        
        
        objNetworkStatusView = UIView(frame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 50))
        objNetworkStatusView?.backgroundColor = UIColor.blackColor()
        objNetworkStatusView?.alpha = 1.0
//        objNetworkStatusView?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 128.0, alpha: 1.0)
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
