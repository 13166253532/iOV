//
//  SnapKitViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/14.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class SnapKitViewController: BaseViewController {

    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "SnapKitViewController", bundle: nil)
        let vc:SnapKitViewController=storyboard.instantiateViewController(withIdentifier: "SnapKitViewController") as! SnapKitViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        two()
        
    }
    func one() {
        let testView = UIView()
        testView.backgroundColor = UIColor.cyan
        view.addSubview(testView)
        testView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)    // 链式语法直接定义宽高
            make.center.equalToSuperview()    // 直接在父视图居中
        }
    }
    func two(){
        // 黑色视图作为父视图
        let view1 = UIView()
        view1.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        view1.center = view.center
        view1.backgroundColor = UIColor.black
        view.addSubview(view1)
        
        // 测试视图
        let view2 = UIView()
        view2.backgroundColor = UIColor.magenta
        view1.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
 
    }
    func three(){
        // 黑色视图作为父视图
        let view1 = UIView()
        view1.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        view1.center = view.center
        view1.backgroundColor = UIColor.black
        view.addSubview(view1)
        
        // 测试视图
        let view2 = UIView()
        view2.backgroundColor = UIColor.magenta
        view1.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            // 让顶部距离view1的底部为10的距离
            make.top.equalTo(view1.snp.bottom).offset(10)
            // 设置宽、高
            make.width.height.equalTo(100)
            // 水平中心线<=view1的左边
            make.centerX.lessThanOrEqualTo(view1.snp.leading)
        }
    
    }
    func forr() {
        
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
