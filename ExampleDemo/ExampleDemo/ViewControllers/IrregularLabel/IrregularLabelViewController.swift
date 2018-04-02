//
//  IrregularLabelViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/4/2.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit


class IrregularLabelViewController: BaseViewController {

    var nameLabel = IrregularLabel()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "IrregularLabelViewController", bundle: nil)
        let vc:IrregularLabelViewController=storyboard.instantiateViewController(withIdentifier: "IrregularLabelViewController") as! IrregularLabelViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel = IrregularLabel.init(frame: CGRect(x:30, y: 90, width:SCREEN_WHIDTH()-60 , height:64 ))
        self.nameLabel.text = "这是一个不规则的label"
        self.nameLabel.textAlignment = .center
        self.nameLabel.backgroundColor = UIColor.red
        self.nameLabel.textColor = UIColor.white
        self.view .addSubview(self.nameLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
