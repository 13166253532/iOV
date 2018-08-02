//
//  SectorChartViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/8/2.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class SectorChartViewController: BaseViewController {

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "SectorChartViewController", bundle: nil)
        let vc:SectorChartViewController=storyboard.instantiateViewController(withIdentifier: "SectorChartViewController") as! SectorChartViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rateArray = ["0.7261","0.068","0.068","0.0594","0.0393","0.0391"]
        let valueArray = ["423651.23","423651.23","423651.23","423651.23","423651.23","423651.23"]
        let chart:DVPieChart = DVPieChart.init(frame: CGRect(x:0, y: 100, width:SCREEN_WHIDTH() , height:320 ))
        chart.dataArray = NSMutableArray()
        self.view .addSubview(chart)
        for index in 0..<rateArray.count {
            let model:DVFoodPieModel = self.getModel(rate: rateArray[index], name: String(index), value: valueArray[index])
            chart.dataArray.add(model)
        }
        chart.title = "金额"
        chart.draw()
    }
    func getModel(rate:String,name:String,value:String)->DVFoodPieModel {
        let model = DVFoodPieModel()
        model.rate = StringToFloat(str: rate)
        model.name = name
        model.value = StringToFloat(str: value)
        return model
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func StringToFloat(str:String)->(CGFloat){
        let string = str
        var cgFloat:CGFloat = 0
        let doubleValue = Double(string)
        if (doubleValue != nil){
            cgFloat = CGFloat(doubleValue!)
        }
        return cgFloat
    }
    
    
//    func stringToInt(str:String)->(Int){
//
//
//
//        let string = str
//
//        var int:Int?
//
//        iflet doubleValue = Int(string) {
//
//            int = Int(doubleValue)
//
//        }
//
//        if int ==nil
//
//        {
//
//            return0
//
//        }
//
//        return int!
//
//    }
    


}
