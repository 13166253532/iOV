//
//  BigImageViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/2/9.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit
import SDCycleScrollView
class BigImageViewController: BaseViewController ,SDCycleScrollViewDelegate{
    var imageArray = NSMutableArray()
    var bannerView: SDCycleScrollView!
    var titles = NSMutableArray()
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "BigImageViewController", bundle: nil)
        let vc:BigImageViewController=storyboard.instantiateViewController(withIdentifier: "BigImageViewController") as! BigImageViewController
        vc.createArgs=createArgs
        return vc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520850300199&di=a892268056d70b2253291448b77060b1&imgtype=0&src=http%3A%2F%2Fwww.people.com.cn%2Fmediafile%2Fpic%2F20180227%2F32%2F2011904788671830688.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520850300488&di=2b5e48f7dc3cef7a6f6e478492a215b1&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201208%2F04%2F20120804021420_vyuaU.jpeg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520850300488&di=ea12a0618d3eaebd49d6ddb571e0ae81&imgtype=0&src=http%3A%2F%2Fp2.qhmsg.com%2Ft014cb47bf9adfc575d.jpg"]
        titles = ["11111","222222","3333333"]
        // Do any additional setup after loading the view.
        initbannerView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SNPhotoBrowserTool.showPhotoBrowser(0, originData: imageArray as! [Any], containerVC: self)
        
       // print(Encryption.md5Encrypt(with: "19930322qwerty"))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initbannerView() {
        bannerView = SDCycleScrollView.init(frame: CGRect(x:0, y: 100, width:SCREEN_WHIDTH() , height:200 ), delegate: self, placeholderImage: UIImage.init(named: "homePage_defaultImg"))
        bannerView.imageURLStringsGroup = imageArray as [AnyObject]
        bannerView.titlesGroup = titles as [AnyObject]
        bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        bannerView.currentPageDotImage = UIImage.init(named: "banner_selected")
        bannerView.pageDotImage = UIImage.init(named: "banner_unSelected")
        bannerView.titleLabelHeight=36
        bannerView.titleLabelBackgroundColor = UIColor.clear
        bannerView.autoScrollTimeInterval=5
        //bannerView.titleLabelBGImage = UIImage.init(named: "homePage_bottomGray")
        //bannerView.titlelabel
        bannerView.placeholderImage=UIImage(named: "homePage_defaultImg")
        self.view .addSubview(bannerView)
    }
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
    

}
