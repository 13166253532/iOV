//
//  CharacterJudgmentViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/1/10.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class CharacterJudgmentViewController: BaseViewController {
  
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "CharacterJudgmentViewController", bundle: nil)
        let vc:CharacterJudgmentViewController=storyboard.instantiateViewController(withIdentifier: "CharacterJudgmentViewController") as! CharacterJudgmentViewController
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
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }

}
