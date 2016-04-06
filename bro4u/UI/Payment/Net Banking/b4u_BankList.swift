//
//  b4u_BankList.swift
//  bro4u
//
//  Created by Rahul on 06/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_BankList: NSObject {
    
    
    var bankList:[String]?
    
    
    init(bankListArray:[String]) {
        
        bankList = Array()
        
        for (_,value) in bankListArray.enumerate()
        {
            bankList?.append(value)
        }
    }


}
