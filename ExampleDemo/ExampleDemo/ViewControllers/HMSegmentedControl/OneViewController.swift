//
//  OneViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/21.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class OneViewController: BaseViewController {

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "OneViewController", bundle: nil)
        let vc:OneViewController=storyboard.instantiateViewController(withIdentifier: "OneViewController") as! OneViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let vc:HttpViewController = HttpViewController.createViewController(createArgs: nil) as! HttpViewController
        //vc.hidesBottomBarWhenPushed = true
        //self.pushViewController(viewController: vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
