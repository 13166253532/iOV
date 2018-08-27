//
//  GCDFuncViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/19.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class GCDFuncViewController: BaseViewController {

    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "GCDFuncViewController", bundle: nil)
        let vc:GCDFuncViewController=storyboard.instantiateViewController(withIdentifier: "GCDFuncViewController") as! GCDFuncViewController
        vc.createArgs=createArgs
        return vc
    }
    

    //https://blog.csdn.net/Mazy_ma/article/details/53464669
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = grayColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ///async_concurrent()
        sync_serial()
        self.dismiss(animated: true, completion: nil)
    }
    // 同步 + 串行队列：不会开启新的线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务
    func sync_serial() {
        // 1、创建一个串行队列
        let serialQueue = DispatchQueue(label: "Mazy", attributes: .init(rawValue: 0))
        // 同步执行三个任务
        serialQueue.sync {
            print("1 + \(Thread.current)")
        }
        serialQueue.sync {
            print("2 + \(Thread.current)")
        }
        serialQueue.sync {
            print("3 + \(Thread.current)")
        }
    }
    // 异步 + 串行队列：开启新的线程，但只开启一条
    func async_serial() {
        // 1、创建一个串行队列
        let serialQueue = DispatchQueue(label: "Mazy", attributes: .init(rawValue: 0))
        // 异步执行三个任务
        serialQueue.async {
            print("1 + \(Thread.current)")
        }
        serialQueue.async {
            print("2 + \(Thread.current)")
        }
        serialQueue.async {
            print("3 + \(Thread.current)")
        }
    }

    // 同步 + 并发队列：不会开启新的线程
    func sync_concurrent() {
        // 创建一个全局
        let globalQueue = DispatchQueue.global()
        // 同步执行三个任务
        globalQueue.sync {
            print("1 + \(Thread.current)")
        }
        globalQueue.sync {
            print("2 + \(Thread.current)")
        }
        globalQueue.sync {
            print("3 + \(Thread.current)")
        }
        
    }
    // 异步 + 并发队列：同时开启多条线程
    func async_concurrent() {
        
        // 创建一个全局队列
        let globalQueue = DispatchQueue.global()
        // 异步执行三个任务
        globalQueue.async {
            print("1 + \(Thread.current)")
            DispatchQueue.main.async {
                // 回到主线程，执行UI刷新操作
                print("0 + \(Thread.current)")
            }
        }
        globalQueue.async {
            print("2 + \(Thread.current)")
        }
        globalQueue.async {
            print("3 + \(Thread.current)")
        }
    }

    //延迟执行
    func additionalTime() {
        print("开始执行 \(NSDate())")
        let additionalTime: DispatchTimeInterval = .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: .now() + additionalTime, execute: {
            print("3秒后执行 \(NSDate())")
        })
        //其他延迟方法
        // method 1
        perform(#selector(demo), with: nil, afterDelay: 3.0)
        // method 2
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: {_ in
                print("延迟3s执行")
            })
        } else {
            // Fallback on earlier versions
        }
    }
    func demo(){
        
    }
    //创建线程群组
    //例如同一个文件分段下载，待所有分段任务下载完成后，合并任务
    func group() {
        // 获得全局队列
        let globalQueue = DispatchQueue.global()
        
        // 创建一个队列组
        let group = DispatchGroup()
        
        globalQueue.async(group: group, execute: {
            print("任务一 \(Thread.current)")
        })
        globalQueue.async(group: group, execute: {
            print("任务二 \(Thread.current)")
        })
        
        // group内的任务完成后,执行此方法
        group.notify(queue: globalQueue, execute: {
            print("终极任务 \(Thread.current)")
        })
        
        globalQueue.async(group: group, execute: {
            print("任务三 \(Thread.current)")
        })
        
        globalQueue.async(group: group, execute: {
            print("任务四 \(Thread.current)")
        })
    }
}
