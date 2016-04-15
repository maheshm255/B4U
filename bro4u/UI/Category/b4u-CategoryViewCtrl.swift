//
//  b4u-CategoryViewCtrl.swift
//  bro4u
//
//  Created by Tools Team India on 19/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_CategoryViewCtrl: UIViewController,UIGestureRecognizerDelegate,UIScrollViewDelegate ,categroyTblDelegate{

    
    @IBOutlet weak var imgViewIconTop: UIImageView!
    @IBOutlet weak var imgViewIconBottom: UIImageView!
    @IBOutlet weak var catHorizontalScrollView: UIScrollView!
    @IBOutlet weak var catTblsScrollView: UIScrollView!
    
 //   private var controllers:[b4u_CategoryTblViewCtrl] = Array()
    
    private var controllers:[b4u_CategoryTblViewCtrl1] = Array()

    private var lastViewConstraint:NSArray?
    private var titles:[NSString] = Array()
    private var labels:[UILabel] = Array()
    private var colors:[UIColor] = Array()
    
    
    var selectedMainCategory:bro4u_MainCategory?
    var selectedCategory:b4u_Category?
    var attributeOptions:b4u_AttributeOptions?
    
    var currentColor:UIColor!
    
    //   var categoryScrollView:UIScrollView!
    
    var selectedIndex:Int?
    
    var indicatorcolor:UIView!
    
    var lastOffset:CGFloat!
    
    var currentPage:Int{// The index of the current page (readonly)
        
        get{
            if let aSelectedIndex = self.selectedIndex
            {
                return aSelectedIndex
            }else
            {
                let page = Int((self.catTblsScrollView.contentOffset.x / view.bounds.size.width))
                return page
            }
          
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // selectedIndex = 0
        
        self.addLoadingIndicator()

        self.getCategoryData()
      

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getCategoryData()
    {
        b4u_Utility.sharedInstance.activityIndicator.startAnimating()

        b4u_WebApiCallManager.sharedInstance.getApiCall(kCategoryAndSubOptions, params:"", result:{(resultObject) -> Void in
            
            print("Category Data Received")
            
            print(resultObject)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                b4u_Utility.sharedInstance.activityIndicator.stopAnimating()

                self.congigureUI()

            })
            
            
        })
    }

    func congigureUI()
    {
        
        indicatorcolor=UIView();

       for (_ , mainCategoryData) in bro4u_DataManager.sharedInstance.mainCategories.enumerate()
        {
            
            
            if let filteredCategoryData = self.filterContent(mainCategoryData)
            {
//                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("b4uCategoryTableView") as! b4u_CategoryTblViewCtrl
                
        let vc =  self.storyboard?.instantiateViewControllerWithIdentifier("b4uCategoryTableViewCtrl") as! b4u_CategoryTblViewCtrl1
                
                vc.delegate = self
                
                vc.categoryAndSubOptions = filteredCategoryData
                self.createTableViewScroll(vc, title:mainCategoryData.manCatName!, color:UIColor.grayColor())
            }
        }
        
        self.catTblsScrollView.pagingEnabled = true
        self.catTblsScrollView.scrollEnabled=true
        self.catTblsScrollView.delegate = self
        self.createHorizontalScroller()
        
        
        if let selectedCategory = self.selectedMainCategory
        {
            self.imgViewIconBottom.downloadedFrom(link:(selectedCategory.interBanner)!, contentMode:UIViewContentMode.ScaleToFill)
            
            
            self.imgViewIconTop.downloadedFrom(link:(selectedCategory.catIcon)!, contentMode:UIViewContentMode.ScaleAspectFit)
        }
     
        
        if let selectedIndex = self.selectedIndex
        {
            UIView.animateWithDuration(0.5, delay: 0.4,
                options: .Repeat, animations: {
                    
                    self.updateUI()
                    self.scrollToPage(self.catTblsScrollView, page:selectedIndex, animated:true)
                    
                }, completion: nil)
            
        }
        
    }
    
     func scrollToPage(scrollView: UIScrollView, page: Int, animated: Bool) {
        var frame: CGRect = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page);
        scrollView.scrollRectToVisible(frame, animated: animated)
        
        scrollView.setContentOffset(CGPointMake(frame.origin.x, 0), animated:true)
        
        selectedIndex = nil
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "interMediateSegue1"
        {
            let intermediateCtrl =  segue.destinationViewController as! b4u_IntermediateViewCtrl
            
            intermediateCtrl.selectedCategoryObj =  self.selectedCategory
            intermediateCtrl.selectedAttributeOption = self.attributeOptions
        }
    }
    

    
    func createTableViewScroll(vc:b4u_CategoryTblViewCtrl1 , title:NSString , color:UIColor)
    {
        
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        controllers.append(vc)
        titles.append(title)
        colors.append(color)
        
        self.catTblsScrollView.addSubview(vc.view)
        let metricDict = ["w":vc.view.bounds.size.width,"h":self.catTblsScrollView.frame.size.height]
        
        // - Generic cnst
        
        
        
        vc.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(h)]", options:[], metrics: metricDict, views: ["view":vc.view]))
        vc.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:[], metrics: metricDict, views: ["view":vc.view]))
        self.catTblsScrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]|", options:[], metrics: nil, views: ["view":vc.view]))
        
        // cnst for position: 1st element
        
        if controllers.count == 1{
            self.catTblsScrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]", options:[], metrics: nil, views: ["view":vc.view]))
            
            // cnst for position: other elements
            
        }else{
            
            let previousVC = controllers[controllers.count-2]
            let previousView = previousVC.view;
            
            self.catTblsScrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[previousView]-0-[view]", options:[], metrics: nil, views: ["previousView":previousView,"view":vc.view]))
            
            if let cst = lastViewConstraint{
                self.catTblsScrollView.removeConstraints(cst as! [NSLayoutConstraint])
            }
            lastViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:[view]-0-|", options:[], metrics: nil, views: ["view":vc.view])
            self.catTblsScrollView.addConstraints(lastViewConstraint! as! [NSLayoutConstraint])
            
        }
        
    }
    
    
    
    func createHorizontalScroller()
    {
        
        var x , y ,buffer:CGFloat
        
        
        //  categoryScrollView=UIScrollView();
        //  categoryScrollView.frame=CGRectMake(0, self.subCategoryScrollView.frame.origin.y - 64, self.view.frame.width, 64)
        
        // self.view.insertSubview(categoryScrollView, aboveSubview:self.subCategoryScrollView);
        
        x=0;y=0;buffer=10
        
        
        for var i=0; i < titles.count; i++ {
            
            var titleLabel:UILabel!
            var bottomView:UIView!
            titleLabel=UILabel();
            
            
            //Label
            titleLabel.font=UIFont(name: "Roboto-Medium", size: 14)
            titleLabel.text=titles[i].uppercaseString as String
            titleLabel.userInteractionEnabled=true
            let lblWidth:CGFloat
            lblWidth = titleLabel.intrinsicContentSize().width + 32
            
            titleLabel.frame=CGRectMake(x, 16, lblWidth, 34)
            titleLabel.textAlignment=NSTextAlignment.Center
            titleLabel.tag=i+1
            titleLabel.textColor=UIColor.whiteColor()
            
            //Bottom
            bottomView=UIView()
            bottomView.backgroundColor=UIColor.blueColor()
            
            
            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            tap.delegate = self
            titleLabel.addGestureRecognizer(tap)
            
            
            catHorizontalScrollView.addSubview(titleLabel)
            labels.append(titleLabel)
            
            x+=lblWidth+buffer
        }
        catHorizontalScrollView.showsHorizontalScrollIndicator=false;
        catHorizontalScrollView.backgroundColor=UIColor.clearColor();
        catHorizontalScrollView.contentSize=CGSizeMake(x,64)
        // categoryScrollView.contentInset = UIEdgeInsetsMake(0, self.view.center.x-25, 0, 0.0);
        //categoryScrollView.contentOffset=CGPointMake(-(self.view.center.x-50), y)
        //        categoryScrollView.delegate = self
        catHorizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        if(titles.count != 0){
            indicatorcolor.frame=CGRectMake(labels[0].frame.origin.x, 55, labels[0].intrinsicContentSize().width+32, 3)
            indicatorcolor.backgroundColor = UIColor(red:0.0/255, green:162.0/255, blue:221.0/255, alpha:1.0)
            catHorizontalScrollView.addSubview(indicatorcolor)
        }
        
        self.view.bringSubviewToFront(catHorizontalScrollView)
        
    }
    
    
    // MARK: - Tap Gesture
    
    
    func handleTap(sender:UIGestureRecognizer){
        
        self.catTblsScrollView.scrollRectToVisible(controllers[sender.view!.tag-1].view.frame, animated: true)
        currentColor = self.colors[self.currentPage]
        
        // Notify delegate about the new page
        self.selectedMainCategory =  bro4u_DataManager.sharedInstance.mainCategories[self.currentPage]
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.indicatorcolor.frame=CGRectMake(self.labels[sender.view!.tag-1].frame.origin.x, 55, self.labels[sender.view!.tag-1].intrinsicContentSize().width+32, 3)
          //  self.indicatorcolor.backgroundColor
            //                self.categoryScrollView.scrollRectToVisible(self.labels[sender.view!.tag-1].frame, animated: true)
            
            //Center Content
            //            self.catHorizontalScrollView.setContentOffset(CGPointMake(-(self.view.center.x-50)+self.labels[sender.view!.tag-1].center.x-self.labels[sender.view!.tag-1].frame.size.width/2, 0), animated: true)
            
            
            print("%@",self.controllers[sender.view!.tag-1].view.frame)
            print("%@",self.catHorizontalScrollView.frame)
            
//            self.controllers[sender.view!.tag-1].view.frame.origin.x + self.catHorizontalScrollView.frame.size.width/2
            
//            self.catHorizontalScrollView.setContentOffset(CGPointMake(self.controllers[sender.view!.tag-1].view.frame.origin.x - self.controllers[sender.view!.tag-1].view.frame.size.width/2 , 0), animated: true)
            
            
            self.catHorizontalScrollView.setContentOffset(CGPointMake(-(self.view.center.x-100)+self.labels[sender.view!.tag-1].center.x-self.labels[sender.view!.tag-1].frame.size.width/2, 0), animated: true)
            
    
           // self.imgViewIconBottom.backgroundColor =  self.currentColor
            
            self.imgViewIconBottom.downloadedFrom(link:(self.selectedMainCategory?.interBanner)!, contentMode:UIViewContentMode.ScaleToFill)
            self.imgViewIconTop.downloadedFrom(link:(self.selectedMainCategory?.catIcon)!, contentMode:UIViewContentMode.ScaleAspectFit)
          
            
            self.updateLabelColor(self.currentPage)

        })
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updateUI()
    }
    
    
    
    /**
     Update the UI to reflect the current walkthrough situation
     **/
    
    private func updateUI(){
        
        self.currentColor = self.colors[self.currentPage]
        
        self.selectedMainCategory =  bro4u_DataManager.sharedInstance.mainCategories[self.currentPage]
//        UIView.animateWithDuration(0.2, animations: { () -> Void in
//            self.indicatorcolor.frame=CGRectMake(self.labels[self.currentPage].frame.origin.x, 55, self.labels[self.currentPage].intrinsicContentSize().width+32, 3)
//          //  self.indicatorcolor.backgroundColor= UIColor.blueColor()
//            
//            //Center Content
//            self.catHorizontalScrollView.setContentOffset(CGPointMake(-(self.view.center.x-100)+self.labels[self.currentPage].center.x-self.labels[self.currentPage].frame.size.width/2, 0), animated: true)
//            
//            self.imgViewIconBottom.downloadedFrom(link:(self.selectedMainCategory?.interBanner)!, contentMode:UIViewContentMode.ScaleToFill)
//            self.imgViewIconTop.downloadedFrom(link:(self.selectedMainCategory?.catIcon)!, contentMode:UIViewContentMode.ScaleAspectFit)
//            
//            
//
//        })
        
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.indicatorcolor.frame=CGRectMake(self.labels[self.currentPage].frame.origin.x, 55, self.labels[self.currentPage].intrinsicContentSize().width+32, 3)
            //  self.indicatorcolor.backgroundColor= UIColor.blueColor()
            
            //Center Content
            self.catHorizontalScrollView.setContentOffset(CGPointMake(-(self.view.center.x-100)+self.labels[self.currentPage].center.x-self.labels[self.currentPage].frame.size.width/2, 0), animated: true)
            
            self.imgViewIconBottom.downloadedFrom(link:(self.selectedMainCategory?.interBanner)!, contentMode:UIViewContentMode.ScaleToFill)
            self.imgViewIconTop.downloadedFrom(link:(self.selectedMainCategory?.catIcon)!, contentMode:UIViewContentMode.ScaleAspectFit)
            
            }) {(value: Bool) -> Void in
        
                
                self.updateLabelColor(self.currentPage)
        }
        
   
        
    }
    
    
    func updateLabelColor(currentPage:Int)
    {
        for (index ,  lable) in self.labels.enumerate()
        {
            if currentPage == index
            {
                lable.textColor = UIColor.whiteColor()
 
            }else
            {
                lable.textColor = UIColor(red:242.0/255, green:232.0/255, blue:170.0/255, alpha:1.0)
            }
            
            //242 ,232,170
        }
    }
    private func filterContent(mainCategroyModelObj:bro4u_MainCategory) -> [b4u_Category]?
    {
        let filteredItems:[b4u_Category]?
        if bro4u_DataManager.sharedInstance.categoryAndSubOptions.count > 0
        {
           filteredItems =    bro4u_DataManager.sharedInstance.categoryAndSubOptions.filter({m in
                
                if let mainCatId  = m.mainCatId
                {
                    return mainCategroyModelObj.manCatId ==  mainCatId
                }else
                {
                    return false
                }
                
            })
            return filteredItems

        }else
        {
            return nil
        }
        
        
    }
    
    func addLoadingIndicator () {
        self.view.addSubview(b4u_Utility.sharedInstance.activityIndicator)
        self.view.bringSubviewToFront(b4u_Utility.sharedInstance.activityIndicator)
        b4u_Utility.sharedInstance.activityIndicator.center = self.view.center
    }
    
    
    func didSelecteCategory(selectedCategory:b4u_Category , attributeOptions:b4u_AttributeOptions?)
    {
        
        self.selectedCategory = selectedCategory
        self.attributeOptions = attributeOptions
        self.performSegueWithIdentifier("interMediateSegue1", sender:nil)
    }

    
}
