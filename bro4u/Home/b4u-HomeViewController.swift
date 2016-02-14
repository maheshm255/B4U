//
//  b4u-HomeViewController.swift
//  bro4u
//
//  Created by Tools Team India on 09/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_HomeViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.revealViewController().rearViewRevealWidth = 108
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.createImagSlideShowUI()
        bro4u_DataManager.sharedInstance.readLocalFile("category")
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

    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bro4u_DataManager.sharedInstance.mainCategories.count
    }

    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! b4u_CategoryListTblViewCell
        
        cell.configureCellData(bro4u_DataManager.sharedInstance.mainCategories[indexPath.row])
        return cell

    }
    
     internal func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1
    }
     internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60.0
    }


    func createImagSlideShowUI()
    {
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        
        let imgOne = UIImageView(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
        imgOne.downloadedFrom(link:"https://bro4u.com/images/mobile_banner/Laundry1.jpg", contentMode:UIViewContentMode.ScaleAspectFit)
        imgOne.contentMode = UIViewContentMode.ScaleAspectFit
        let imgTwo = UIImageView(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
        imgTwo.image = UIImage(named: "Slide 2")
        imgTwo.contentMode = UIViewContentMode.ScaleAspectFit
        
        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
        imgThree.image = UIImage(named: "Slide 3")
        imgThree.contentMode = UIViewContentMode.ScaleAspectFit
        
        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
        imgFour.image = UIImage(named: "Slide 4")
        imgFour.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        //4
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 4, self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = 4
        
        
        self.scrollView.scrollEnabled = false
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target:self, action:"leftSwipe")
        leftSwipeGesture.delaysTouchesBegan  = true
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.Left
        self.scrollView.addGestureRecognizer(leftSwipeGesture)
        
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target:self, action:"rightSwipe")
        rightSwipeGesture.delaysTouchesBegan  = true
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.scrollView.addGestureRecognizer(rightSwipeGesture)
    }
    
    
    
    func leftSwipe()
    {
        self.moveToNextPage()
    }
    
    func rightSwipe()
    {
        self.moveToPrevousPage()
        
    }
    func moveToNextPage (){
        
        // Move to next page
        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
            // Each time you move back to the first slide, you may want to hide the button, uncomment the animation below to do so
            //            UIView.animateWithDuration(0.5, animations: { () -> Void in
            //                self.startButton.alpha = 0.0
            //            })
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
    }
    
    
    func moveToPrevousPage(){
        
        
        // Move to next page
        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
      //  let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset - pageWidth
        
        if  contentOffset - pageWidth == 0{
            slideToX = 0
            // Each time you move back to the first slide, you may want to hide the button, uncomment the animation below to do so
            //            UIView.animateWithDuration(0.5, animations: { () -> Void in
            //                self.startButton.alpha = 0.0
            //            })
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
        
    }
   
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView){
        
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
    }

}
