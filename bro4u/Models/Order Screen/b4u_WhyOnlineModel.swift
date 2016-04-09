//
//  b4u_WhyOnlineModel.swift
//  bro4u
//
//  Created by Rahul on 09/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_WhyOnlineModel: NSObject {
    
    var text1:String?
    var text2:String?
    var text3:String?

    
    init(dataDict:Dictionary<String ,AnyObject>) {
        
        text1 = dataDict["text_1"] as? String
        text2 = dataDict["text_2"] as? String
        text3 = dataDict["text_3"] as? String
    }
    
    
}
