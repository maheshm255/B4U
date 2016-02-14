//
//  UIStringExtension.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//
import UIKit


extension String {
    var length: Int { return self.characters.count
    }
    
    func subString(startIndex: Int, length: Int) -> String
    {
        let start = self.startIndex.advancedBy(startIndex)
        let end = self.startIndex.advancedBy(startIndex + length)
        return self.substringWithRange(Range<String.Index>(start: start, end: end))
    }// Swift 1.2
        
     func contains(find: String) -> Bool
     {
           let stringMatch  = self.rangeOfString(find)
           let stringUpperCaseMatch  = self.uppercaseString.rangeOfString(find.uppercaseString)
           let stringLowerCaseMatch  = self.lowercaseString.rangeOfString(find.lowercaseString)
           return  (stringMatch != nil || (stringUpperCaseMatch != nil) || stringLowerCaseMatch != nil)
      }
    
    func replaceAll(find:String, with:String) -> String {
        return stringByReplacingOccurrencesOfString(find, withString: with, options: .CaseInsensitiveSearch, range: nil)
    }
}