//
//  LKDBHelperViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/1.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
protocol  LKDBHelperViewControllerDelegate{
    func setStr(str:String)->String
}

class LKDBHelperViewController: BaseViewController {
    var delegate: LKDBHelperViewControllerDelegate?
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
        for index in 0..<10 {
            let messageInfo:HTMessageInfo = HTMessageInfo.init()
            messageInfo.isRead = "0"
            messageInfo.accountId = "111111111"
            messageInfo.messageId = String(index)
            FGDBHelper.sharedInstance().saveMessage(messageInfo) { (isSuccess:Bool) in
                if isSuccess {
                    print("1")
                }else{
                    print("2")
                }
            }
        }
       
    }
    //获取
    @IBAction func getAction(_ sender: UIButton) {
        let dataArray:NSMutableArray = FGDBHelper.sharedInstance().queryAllMessage("111111111")
        for index in 0..<dataArray.count {
            let messageInfo:HTMessageInfo = dataArray[index] as! HTMessageInfo
            print(messageInfo.accountId,messageInfo.messageId,messageInfo.isRead)
            self.delegate?.setStr(str: messageInfo.accountId)
        }
    }
    
    //删除
    @IBAction func deletAction(_ sender: UIButton) {
        FGDBHelper.sharedInstance().deleteAllMessageList("111111111") { (isSuccess:Bool) in
            if isSuccess {
                print("1")
            }else{
                print("2")
            }
        }
//        FGDBHelper.sharedInstance().deleteSingleMessage("2", andAccountId: "111111111") { (isSuccess:Bool) in
//            if isSuccess {
//                print("1")
//            }else{
//                print("2")
//            }
//        }
      
    }
    
    //修改
    @IBAction func upAction(_ sender: UIButton) {
        let messageInfo:HTMessageInfo = HTMessageInfo.init()
        messageInfo.isRead = "1"
        messageInfo.accountId = "111111111"
        messageInfo.messageId = "1"
        FGDBHelper.sharedInstance().updateMessagePush(messageInfo) { (isSuccess:Bool) in
            if isSuccess {
                print("1")
            }else{
                print("2")
            }
        }
    }
    
    
}
