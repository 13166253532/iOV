//
//  GuidancePageViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/20.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class GuidancePageViewController: BaseViewController {

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "GuidancePageViewController", bundle: nil)
        let vc:GuidancePageViewController=storyboard.instantiateViewController(withIdentifier: "GuidancePageViewController") as! GuidancePageViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let label:UILabel = UILabel.init(frame: CGRect.init(x: 60, y: 100, width: 60, height: 200))
        label.text = "这是一个需要指导的新界面，只有第一次打开才有步骤指导"
        label.numberOfLines = 0
        label.textColor = UIColor.red
        label.textAlignment = .center
        self.view.addSubview(label)
        
        if JHGuideView.isShowGuiderView() {
            self.view.addSubview(JHGuideView.jhGuideView(aFrame: CGRect.init(x: 0, y: 0, width: Screen_Width, height: Screen_Height), aImageName: "guide", aImageCount: 2))
        }
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
