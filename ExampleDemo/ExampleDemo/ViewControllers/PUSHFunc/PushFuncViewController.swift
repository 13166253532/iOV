//
//  PushFuncViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/4/3.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class PushFuncViewController: BaseViewController {

    //3、在将要 push 的控制器内设置导航控制器的代理为自定义的代理（步骤2的代理类）
    //注意：代理不能为局部变量
    var cnaDelegate = CustomNaviAnimateDelagete()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "PushFuncViewController", bundle: nil)
        let vc:PushFuncViewController=storyboard.instantiateViewController(withIdentifier: "PushFuncViewController") as! PushFuncViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = cnaDelegate
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc:GCDFuncViewController=GCDFuncViewController.createViewController(createArgs: nil) as! GCDFuncViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
//1、创建一个类,并实现了 UIViewControllerAnimatedTransitioning 协议
class CustomNaviAnimatedTransition: NSObject {
    var isPushed: Bool?
    
    // 通过 static let 创建单例
    static let shared = CustomNaviAnimatedTransition()
    // 构造函数，init前加private修饰,表示原始构造方法只能自己使用，外界不发调用
    private override init() { }
}
/// 从左往右进，从左往右出
extension CustomNaviAnimatedTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        let containerView = transitionContext.containerView
        
        if isPushed == true {
            
            containerView.addSubview(toView)
            toView.frame.origin.x = -toView.bounds.width
            
            UIView.animate(withDuration: 0.3, animations: {
                toView.frame.origin.x = 0
            }, completion: { (finished) in
                if finished {
                    transitionContext.completeTransition(finished)
                }
            })
            
        } else {
            
            containerView.insertSubview(toView, belowSubview: fromView)
            UIView.animate(withDuration: 0.3, animations: {
                fromView.frame.origin.x = -fromView.frame.width
            }, completion: { (finished) in
                if finished {
                    transitionContext.completeTransition(finished)
                }
            })
        }
    }
}
//2、创建一个类作为 UINavigationControllerDelegate 过渡代理，实现对应方法
class CustomNaviAnimateDelagete: NSObject, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationTransition = CustomNaviAnimatedTransition.shared
        animationTransition.isPushed = operation.rawValue == 1
        return animationTransition
    }
}
