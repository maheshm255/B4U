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
      self.addLoadingIndicator()
      b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        aboutWebView.loadRequest(NSURLRequest(URL: NSURL(string: kAboutUsUrl)!))
        MBProgressHUD.showHUDAddedTo(navigationController?.view, animated: true)
      b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

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

