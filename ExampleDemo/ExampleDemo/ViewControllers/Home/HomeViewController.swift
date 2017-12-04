//
//  HomeViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/4.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "HomeViewController", bundle: nil)
        let vc:HomeViewController=storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initTitleBar()
        initReturnBtn()
        self.title = "首页"
        self.view.backgroundColor = loginBg_Color
        // Do any additional setup after loading the view.
    }
    override func initReturnBtn(){
        let leftN:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: ""), style: .plain, target: self, action: #selector(arrowResponse))
        self.navigationItem.leftBarButtonItem = leftN
    }
    override func arrowResponse(){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
