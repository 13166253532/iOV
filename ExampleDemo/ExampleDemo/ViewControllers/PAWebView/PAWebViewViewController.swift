//
//  PAWebViewViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/9/11.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class PAWebViewViewController: BaseViewController,PAWKScriptMessageHandler {

    var webView:PAWebView!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "PAWebViewViewController", bundle: nil)
        let vc:PAWebViewViewController=storyboard.instantiateViewController(withIdentifier: "PAWebViewViewController") as! PAWebViewViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPAWebView()
        // Do any additional setup after loading the view.
    }

    func setPAWebView(){
        
        webView = PAWebView.shareInstance()
        
        webView.openCache = true
        webView.addScriptMessageHandler(withName: ["AliPay","weixin","webViewApp"]) { (userContentController, message) in
            
        }
        webView.loadRequestURL(NSMutableURLRequest.init(url: URL.init(string: "https://www.sina.cn")!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20.0))
        self.navigationController?.pushViewController(PAWebView.shareInstance(), animated: true)
        webView.notificationInfo { (infor) in
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
