//
//  b4u-SuggestedPatnersResult.swift
//  bro4u
//
//  Created by Tools Team India on 27/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_SuggestedPatnersResult: NSObject {

    
    var suggestedPatners:[b4u_SugestedPartner]?
    
    init(sugestedPartnersResultDict:Dictionary<String ,AnyObject>) {
        
        let suggestedPatnersDataDict1 = sugestedPartnersResultDict["catlog"]!["suggested_results"]
        
        if let resutlMetaData = suggestedPatnersDataDict1!!["data"] as? [Dictionary<String ,AnyObject>]
            {
                
                self.suggestedPatners = Array()
                for (_ ,suggestedPartnerDataDict) in resutlMetaData.enumerate()
                {
                    let aPatner  = b4u_SugestedPartner(sugestedPartnerDetailsDict: suggestedPartnerDataDict)
                    
                    self.suggestedPatners?.append(aPatner)
                    
                }
        }
    }
}
