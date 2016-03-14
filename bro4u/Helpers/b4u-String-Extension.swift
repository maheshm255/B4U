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
    
    public var validPhoneNumber:Bool {
        let result = NSTextCheckingResult.phoneNumberCheckingResultWithRange(NSMakeRange(0, self.characters.count), phoneNumber: self)
        return result.resultType == NSTextCheckingType.PhoneNumber
    }
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }}