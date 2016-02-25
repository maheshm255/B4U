//
//  b4u-ServicePatnerController.swift
//  bro4u
//
//  Created by Tools Team India on 25/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ServicePatnerController: UIViewController {

    var selectedCategoryObj:b4u_Category?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.callServicePatnerApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //cat_id=2&latitude=12.9718915&longitude=77.6411545

    
    func callServicePatnerApi()
    {
        if let aSelectedCatObj = selectedCategoryObj
        {
            let catId = aSelectedCatObj.catId!
            let latitude =  "12.9718915"
            let longitude = "77.6411545"
            
            
            let params = "?cat_id=\(catId)&latitude=\(latitude)&longitude=\(longitude)"
            b4u_WebApiCallManager.sharedInstance.getApiCall(kShowServicePatnerApi, params:params, result:{(resultObject) -> Void in
                
                
            })
        }
    }
    
  

}
