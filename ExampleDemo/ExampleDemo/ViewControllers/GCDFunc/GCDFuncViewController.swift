//
//  GCDFuncViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/19.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class GCDFuncViewController: BaseViewController {

    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "GCDFuncViewController", bundle: nil)
        let vc:GCDFuncViewController=storyboard.instantiateViewController(withIdentifier: "GCDFuncViewController") as! GCDFuncViewController
        vc.createArgs=createArgs
        return vc
    }
    
    //http://blog.csdn.net/hbblzjy/article/details/51670263
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = grayColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func GCD1(){
        
        
    }


}
