//
//  ViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/11/30.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
enum DataType: Int{   //区分搜索界面历史记录
    case ProjectData = 1        //项目
    case InvestorsData = 2      //个人投资
    case ParkData = 3           //园区
    case InvestorAgencyData = 4 //投资机构
}
class ViewController: UIViewController {
    var dataType:DataType = .ParkData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

