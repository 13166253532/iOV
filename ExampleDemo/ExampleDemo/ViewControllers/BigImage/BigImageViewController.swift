//
//  BigImageViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/2/9.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class BigImageViewController: BaseViewController {
    var imageArray = NSMutableArray()
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "BigImageViewController", bundle: nil)
        let vc:BigImageViewController=storyboard.instantiateViewController(withIdentifier: "BigImageViewController") as! BigImageViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520850300199&di=a892268056d70b2253291448b77060b1&imgtype=0&src=http%3A%2F%2Fwww.people.com.cn%2Fmediafile%2Fpic%2F20180227%2F32%2F2011904788671830688.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520850300488&di=2b5e48f7dc3cef7a6f6e478492a215b1&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201208%2F04%2F20120804021420_vyuaU.jpeg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520850300488&di=ea12a0618d3eaebd49d6ddb571e0ae81&imgtype=0&src=http%3A%2F%2Fp2.qhmsg.com%2Ft014cb47bf9adfc575d.jpg"]
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SNPhotoBrowserTool.showPhotoBrowser(1, originData: imageArray as! [Any], containerVC: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
