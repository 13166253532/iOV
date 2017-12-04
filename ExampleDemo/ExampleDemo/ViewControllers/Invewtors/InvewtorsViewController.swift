//
//  InvewtorsViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/4.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class InvewtorsViewController: BaseViewController {

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "InvewtorsViewController", bundle: nil)
        let vc:InvewtorsViewController=storyboard.instantiateViewController(withIdentifier: "InvewtorsViewController") as! InvewtorsViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitleBar()
        initReturnBtn()
        self.title = "投资方"
        self.view.backgroundColor = loginBg_Color

        // Do any additional setup after loading the view.
    }

    override func initReturnBtn(){
        let leftN:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: ""), style: .plain, target: self, action: #selector(arrowResponse))
        self.navigationItem.leftBarButtonItem = leftN
    }
    override func arrowResponse(){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
