//
//  b4u-HomeViewController.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//
import UIKit

class b4u_HomeViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var BtnRightMenu: UIBarButtonItem!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var tableViewCategory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
            BtnRightMenu.target = self.revealViewController()
            BtnRightMenu.action = "rightRevealToggle:"
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.revealViewController().rearViewRevealWidth = 108
        
        self.revealViewController().rightViewRevealWidth = 170

        
       self.getData()
      //  bro4u_DataManager.sharedInstance.readLocalFile("category")
        
        // latitude=12.9718915  ,  longitude=77.6411545  , search_keyword=ve

//        var latt =  12.9718915
//        var long = 77.6411545
//        var searchStr = "plumber"
//
//        
//        let params = "?latitude=\(latt)&longitude=\(long)&search_keyword=\(searchStr)"
//        b4u_WebApiCallManager.sharedInstance.getApiCall(kSearchApi, params:params, result:{(resultObject) -> Void in
//            
//            print("Category Data Received")
//            
//            print(resultObject)
//            self.createImagSlideShowUI()
//            
//            self.tableViewCategory.reloadData()
//            
//        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getData()
    {
        b4u_WebApiCallManager.sharedInstance.getApiCall(kHomeSCategory, params:"", result:{(resultObject) -> Void in
            
            print("Category Data Received")
            
            print(resultObject)
            self.createImagSlideShowUI()

            self.tableViewCategory.reloadData()
            
        })
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
        
    
        
        for (index ,sliderImageInfoObj)in bro4u_DataManager.sharedInstance.sliderImages.enumerate()
        {
            let sliderImg = UIImageView(frame: CGRectMake(scrollViewWidth*CGFloat(index), 0,scrollViewWidth, scrollViewHeight))
            sliderImg.downloadedFrom(link:sliderImageInfoObj.imageName!, contentMode:UIViewContentMode.ScaleAspectFit)
            self.scrollView.addSubview(sliderImg)

        }
//        let imgOne = UIImageView(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
//        imgOne.downloadedFrom(link:"https://bro4u.com/images/mobile_banner/Laundry1.jpg", contentMode:UIViewContentMode.ScaleAspectFit)
//        imgOne.contentMode = UIViewContentMode.ScaleAspectFit
//        
//        let imgTwo = UIImageView(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
//        imgTwo.image = UIImage(named: "Slide 2")
//        imgTwo.contentMode = UIViewContentMode.ScaleAspectFit
//        
//        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
//        imgThree.image = UIImage(named: "Slide 3")
//        imgThree.contentMode = UIViewContentMode.ScaleAspectFit
//        
//        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
//        imgFour.image = UIImage(named: "Slide 4"
//        imgFour.contentMode = UIViewContentMode.ScaleAspectFit
//        
//        
//        self.scrollView.addSubview(imgOne)
//        self.scrollView.addSubview(imgTwo)
//        self.scrollView.addSubview(imgThree)
//        self.scrollView.addSubview(imgFour)
        //4
        
        let totalImage = bro4u_DataManager.sharedInstance.sliderImages.count
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * CGFloat(totalImage), self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = totalImage
        
        self.scrollView.delaysContentTouches = true
        self.scrollView.scrollEnabled = false
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target:self, action:"leftSwipe")
        leftSwipeGesture.delaysTouchesBegan  = true
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.Left
        self.scrollView.addGestureRecognizer(leftSwipeGesture)
        leftSwipeGesture.cancelsTouchesInView = false
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target:self, action:"rightSwipe")
        rightSwipeGesture.delaysTouchesBegan  = true
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.scrollView.addGestureRecognizer(rightSwipeGesture)
        rightSwipeGesture.cancelsTouchesInView = false
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
