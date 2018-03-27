//
//  UIPresentationViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/27.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class UIPresentationViewController: BaseViewController {

    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "UIPresentationViewController", bundle: nil)
        let vc:UIPresentationViewController=storyboard.instantiateViewController(withIdentifier: "UIPresentationViewController") as! UIPresentationViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//https://github.com/IkeBanPC/PresentBottom
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func one(_ sender: UIButton) {
        self.presentBottom(FirstBottomVC.self)
    }
    
    @IBAction func two(_ sender: UIButton) {
        self.presentBottom(SelectionVC.self)
    }
    
    @IBAction func three(_ sender: UIButton) {
        self.presentBottom(TimeSelectVC.self)
    }
}
