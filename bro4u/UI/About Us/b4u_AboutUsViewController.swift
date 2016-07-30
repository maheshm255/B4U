//
//  b4u_AboutUsViewController.swift
//  bro4u
//
//  Created by Rahul on 15/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_AboutUsViewController: UIViewController {

    @IBOutlet weak var aboutWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//      self.addLoadingIndicator()
//      b4u_Utility.sharedInstance.activityIndicator.startAnimating()
//
//        aboutWebView.loadRequest(NSURLRequest(URL: NSURL(string: kAboutUsUrl)!))
//        MBProgressHUD.showHUDAddedTo(navigationController?.view, animated: true)
//      b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

    }
    
//    func loadAboutUs(){
//        self.addLoadingIndicator()
//        b4u_Utility.sharedInstance.activityIndicator.startAnimating()
//        
//        aboutWebView.loadRequest(NSURLRequest(URL: NSURL(string: kAboutUsUrl)!))
//        MBProgressHUD.showHUDAddedTo(navigationController?.view, animated: true)
//        b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
//
//    }

    //Network Reachable Test
    func loadAboutUs()
    {
        //2. Checking for Network reachability
        
        if(AFNetworkReachabilityManager.sharedManager().reachable){
            
            self.addLoadingIndicator()
            b4u_Utility.sharedInstance.activityIndicator.startAnimating()
            
            aboutWebView.loadRequest(NSURLRequest(URL: NSURL(string: kAboutUsUrl)!))
            MBProgressHUD.showHUDAddedTo(navigationController?.view, animated: true)
            b4u_Utility.sharedInstance.activityIndicator.stopAnimating()
            //5.Remove observer if any remain
            NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
            
        }else{
            //3. First Remove any existing Observer
            //Add Observer for No network Connection
            
            NSNotificationCenter.defaultCenter().removeObserver(self, name: "NoNetworkConnectionNotification", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(b4u_AboutUsViewController.loadAboutUs), name: "NoNetworkConnectionNotification", object: nil)
            
            //4.Adding View for Retry
            let noNetworkView = NoNetworkConnectionView(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.height))
            self.view.addSubview(noNetworkView)
            
            return
        }
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

}


//MARK:- Helper methods

extension b4u_AboutUsViewController {
    
//    @IBAction func cancelButtonClicked(sender: AnyObject) {
//        navigationController?.dismissViewControllerAnimated(true, completion: nil)
//    }
}

//MARK:- UIWebView delegate methods

extension b4u_AboutUsViewController : UIWebViewDelegate {
    
    func webViewDidFinishLoad(webView: UIWebView) {
        MBProgressHUD.hideAllHUDsForView(navigationController?.view, animated: true)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("Failed to load for \(error)")
    }
  
  func addLoadingIndicator () {
    self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
    self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
    b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
  }

}

