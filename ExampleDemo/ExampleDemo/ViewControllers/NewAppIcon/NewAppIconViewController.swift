//
//  NewAppIconViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/19.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class NewAppIconViewController: BaseViewController {

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "NewAppIconViewController", bundle: nil)
        let vc:NewAppIconViewController=storyboard.instantiateViewController(withIdentifier: "NewAppIconViewController") as! NewAppIconViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.changeIcon(iconName: "newIcon")
    }
    func changeIcon(iconName : String) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons { //来判断是否支持换应用图标
                //setAlertnateIconName方法有二个参数
                //第一个参数是要换图标的名字(此名字不是图片的原始名字)，如果写nil，系统默认是最初图标名字
                //第二个参数是方法执行的回调
                UIApplication.shared.setAlternateIconName(iconName, completionHandler: { (error) in
                    if (error != nil) {
                        print(error ?? "失败")
                    } else {
                        print("成功")
                    }
                })
            }
        } else {
            // Fallback on earlier versions
        }
    }


}
