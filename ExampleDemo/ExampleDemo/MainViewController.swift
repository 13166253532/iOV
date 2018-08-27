//
//  MainViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/1.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
import MJRefresh

class MainViewController: BaseViewController ,FontSizeChangeDelegate{
    
    @IBOutlet weak var myTableView: UITableView!
    var dataSource:NSMutableArray!
    var delegate:MainViewControllerDelegate!
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "MainViewController", bundle: nil)
        let vc:MainViewController=storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        vc.createArgs=createArgs
        return vc
    }
//    override func viewWillAppear(_ animated: Bool) {
//        //hideNavigationBar()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initTitleBar()
        
        self.title = "我的"
        //self.view.backgroundColor = loginBg_Color
        //self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clear)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        //initReturnBtn()
        isNavigationBarObstructed()
        initMyTableView()
        
        let urlImageView = UIImageView.init(frame: CGRect(x:10, y:50, width:60 , height:60))
        urlImageView.sd_setImage(with: URL.init(string: "https://www.hstd.com/portalimage//2018/6760CFAB642D913AE053ACC8A8C08DF8.png"), placeholderImage: UIImage.init(named: "hand_image"))
        
        //self.view .addSubview(urlImageView)
        
        //addHeaderFooter()
    }

    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(upPullLoadData))
        self.header.lastUpdatedTimeLabel.isHidden = true
        self.header.stateLabel.isHidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(downPlullLoadData))
        self.footer.stateLabel.isHidden = true
        self.footer.isRefreshingTitleHidden = true
        self.myTableView.mj_header = self.header
        self.myTableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.dataSource = NSMutableArray()
        
        self.myTableView.reloadData()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        //self.myTableView.mj_footer.endRefreshing()
        //self.myTableView.mj_header.endRefreshing()
        self.myTableView.reloadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.delegate.slidingBlock = nil
        //displayNavigationBar()
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
        if #available(iOS 11.0, *) {
            self.myTableView.contentInsetAdjustmentBehavior = .never
            self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, (self.navigationController?.toolbar.bounds.height)!, 0)//导航栏如果使用系统原生半透明的，top设置为64
            self.myTableView.scrollIndicatorInsets = self.myTableView.contentInset
        }
        self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, (self.navigationController?.toolbar.bounds.height)!, 0)
        //self.scrollViewDidScroll(scrollView: self.myTableView)
        
        self.delegate = MainViewControllerDelegate()
        self.delegate.slidingBlock = {[weak self] in
            //self?.scrollViewDidScroll(scrollView: (self?.myTableView)!)
        }
        self.delegate.dataSource=self.dataSource
        self.delegate.block = {(sender: AnyObject , sender1: AnyObject)->() in
//            self.perform(self.refreshUI(object:sender1), on: .main, with: sender1, waitUntilDone: true)
//            self.perform(#selector(MainViewController.refreshUI(object:)), on: .main, with: sender1, waitUntilDone: true)
        }
        registerCell(self.myTableView, cell: MainTableViewCell.self)
        self.myTableView.delegate = self.delegate
        self.myTableView.dataSource = self.delegate
        self.myTableView.backgroundColor = grayBgColor
        setExtraCellLineHidden(tableView: self.myTableView)
