//
//  HttpViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/11.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class HttpViewController: BaseViewController {
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "HttpViewController", bundle: nil)
        let vc:HttpViewController=storyboard.instantiateViewController(withIdentifier: "HttpViewController") as! HttpViewController
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
    

    
     @IBAction func httpAction(_ sender: UIButton) {
        getHttpProjectdetailsRequire()
     }
    func getHttpProjectdetailsRequire(){
        let cmd:HttpCommand = DSHttpMessageListCmd.init(version: PHttpVersion_v1)
        let block:httpBlock = {[weak self] (result:RequestResult!,useInfo:AnyObject!)->() in
            if result != nil {
                self?.httpProjectdetailsResponse(result: result)
            }else{
                print("空的")
            }
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_PerInvestmentList_sortType] = "DESC"
        dic[kHttpParamKey_PerInvestmentList_sortItem] = "followCount"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate = SMBaseHttpComplete.init(block: block , withUserInfo: nil)
        cmd.requestInfo = dic as! [AnyHashable : Any]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpProjectdetailsResponse(result:RequestResult){
        let r:DSHttpMessageListResult = result as! DSHttpMessageListResult
        if r.isOk() {
            let array:NSMutableArray = r.getTheAllData()
            for index in 0..<array.count {
                let model:CompanyListInfoMode = array[index] as! CompanyListInfoMode
                print(model.org_name ?? String())
            }
        }else{
            SMToastView.showMessage(r.errMsg)
        }
    }

}
