//
//  LKDBHelperViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/1.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class LKDBHelperViewController: BaseViewController {

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "LKDBHelperViewController", bundle: nil)
        let vc:LKDBHelperViewController=storyboard.instantiateViewController(withIdentifier: "LKDBHelperViewController") as! LKDBHelperViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //存储
    @IBAction func storageAction(_ sender: UIButton) {
        let messageInfo:HTMessageInfo = HTMessageInfo.init()
        messageInfo.isRead = "1"
        messageInfo.accountId = "111111111"
        FGDBHelper.sharedInstance().saveMessage(messageInfo) { (isSuccess:Bool) in
            if isSuccess {
                print("1")
            }else{
                print("2")
            }
        }
    }
    //获取
    @IBAction func getAction(_ sender: UIButton) {
        let dataArray:NSMutableArray = FGDBHelper.sharedInstance().queryAllMessage("111111111")
        for index in 0..<dataArray.count {
            let messageInfo:HTMessageInfo = dataArray[index] as! HTMessageInfo
            print(messageInfo.isRead)
        }
    }
    
    //删除
    @IBAction func deletAction(_ sender: UIButton) {
        FGDBHelper.sharedInstance().deleteMessage("123456789") { (isSuccess:Bool) in
            
        }
    }
    
}
