//
//  QRCodeViewController.swift
//  SHYTB
//
//  Created by xiejiangbo on 2017/11/9.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
import AVFoundation
class QRCodeViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var captureDevice:AVCaptureDevice!//捕获设备，默认后置摄像头
    //var input:AVCaptureDeviceInput!//输入设备
    //var output:AVCaptureMetadataOutput!//输出设备，需要指定他的输出类型及扫描范围
    //var session:AVCaptureSession!//AVFoundation框架捕获类的中心枢纽，协调输入输出设备以获得数据
    var previewLayer:AVCaptureVideoPreviewLayer!//展示捕获图像的图层，是CALayer的子类
    //相机显示视图
    let cameraView = ScannerBackgroundView(frame: UIScreen.main.bounds)
    let captureSession = AVCaptureSession()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let vc:QRCodeViewController=storyboard.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.scannerStart()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        //hideNavigationBar()
        self.view.addSubview(cameraView)
        initTitleBar()
        initAddQRCodeAVCaptureDevice()
        //addInitCameraView()
        //scaning()
    }
    func addInitCameraView(){
        
        //初始化捕捉设备（AVCaptureDevice），类型AVMdeiaTypeVideo
        //captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        self.captureDevice = QRCodeAVCaptureDevice.getAVCaptureDevice()
        //QRCodeAVCaptureDevice.getAVCaptureVideoPreviewLayer(self, queue: DispatchQueue.main, andView: cameraView)
        self.captureDevice = AVCaptureDevice.default(for: .video)
        //let input :AVCaptureDeviceInput
        //创建媒体数据输出流
        let output = AVCaptureMetadataOutput()
        //捕捉异常
        do{
            //创建输入流
           let input = try AVCaptureDeviceInput.init(device: captureDevice)
            captureSession.canSetSessionPreset(.high)
            //把输入流添加到会话
            captureSession.addInput(input)
            //把输出流添加到会话
            captureSession.addOutput(output)
        }catch {
            print("异常")
        }
        //创建串行队列
        //let dispatchQueue = DispatchQueue(label: "queue", attributes: [])
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self as AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.main)
        //设置输出媒体的数据类型
        output.metadataObjectTypes = NSArray(array: [AVMetadataObject.ObjectType.qr,AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.code128]) as! [AVMetadataObject.ObjectType]
        //创建预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //设置预览图层的填充方式
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //设置预览图层的frame
        videoPreviewLayer.frame = cameraView.bounds
        //将预览图层添加到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer, at: 0)
        //设置扫描范围
        output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
       
    }
    func scannerStart(){
        captureSession.startRunning()
        cameraView.scanning = "start"
    }
    
    func scannerStop() {
        captureSession.stopRunning()
        cameraView.scanning = "stop"
    }
    func initAddQRCodeAVCaptureDevice(){
        previewLayer = QRCodeAVCaptureDevice.getAVCaptureVideoPreviewLayer(self, queue: DispatchQueue.main, andView: cameraView)
         cameraView.layer.insertSublayer(previewLayer, at: 0)
    }
    //扫描代理方法
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        print("_______")
        
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData : AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            print(metaData.stringValue ?? String())
            captureSession.stopRunning()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
