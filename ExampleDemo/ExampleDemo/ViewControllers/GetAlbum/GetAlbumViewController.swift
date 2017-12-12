//
//  GetAlbumViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/11.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class GetAlbumViewController: BaseViewController {

    var picker:PickView = PickView()
    var imageBlock:passParameterBlock!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "GetAlbumViewController", bundle: nil)
        let vc:GetAlbumViewController=storyboard.instantiateViewController(withIdentifier: "GetAlbumViewController") as! GetAlbumViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK:添加图片
    func addImageAction(){
        
        let actions:UIAlertController=UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let action1:UIAlertAction=UIAlertAction(title: "相册", style: UIAlertActionStyle.default) { (action) in
            self.picker.showLocalPhotoWithController(controller: self, block: { (value:AnyObject?) in
                self.imageBlock(value!)
            })
        }
        
        let action2:UIAlertAction=UIAlertAction(title: "拍照", style: UIAlertActionStyle.default) { (action) in
            self.picker.showTakePhotoWithController(controller: self, block: { (value:AnyObject?) in
                self.imageBlock(value!)
            })
        }
        
        let action:UIAlertAction=UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action) in}
        actions.addAction(action1)
        actions.addAction(action2)
        actions.addAction(action)
        AppRootViewController()!.present(actions, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getAction(_ sender: UIButton) {
        
    }
    
   

}
