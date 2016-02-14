//
//  b4u-WebApiCallManager.swift
//  bro4u
//
//  Created by Tools Team India on 14/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_WebApiCallManager: NSObject {

    
    //MARK: Self Singleton variable
    /*
    @ This is class variable which creates self Singleton object
    */
    class var sharedInstance: b4u_WebApiCallManager {
        struct Singleton {
            static let instance = b4u_WebApiCallManager()
        }
        return Singleton.instance
    }
    
    
    func getApiCall(apiPath:String ,params:Dictionary<String ,AnyObject> ,result:AnyObject->()){
        
            let requestUrl = b4uBaseUrl + apiPath
            let sessionManager = AFHTTPSessionManager();
        
            let getTokenTask = sessionManager.GET(requestUrl, parameters: params, success: { (dataTask:NSURLSessionDataTask, response:AnyObject) -> Void in
                
                print(response, terminator: "")
                
                result(response)
                
                }) { (dataTask:NSURLSessionDataTask, error:NSError) -> Void in
                    
                    print("Session Error: \(error.description)")
                    
                    result(error)
                    
            }
            getTokenTask?.resume()
            
    }

}
