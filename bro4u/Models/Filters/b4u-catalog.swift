//
//  b4u-catalog.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_catalog: NSObject {

    
    var filterAttributes:[b4u_CatFilterAttributes]?
    var pricingAttributes:[b4u_CatFilterAttributes]?
    var variantAttributes:[b4u_CatFilterAttributes]?

    init(catLogDataDict:Dictionary<String ,AnyObject>)
    {
        
        self.filterAttributes = Array()
        self.pricingAttributes = Array()
        self.variantAttributes = Array()
        
        let filterAttributes = catLogDataDict["catalog"]!["filter_attributes"]
        let filteredAttributesArray = filterAttributes as! [Dictionary<String , AnyObject>]
        

        for (_, dataDict) in filteredAttributesArray.enumerate()
        {
            let catFilterAttributesObj = b4u_CatFilterAttributes(catFilterAttribuesDataDict:dataDict)
            self.filterAttributes?.append(catFilterAttributesObj)
        }
        
        let pricingAttributes = catLogDataDict["catalog"]!["pricing_attributes"]
        let pricingAttributesArray = pricingAttributes as! [Dictionary<String , AnyObject>]
        
        for (_, dataDict) in pricingAttributesArray.enumerate()
        {
            let catFilterAttributesObj = b4u_CatFilterAttributes(catFilterAttribuesDataDict:dataDict)
            self.pricingAttributes?.append(catFilterAttributesObj)
        }
        
        
        let varientAttributes = catLogDataDict["catalog"]!["variant_attributes"]
        let varientAttributesArray = varientAttributes as! [Dictionary<String , AnyObject>]
        
        for (_, dataDict) in varientAttributesArray.enumerate()
        {
            let catFilterAttributesObj = b4u_CatFilterAttributes(catFilterAttribuesDataDict:dataDict)
            self.variantAttributes?.append(catFilterAttributesObj)
        }
    }
}
