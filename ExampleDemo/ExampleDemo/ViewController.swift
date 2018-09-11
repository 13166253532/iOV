//
//  ViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/11/30.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
import AvoidCrash
enum DataType: Int{   //区分搜索界面历史记录
    case ProjectData = 1        //项目
    case InvestorsData = 2      //个人投资
    case ParkData = 3           //园区
    case InvestorAgencyData = 4 //投资机构
}
class ViewController: UIViewController {
    var dataType:DataType = .ParkData
    var array:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AvoidCrash.becomeEffective()
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidReceiveMessage(notification:)), name: NSNotification.Name(rawValue: AvoidCrashNotification), object: nil)
        //array.add(1)
        
//        do {
//            let input = "My name is Taylor Swift"
//            let regex = try NSRegularExpression(pattern: "My name is (.*)", options: NSRegularExpression.Options.caseInsensitive)
//            let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
//
//            if let match = matches.first {
//                let range = match.rangeAt(1)
//                if let swiftRange = Range(range, in: input) {
//                    let name = input[swiftRange]
//                    print(name)
//                }
//            }
//        } catch {
//
//        }
    
        
        
    }
   
  
    func networkDidReceiveMessage(notification:NSNotification){
        print(notification.userInfo)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
