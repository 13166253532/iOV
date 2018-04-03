//
//  PushFuncViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/4/3.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class PushFuncViewController: BaseViewController {

    //3、在将要 push 的控制器内设置导航控制器的代理为自定义的代理（步骤2的代理类）
    //注意：代理不能为局部变量
    var cnaDelegate = CustomNaviAnimateDelagete()
    
    
    //三、在模态跳转前修改控制器的 transitioningDelegate 代理为自定义的代理
    //注意：代理不能为局部变量
    // 必须保存为实例变量
    var ctDelegate = CustomTransitioningDelegate()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "PushFuncViewController", bundle: nil)
        let vc:PushFuncViewController=storyboard.instantiateViewController(withIdentifier: "PushFuncViewController") as! PushFuncViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = cnaDelegate
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc:GCDFuncViewController=GCDFuncViewController.createViewController(createArgs: nil) as! GCDFuncViewController
        //navigationController?.pushViewController(vc, animated: true)
        vc.transitioningDelegate = ctDelegate
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


