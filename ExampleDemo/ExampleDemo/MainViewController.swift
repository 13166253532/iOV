//
//  MainViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/1.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var dataSource:NSMutableArray!
    var delegate:MainViewControllerDelegate!
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "MainViewController", bundle: nil)
        let vc:MainViewController=storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewWillAppear(_ animated: Bool) {
        //hideNavigationBar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitleBar()
        self.title = "我的"
        self.view.backgroundColor = loginBg_Color
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clear)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        initReturnBtn()
        //isNavigationBarObstructed()
        initMyTableView()
        if #available(iOS 11.0, *) {
            self.myTableView.contentInsetAdjustmentBehavior = .never
            self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, (self.navigationController?.toolbar.bounds.height)!, 0)//导航栏如果使用系统原生半透明的，top设置为64
            self.myTableView.scrollIndicatorInsets = self.myTableView.contentInset
        }
        self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, (self.navigationController?.toolbar.bounds.height)!, 0)
        self.scrollViewDidScroll(scrollView: self.myTableView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate.slidingBlock = nil
        displayNavigationBar()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //左侧返回按钮
    override func initReturnBtn(){
        let leftN:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: ""), style: .plain, target: self, action: #selector(arrowResponse))
        self.navigationItem.leftBarButtonItem = leftN
    }
    override func arrowResponse(){
        
    }
    func initMyTableView() {
        initdataSource()
        self.delegate = MainViewControllerDelegate()
        self.delegate.slidingBlock = {[weak self] in
            self?.scrollViewDidScroll(scrollView: (self?.myTableView)!)
        }
        self.delegate.dataSource=self.dataSource
        registerCell(self.myTableView, cell: MainTableViewCell.self)
        self.myTableView.delegate = self.delegate
        self.myTableView.dataSource = self.delegate
        self.myTableView.backgroundColor = grayBgColor
        setExtraCellLineHidden(tableView: self.myTableView)
    }
    func initdataSource()  {
        self.dataSource = NSMutableArray()
        let titleArray = ["swift二维码","swift条码","数据库","web页面","http","swift二维码","字符判断"]
        for index in 0..<titleArray.count {
            let model = MainTableViewCellModel()
            model.className = "MainTableViewCell"
            model.titleValue = titleArray[index]
            model.block = { [weak self] (value:AnyObject) in
                self?.gotoVC(str: value as! String)
            }
            dataSource.add(model)
        }
    }
    func gotoVC(str:String){
        if str == "swift二维码" {
            gotoQRVC()
        }else if str == "swift条码" {
            gotoQRTwoVC()
        }else if str == "数据库" {
            gotoLKDBHelper()
        }else if str == "web页面"{
            gotoWebVC()
        }else if str == "http"{
            gotoHttpVC()
        }else if str == "字符判断"{
            gotoCharacterJudgmentViewController()
        }
        
    }
    func gotoQRVC() {
        let vc:QRCodeViewController=QRCodeViewController.createViewController(createArgs: nil) as! QRCodeViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoQRTwoVC() {
        let vc:QRCodeTwoViewController = QRCodeTwoViewController.createViewController() as! QRCodeTwoViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoLKDBHelper() {
        let vc:LKDBHelperViewController=LKDBHelperViewController.createViewController(createArgs: nil) as! LKDBHelperViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoWebVC(){
        let vc:WebViewController = WebViewController.createViewController() as! WebViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoHttpVC(){
        let vc:HttpViewController = HttpViewController.createViewController(createArgs: nil) as! HttpViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoCharacterJudgmentViewController(){
        let vc:CharacterJudgmentViewController = CharacterJudgmentViewController.createViewController(createArgs: nil) as! CharacterJudgmentViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
}
class MainViewControllerDelegate: BaseOneTableViewDelegate {
    var selecCompany:String!
    var slidingBlock:selectBlock!
    
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
}
