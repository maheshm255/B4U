//
//  b4u_BankList.swift
//  bro4u
//
//  Created by Rahul on 06/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_BankDetail: NSObject {
    
    
    var bankName:String?
    var bankCode:String?
    
    
    init(bankDetails:Dictionary<String,String>) {
        
        bankName = bankDetails["bankName"]
        bankCode = bankDetails["bankCode"]
    }


}
