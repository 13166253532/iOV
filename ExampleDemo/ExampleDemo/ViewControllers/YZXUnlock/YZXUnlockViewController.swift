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
