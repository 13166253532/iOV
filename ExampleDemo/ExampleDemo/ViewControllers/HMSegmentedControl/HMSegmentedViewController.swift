//
//  HMSegmentedViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/21.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit
import HMSegmentedControl
enum InvesPageType: Int{
    case PersonPage = 1
    case InstituPage = 2
}
enum SequenPageType: Int{
    case HeatPage = 1
    case TimePage = 2
}
class HMSegmentedViewController: BaseViewController ,UIPageViewControllerDelegate,UIPageViewControllerDataSource{

    //var segment:HMSegmentedControl = HMSegmentedControl()
    var invesPageType:InvesPageType = .PersonPage
    var pages:NSMutableArray!
    var pageViewController:UIPageViewController!
    var currentPage:UInt = 0
    var index = 0
    var arr = NSMutableArray()
    
    var screenVC:OneViewController!
    var timeVC:OneViewController!
    var heatVC:OneViewController!
    var screenDateArray:NSMutableArray!
    var timeDateArray:NSMutableArray!
    var heatDateArray:NSMutableArray!
    var timeHotPage = NSInteger()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "HMSegmentedViewController", bundle: nil)
        let vc:HMSegmentedViewController=storyboard.instantiateViewController(withIdentifier: "HMSegmentedViewController") as! HMSegmentedViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarObstructed()
        self.view .addSubview(segment)
        setPageViewController()
        setPage()
        initPageController()
        setCurrentPage()

    }
    
    lazy var segment:HMSegmentedControl = {
        let segment = HMSegmentedControl.init(frame: CGRect(x:0, y: 0, width:SCREEN_WHIDTH() , height:46 ))
        segment.selectionIndicatorLocation = .none
        segment.selectionStyle = .textWidthStripe
        segment.sectionTitles = ["11111","222222","333333"]
        segment.selectionIndicatorColor = greenNavigationColor
        segment.selectionStyle = .fullWidthStripe
        segment.selectionIndicatorLocation = .down
        segment.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName:grayColor]
        segment.selectedTitleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName:greenNavigationColor]
        segment.selectionIndicatorHeight = 3.0
        segment.type = .text
        segment.indexChangeBlock = {[weak self](index:NSInteger)->() in
            let index = self?.pages.index(of: self?.pageViewController.viewControllers?.last ?? NSInteger())
            let direction:UIPageViewControllerNavigationDirection = segment.selectedSegmentIndex > index! ? .forward:.reverse
            self?.pageViewController.setViewControllers([(self?.selectedController())!], direction: direction, animated: true, completion: nil)
        }
        return segment
    }()
    

    func selectedController() -> UIViewController {
        return self.pages[self.segment.selectedSegmentIndex] as! UIViewController
    }
    
    
    func setCurrentPage(){
        self.segment.setSelectedSegmentIndex(self.currentPage, animated: false)
        let index=self.pages.index(of: (self.pageViewController.viewControllers?.last)!)
        let direction:UIPageViewControllerNavigationDirection = self.segment.selectedSegmentIndex > index ? .forward:.reverse
        self.pageViewController.setViewControllers([self.selectedController()], direction: direction, animated: false, completion: nil)
        
    }
    func setPageViewController(){
        self.pageViewController = UIPageViewController.init(transitionStyle: .scroll,navigationOrientation: .horizontal,options: nil)
        self.pageViewController.view.frame = CGRect(x:0, y: segment.originY+segment.height, width:SCREEN_WHIDTH() , height: SCREEN_HEIGHT()-(segment.originY+segment.height)-2)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.pageViewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addChildViewController(self.pageViewController)
        self.view .addSubview(self.pageViewController.view)
        
    }
    
    func initPageController(){
        if self.pages.count > 0{
            self.pageViewController.setViewControllers([self.pages[0] as! UIViewController ], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.pages.index(of: viewController)
        if index == NSNotFound||index == 0 {
            return nil
        }
        index -= 1
        return self.pages[index] as? UIViewController
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.pages.index(of: viewController)
        if index == NSNotFound||index+1>=self.pages.count {
            self.timeHotPage=index-1
            return nil
        }
        index += 1
        return self.pages[index] as? UIViewController
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            return
        }
        let index:UInt = UInt(self.pages.index(of: (pageViewController.viewControllers?.last)!))
        //if index==2{
            //self.setFilterSelected()
        //}else{
            self.segment.setSelectedSegmentIndex(index, animated: true)
            //self.setFilterUnselect()
        //}
    }
    func setPage(){
        pages = NSMutableArray()
        self.heatVC = self.createHotPageViewControllerWithTitle(title: "11111",sequenPageType: SequenPageType.HeatPage)
        self.timeVC = self.createTimeWithTitle(title: "2222",sequenPageType: SequenPageType.HeatPage)
        self.screenVC = self.createScreenWithTitle(title: "3333",sequenPageType: SequenPageType.HeatPage)
        pages.add(self.heatVC)
        pages.add(self.timeVC)
        pages.add(self.screenVC)
  
    }
    func createHotPageViewControllerWithTitle(title:String,sequenPageType:SequenPageType) -> OneViewController{
        let vc:OneViewController = OneViewController.createViewController(createArgs: nil) as! OneViewController
        vc.view.backgroundColor = UIColor.red
        return vc
    }
    func createTimeWithTitle(title:String,sequenPageType:SequenPageType) -> OneViewController{
        let vc:OneViewController = OneViewController.createViewController(createArgs: nil) as! OneViewController
        vc.view.backgroundColor = UIColor.yellow
        //vc.hidesBottomBarWhenPushed = true
        return vc
    }
    func createScreenWithTitle(title:String,sequenPageType:SequenPageType) -> OneViewController{
        let vc:OneViewController = OneViewController.createViewController(createArgs: nil) as! OneViewController
        vc.view.backgroundColor = UIColor.blue
        //vc.hidesBottomBarWhenPushed = true
        return vc
    }

    
    func gotoFilterPage(){
        self.segment.setSelectedSegmentIndex(0, animated: false)
        let index=self.pages.index(of: (self.pageViewController.viewControllers?.last)!)
        let direction:UIPageViewControllerNavigationDirection = self.segment.selectedSegmentIndex > index ? .forward:.reverse
        
        let vc=self.pages[0] as! UIViewController
        self.pageViewController.setViewControllers([vc], direction: direction, animated: true, completion: nil)
        if index != 2{
            self.timeHotPage = index
        }
        
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
