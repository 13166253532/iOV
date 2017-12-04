//
//  RootTabBarViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/4.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController,UITabBarControllerDelegate {
   var markNavgation :UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        loadNCS()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadNCS(){
        let rootBarViewControllers:NSArray=[self.gainHomePage(),self.gainProject(),self.gainInvestors(),self.gainPark(),gainMine()]
        
        markNavgation = rootBarViewControllers[0] as? UINavigationController
        self.setViewControllers(rootBarViewControllers as? [UIViewController], animated: true)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:grayTabbarColor,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 12)], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:navigationColor,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 12)], for: UIControlState.selected)
        
        self.tabBar.tintColor=grayTabbarColor
        let bgView:UIView=UIView.init(frame: self.tabBar.bounds)
        bgView.backgroundColor=UIColor.white
        self.tabBar.insertSubview(bgView, at: 0)
        self.delegate=self
        self.tabBar.isOpaque=true
    }
    func getNavigationWithVc(vc:UIViewController,title:String,img1:String,selectImg:String)->UINavigationController{
        let nav:UINavigationController=UINavigationController.init(rootViewController: vc)
        var img:UIImage=UIImage(named: img1)!
        img=img.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        var imgSelect:UIImage=UIImage(named: selectImg)!
        imgSelect=imgSelect.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        nav.tabBarItem=UITabBarItem.init(title: title, image: img, selectedImage: imgSelect)
        return nav
    }
    func gainHomePage()->UINavigationController{
        let homevc:HomeViewController=HomeViewController.createViewController(createArgs: nil) as! HomeViewController
        return self.getNavigationWithVc(vc: homevc, title: "首页", img1: "tabbar_home_nor", selectImg:"tabbar_home_select")
    }
    func gainProject()->UINavigationController{
        let vc:ProjectViewController=ProjectViewController.createViewController(createArgs: nil) as! ProjectViewController
        
        return self.getNavigationWithVc(vc: vc, title: "项目", img1: "tabbar_project_nor", selectImg:"tabbar_project_select")
    }
    
    func gainInvestors()->UINavigationController{
        let vc:InvewtorsViewController=InvewtorsViewController.createViewController(createArgs: nil) as! InvewtorsViewController
        
        return self.getNavigationWithVc(vc: vc, title: "投资方", img1: "tabbar_investors_nor", selectImg:"tabbar_investors_select")
    }
    
    func gainPark()->UINavigationController{
        let vc:ParkViewController=ParkViewController.createViewController(createArgs: nil) as! ParkViewController
        
        return self.getNavigationWithVc(vc: vc, title: "园区", img1: "tabbar_park_nor", selectImg:"tabbar_park_select")
    }
    func gainMine()->UINavigationController{
        let vc:MainViewController=MainViewController.createViewController(createArgs:nil) as! MainViewController
        
        return self.getNavigationWithVc(vc: vc, title: "我的", img1: "tabbar_mine_nor", selectImg:"tabbar_mine_select")
        
    }
}
