//
//  RootTabBarViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/4.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController,UITabBarControllerDelegate,BaseTabBarViewDelegate {
   var markNavgation :UINavigationController!
     var imageView:UIImageView!
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
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 12)], for:UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:navigationColor,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 12)], for: UIControlState.selected)
        
        self.tabBar.tintColor=grayTabbarColor
        //let bgView:UIView=UIView.init(frame: self.tabBar.bounds)
        let bgView:UIView=UIView.init(frame: CGRect(x:0, y: SCREEN_HEIGHT()-HEIGHT_TAB_BAR()-HEIGHT_BOTTOM_MARGIN(), width:SCREEN_WHIDTH() , height:HEIGHT_TAB_BAR()+HEIGHT_BOTTOM_MARGIN() ))
        bgView.backgroundColor=UIColor.white
        self.tabBar.insertSubview(bgView, at: 0)
        self.delegate=self
        self.tabBar.isOpaque=true
        
        self.imageView=UIImageView.init(frame: CGRect(x: 0, y: SCREEN_HEIGHT()-HEIGHT_TAB_BAR()-HEIGHT_BOTTOM_MARGIN(), width: SCREEN_WHIDTH(), height: HEIGHT_TAB_BAR()+HEIGHT_BOTTOM_MARGIN()))

        var height:CGFloat = self.tabBar.bounds.size.height
        self.imageView = BaseTabBarView.share().getBaseTabBarView(self.imageView, andHeight: &height)

        BaseTabBarView.share().delegate = self
        self.tabBar.isHidden = true
        self.view .addSubview(self.imageView)
        self.selectedIndex = 0
        
        
    }
    func getIndex(_ index: Int32) {
        //        if index == 0{
        //            self.imageView.isHidden = true
        //        }else{
        //            self.imageView.isHidden = false
        //        }
        self.selectedIndex = Int(index)
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
