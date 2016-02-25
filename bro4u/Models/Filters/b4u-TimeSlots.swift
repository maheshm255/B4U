//
//  b4u-TimeSlots.swift
//  bro4u
//
//  Created by Tools Team India on 24/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_TimeSlots: NSObject {

    var timeSlots:[String]?
    
    
    init(timeSlotArray:[String]) {
        
        timeSlots = Array()
        
        for (_,value) in timeSlotArray.enumerate()
        {
            timeSlots?.append(value)
        }
    }

}
