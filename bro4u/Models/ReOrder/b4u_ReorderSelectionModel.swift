//
//  b4u_ReorderSelectionModel.swift
//  bro4u
//
//  Created by Rahul on 12/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ReorderSelectionModel: NSObject {

    
    var homeFormat:String?
    
    
    init(dataDict:Dictionary<String ,AnyObject>) {
        
        homeFormat = dataDict["home_format"] as? String
    }

}
