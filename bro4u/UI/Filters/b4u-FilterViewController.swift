//
//  b4u-FilterViewController.swift
//  bro4u
//
//  Created by Tools Team India on 21/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_FilterViewController: UIViewController {

    
    var selectedCategoryObj:b4u_Category?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.callFilterApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func callFilterApi()
    {
        
        if let aSelectedCatObj = selectedCategoryObj
        {
            let catId = aSelectedCatObj.catId!
            let optionId =  aSelectedCatObj.optionId!
            let filedName = aSelectedCatObj.fieldName!
            
            
            let params = "?cat_id=\(catId)&option_id=\(optionId)&field_name=\(filedName)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(filterApi, params:params, result:{(resultObject) -> Void in
                
            })
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