//        self.myTableView.mas_makeConstraints { (make: MASConstraintMaker? ) in
//            make?.top.mas_equalTo()
//            make?.left.right().bottom().mas_offset()
//        }
        
        
    }
    @objc func refreshUI(object: AnyObject?) {
        
        let indexPath = object as? NSIndexPath
        self.dataSource.removeObject(at: (indexPath?.row)!)
        //2.reload
        //直接使用reload方法界面的变化非常迅速，用户体验非常不好
        //                self.tableView.reloadData()
        //这个具有动画效果
        self.myTableView.deleteRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
    }
    func initdataSource()  {
        self.dataSource = NSMutableArray()
        let titleArray = ["swift二维码","swift条码","数据库","web页面","http","swift二维码","字符判断获取验证码","陀螺仪小球","下载","图片放大","SnapKit","GCD","newIcon","swiftWeb","GuidancePage","HMSegmented","UIPresentation","设置手势","确认手势","gotoUITextField","IrregularLabel","人脸识别","城市定位","优酷视频","扇形图","自定义日历"]
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
        }else if str == "字符判断获取验证码"{
            gotoCharacterJudgmentViewController()
        }else if str == "陀螺仪小球"{
            gotoSmallBallViewController()
        }else if str == "下载"{
            gotoDownloadViewController()
        }else if str == "图片放大"{
            gotoBigImageViewController()
        }else if str == "SnapKit"{
            gotoSnapKit()
        }else if str == "GCD"{
            gotoGCD()
        }else if str == "newIcon"{
            gotonewIcon()
        }else if str == "swiftWeb"{
            gotoSwiftWeb()
        }else if str == "GuidancePage"{
            gotoGuidancePage()
        }else if str == "HMSegmented"{
            gotoHMSegmented()
        }else if str == "UIPresentation"{
            gotoUIPresentation()
        }else if str == "设置手势"{
            gotoYZXUnlock(isSuss: true)
        }else if str == "确认手势"{
            gotoYZXUnlock(isSuss: false)
        }else if str == "gotoUITextField"{
            gotoUITextField(isSuss: false)
        }else if str == "IrregularLabel"{
            gotoIrregularLabel()
        }else if str == "人脸识别"{
            gotoFaceRecognition()
        }else if str == "城市定位"{
            gotoUrbanPositioning()
        }else if str == "优酷视频"{
            gotoyouku()
        }else if str == "扇形图"{
            gotoSectorChartViewController()
        }else if str == "自定义日历"{
            gotoCalendarDateViewController()
        }
        
      
        
    //http://testfbci.tongwei.com/bas.mobile/download/download-attachment.do?downloadtype=0&attachmentid=5927
    }
    func gotoCalendarDateViewController() {
        let vc:CalendarDateViewController = CalendarDateViewController.createViewController(createArgs: nil) as! CalendarDateViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoyouku() {
        let vc:YouKuViewController = YouKuViewController.createViewController(withVid: "", platform: "", quality: "") as! YouKuViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoUrbanPositioning() {
        let vc:UrbanPositioningViewController=UrbanPositioningViewController.createViewController(createArgs: nil) as! UrbanPositioningViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoFaceRecognition() {
        let vc:FaceRecognitionViewController=FaceRecognitionViewController.createViewController(createArgs: nil) as! FaceRecognitionViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoIrregularLabel() {
        let vc:IrregularLabelViewController=IrregularLabelViewController.createViewController(createArgs: nil) as! IrregularLabelViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    
    func gotoUITextField(isSuss:Bool) {
        let vc:UITextFieldViewController=UITextFieldViewController.createViewController(createArgs: nil) as! UITextFieldViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoYZXUnlock(isSuss:Bool) {
        let vc:YZXUnlockViewController=YZXUnlockViewController.createViewController(createArgs: nil) as! YZXUnlockViewController
        vc.settingGesture = isSuss
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoUIPresentation() {
        let vc:UIPresentationViewController=UIPresentationViewController.createViewController(createArgs: nil) as! UIPresentationViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoHMSegmented() {
        let vc:HMSegmentedViewController=HMSegmentedViewController.createViewController(createArgs: nil) as! HMSegmentedViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    
    func gotoGuidancePage() {
        let vc:GuidancePageViewController=GuidancePageViewController.createViewController(createArgs: nil) as! GuidancePageViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoSwiftWeb() {
        let vc:SwiftWebViewController=SwiftWebViewController.createViewController(createArgs: nil) as! SwiftWebViewController
        vc.url = "https://www.hstd.com/mobileHtml/appvoal/myappoval/view/common.html?userId=test02"
        vc.canDownRefresh = true
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotonewIcon() {
        let vc:NewAppIconViewController=NewAppIconViewController.createViewController(createArgs: nil) as! NewAppIconViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoGCD() {
        let vc:GCDFuncViewController=GCDFuncViewController.createViewController(createArgs: nil) as! GCDFuncViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoSnapKit() {
        let vc:SnapKitViewController=SnapKitViewController.createViewController(createArgs: nil) as! SnapKitViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
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
        vc.delegateFont = self
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func fontSizeDidChange(controllerR: HttpViewController, fontSize: Int, fontColor: UIColor) {
        print(fontSize)
    }
    
    func gotoCharacterJudgmentViewController(){
        let vc:CharacterJudgmentViewController = CharacterJudgmentViewController.createViewController(createArgs: nil) as! CharacterJudgmentViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoSmallBallViewController(){
        let vc:SmallBallViewController = SmallBallViewController.createViewController(createArgs: nil) as! SmallBallViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoDownloadViewController(){
//        let vc:DownloadViewController = DownloadViewController.parentViewController(createArgs: nil) as! DownloadViewController
//        vc.hidesBottomBarWhenPushed = true
//        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoBigImageViewController(){
        let vc:BigImageViewController = BigImageViewController.createViewController(createArgs: nil) as! BigImageViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoSectorChartViewController(){
        let vc:SectorChartViewController = SectorChartViewController.createViewController(createArgs: nil) as! SectorChartViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController: vc, animated: true)
    }

}
class MainViewControllerDelegate: BaseOneTableViewDelegate {
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
