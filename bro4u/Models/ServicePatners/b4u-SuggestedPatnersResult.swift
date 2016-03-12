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
    var otherPatners:[b4u_SugestedPartner]?
    
    var nextPage:NSNumber?
    var nextPageSize:NSNumber?
    var pageLoad:String?
    var totalRows:NSNumber?
    
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
        
        let results = sugestedPartnersResultDict["catlog"]!["results"]
        
        self.nextPage = results!!["next_page"] as? NSNumber
        self.nextPageSize = results!!["next_page_size"] as? NSNumber
        self.pageLoad = results!!["page_load"] as? String
        self.totalRows = results!!["total_rows"] as? NSNumber
        
         self.otherPatners = Array()
        
        }
    
    
    func parseMoreResult(partnersResultDict:Dictionary<String ,AnyObject>)
    {
        let results = partnersResultDict["catlog"]!["results"]
        
        self.nextPage = results!!["next_page"] as? NSNumber
        self.nextPageSize = results!!["next_page_size"] as? NSNumber
        self.pageLoad = results!!["page_load"] as? String
        self.totalRows = results!!["total_rows"] as? NSNumber
        
        if let othersPatnerdDataDict = results!!["data"] as? [Dictionary<String ,AnyObject>]
        {
            
            for (_ ,otherPatnersDict) in othersPatnerdDataDict.enumerate()
            {
                let aPatner  = b4u_SugestedPartner(sugestedPartnerDetailsDict: otherPatnersDict)
                
                self.otherPatners?.append(aPatner)
                
            }
        }

    }
}
