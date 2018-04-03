//
//  AnimatedTransitioning.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/4/3.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

//一、创建一个类，并实现了 UIViewControllerAnimatedTransitioning 协议
//这个协议主要控制控制器视图的显示的，通过 transitionContext 可以获取到每个视图和控制器，并进行动画的设置
class AnimatedTransitioning: NSObject {

    var isPresenting: Bool = false
}

extension AnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        let containerView = transitionContext.containerView
        
        if isPresenting {
            toView.transform = CGAffineTransform(scaleX: 0, y: 0)
            containerView.addSubview(toView)
        } else {
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            if self.isPresenting {
                toView.transform = CGAffineTransform.identity
            } else {
                fromView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            }
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}
//二、创建一个类作为 UIViewControllerTransitioningDelegate 过渡代理
//这里设置 presented 和 dismissed 时各自的动画转换类，可以设置为不同的类
class CustomTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let at = AnimatedTransitioning()
        at.isPresenting = true
        return at
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let at = AnimatedTransitioning()
        at.isPresenting = false
        return at
    }
}
