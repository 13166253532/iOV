//
//  CharacterJudgmentViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/1/10.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class CharacterJudgmentViewController: BaseViewController {
  
    var getCodeBtn:JKCountDownButton!
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "CharacterJudgmentViewController", bundle: nil)
        let vc:CharacterJudgmentViewController=storyboard.instantiateViewController(withIdentifier: "CharacterJudgmentViewController") as! CharacterJudgmentViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CharacterJudgment.onlyLetters("aAwq") {
            print("==true")
        }else{
            print("==false")
        }
        getCodeBtn = JKCountDownButton.init(type: .custom)
        getCodeBtn.frame = CGRect(x:100, y: 200, width:100 , height:30)
        getCodeBtn.setTitle("获取验证码", for: .normal)
        getCodeBtn.setTitleColor(navigationColor, for: .normal)
        //getCodeBtn.backgroundColor = UIColor.red
        getCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15*WHIDTH_RATIO())
        getCodeBtn.addTarget(self, action: #selector(getCodeFunc), for: .touchUpInside)
        self.view .addSubview(getCodeBtn)
    }
    //获取验证码
    func getCodeFunc() {
        //userTextView.resignFirstResponder()
        //passTextView.resignFirstResponder()
        //verificationCodeTextView.resignFirstResponder()
        //if userTextView.text == nil || userTextView.text?.characters.count == 0 {
           // SMToastView.showMessage("手机号码为空！")
        //}else if !isTelNumber(num: userTextView.text!){
         //   SMToastView.showMessage("请输入正确的手机号！")
        //}else{
            getCodeHttp()
        //}
    }
    //获取验证码接口
    func getCodeHttp(){
        countdownAction()
    }
    //获取验证码 倒计时启动
    func countdownAction(){
        UIApplication.shared.keyWindow?.endEditing(true)
        getCodeBtn.isEnabled = false
        getCodeBtn.start(withSecond: 60)
        getCodeBtn.didChange({ (countDownButton:JKCountDownButton!, second:Int32) -> String! in
            let str:String = String(format:" %d 秒",second)
            return str
        })
        getCodeBtn.didFinished({ (countDownButton:JKCountDownButton!, second:Int32) -> String! in
            countDownButton.isEnabled = true
            return "获取验证码"
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }

}
