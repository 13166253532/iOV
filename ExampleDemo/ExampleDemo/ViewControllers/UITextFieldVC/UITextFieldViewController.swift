//
//  UITextFieldViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/4/2.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class UITextFieldViewController: BaseViewController {
    @IBOutlet weak var myTableView: UITableView!
    var dataSource:NSMutableArray!
    var delegate:UITextFieldViewControllerDelegate!

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "UITextFieldViewController", bundle: nil)
        let vc:UITextFieldViewController=storyboard.instantiateViewController(withIdentifier: "UITextFieldViewController") as! UITextFieldViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initMyTableView()
        isNavigationBarObstructed()
    }

    func initMyTableView() {
        initdataSource()
        if #available(iOS 11.0, *) {
            self.myTableView.contentInsetAdjustmentBehavior = .never
            self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, (self.navigationController?.toolbar.bounds.height)!, 0)//导航栏如果使用系统原生半透明的，top设置为64
            self.myTableView.scrollIndicatorInsets = self.myTableView.contentInset
        }
        self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, (self.navigationController?.toolbar.bounds.height)!, 0)
        self.scrollViewDidScroll(scrollView: self.myTableView)
        
        self.delegate = UITextFieldViewControllerDelegate()
        self.delegate.slidingBlock = {[weak self] in
            //self?.scrollViewDidScroll(scrollView: (self?.myTableView)!)
        }
        self.delegate.dataSource=self.dataSource
        self.delegate.block = {(sender: AnyObject , sender1: AnyObject)->() in
            //self.perform(self.refreshUI(object:sender1), on: .main, with: sender1, waitUntilDone: true)
            //self.perform(#selector(MainViewController.refreshUI(object:)), on: .main, with: sender1, waitUntilDone: true)
        }
        registerCell(self.myTableView, cell: UITextFieldTableViewCell.self)
        self.myTableView.delegate = self.delegate
        self.myTableView.dataSource = self.delegate
        self.myTableView.backgroundColor = grayBgColor
        setExtraCellLineHidden(tableView: self.myTableView)
        //        self.myTableView.mas_makeConstraints { (make: MASConstraintMaker? ) in
        //            make?.top.mas_equalTo()
        //            make?.left.right().bottom().mas_offset()
        //        }
        
        
    }
    func initdataSource(){
        self.dataSource = NSMutableArray()
        for index in 0..<40 {
            let model = UITextFieldTableViewCellModel()
            model.className = "UITextFieldTableViewCell"
            model.titleValue = String(index)
            model.block = { [weak self] (value:AnyObject) in
                model.textViewText = value as? String
                print("----",value)
            }
            dataSource.add(model)
        }
       
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
class UITextFieldViewControllerDelegate: BaseOneTableViewDelegate {
    var selecCompany:String!
    var slidingBlock:selectBlock!
    var block:passTwoParameterBlock!
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.slidingBlock()
    }
   
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section==0){
            return 0
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44*WHIDTH_RATIO()
    }
    func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //let data = self.dataSource[indexPath.row] as! MainTableViewCellModel
        
        //self.block(data,indexPath)
    }
}
