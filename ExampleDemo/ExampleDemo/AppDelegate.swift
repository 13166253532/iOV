//
//  AppDelegate.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/11/30.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
import SnapKit
import AvoidCrash


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AvoidCrash.becomeEffective()
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidReceiveMessage(notification:)), name: NSNotification.Name(rawValue: AvoidCrashNotification), object: nil)
        HTHttpConfig.sharedInstance().isout = false
        ProjectConfigGroup.initHttpConfig()
        SNHttpBaseCmd.networkTestingActionTRUEBlock {
            
        }
        //exceptionLogWithData()
        gotoTabBar()
        return true
    }
    func networkDidReceiveMessage(notification:NSNotification){
        print(notification.userInfo)
    }
    func exceptionLogWithData() {
        AccountInfo.sharedInstance().setDefaultHandler()
        let str = AccountInfo.sharedInstance().getdataPath()
        let data = NSData.init(contentsOfFile: str)
        if data != nil {
            let crushStr = String.init(data: data as! Data, encoding: String.Encoding.utf8)
            print(crushStr!)
            
        }
        //测试数据
        let arry:NSArray = ["1"]
        print("%@",arry[5])
    }
   
    
    
    func gotuMDFGuideViewController(){
        if (!(UserDefaults.standard.bool(forKey: "everLaunched"))) {
            UserDefaults.standard.set(true, forKey:"everLaunched")
            let guideViewController = MDFGuideViewController()
            self.window!.rootViewController=guideViewController;
            print("guideview launched!")
        }else{
            gotoTabBar()
        }
    }
    func gotoTabBar() {
        let vc:MainViewController=MainViewController.createViewController(createArgs: nil) as! MainViewController
        //let vc:IrregularLabelViewController=IrregularLabelViewController.createViewController(createArgs: nil) as! IrregularLabelViewController
        let nav = UINavigationController.init(rootViewController: vc)
        //let nav = RootTabBarViewController.init()
        self.window?.rootViewController = nav
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

