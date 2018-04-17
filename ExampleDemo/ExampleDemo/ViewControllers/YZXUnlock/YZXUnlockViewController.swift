//
//  YZXUnlockViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/28.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit


class YZXUnlockViewController: BaseViewController {
    var settingGesture:Bool = true
    var selectedID = NSArray()
    //https://github.com/yinxing29/YZXUnlock
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var cancelBut: UIButton!
    
    @IBOutlet weak var confirmBut: UIButton!
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "YZXUnlockViewController", bundle: nil)
        let vc:YZXUnlockViewController=storyboard.instantiateViewController(withIdentifier: "YZXUnlockViewController") as! YZXUnlockViewController
        vc.createArgs=createArgs
        return vc
    }
    
    //https://mp.weixin.qq.com/s?__biz=MzA3NzM0NzkxMQ==&mid=2655359588&idx=1&sn=3f20d51b12a9b9845c00d4d01e6cf6ef&chksm=84e25f4cb395d65a2df3643fed97751a86799dc0a3c3a9e1f45b7e21ca993bdeb5f47518bf5c&mpshare=1&scene=1&srcid=0327oTUizkJRgkEERzkUB4Bc&key=ae8054e0d86525951d8af091e52adb5075b170f8b6c76c652bc9f5884f89f068e78b8d508c988032144934ce380de02280ffbd8f8119f96e1efba0d2baaf3c8b4f63ea7e485c2f41bc616fe6dd3bcb32&ascene=0&uin=MTQ5NDk5Mjg4MQ%3D%3D&devicetype=iMac+MacBookAir6%2C1+OSX+OSX+10.13.1+build(17B1003)&version=11010011&lang=pt&pass_ticket=HVL3IA4E%2BwFugTlpsxy2ahHrsLGTX5pvu%2FewG1G9DQHJTUEy3Ohar56e4qNmkr5a
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        p_initView()
    }
    func p_initView(){
        self.view .addSubview(gesturesView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    lazy var gesturesView:GesturesView = {
        let _gesturesView = GesturesView.init(frame:CGRect(x:40, y: SCREEN_HEIGHT()/2-(SCREEN_WHIDTH()-80)/2, width:SCREEN_WHIDTH()-80 , height:SCREEN_WHIDTH()-80 ) )
        _gesturesView.backgroundColor = UIColor.clear
        _gesturesView.settingGesture = self.settingGesture
  
        _gesturesView.setGestureBlock({ [weak self](selectedID) in
            self?.selectedID = selectedID! as NSArray
            self?.hintLabel.isHidden = true
        }, andUnlock: {[weak self] (isSuccess) in
            let success = isSuccess as Bool
            if !success {
                self?.hintLabel.text = "解锁失败"
                self?.hintLabel.textColor = UIColor.red
                self?.navigationController?.popViewController(animated: true)
                
            }else{
                self?.hintLabel.text = "解锁成功"
                self?.hintLabel.textColor = UIColor.green
                self?.navigationController?.popViewController(animated: true)
            }
            
        }, andSettingBlock: {[weak self] in
            self?.hintLabel.isHidden = false
            self?.hintLabel.text = "手势密码不得少于4个点"
            self?.hintLabel.textColor = UIColor.red
        })
 
        return _gesturesView
    }()

    @IBAction func quxiaoAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
   
    @IBAction func quedingAction(_ sender: UIButton) {
        UserDefaults.standard.set(self.selectedID, forKey: "GestureUnlock")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
