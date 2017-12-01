//
//  QRCodeTwoViewController.m
//  SHYTB
//
//  Created by xiejiangbo on 2017/11/9.
//  Copyright © 2017年 yin chen. All rights reserved.
//
/**
 *  屏幕 高 宽 边界
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds

#define HEIGHT_RATIO [UIScreen mainScreen].bounds.size.height/736
#define WHIDTH_RATIO  [UIScreen mainScreen].bounds.size.width/414

#define UICOLORFROMRGB(hexColor) [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1.0]
#define TOP (SCREEN_HEIGHT-220)/2
#define LEFT (SCREEN_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)
#import "QRCodeTwoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "WebViewController.h"
#import "AccountInfoOC.h"
#import "UIView+Additions.h"


@interface QRCodeTwoViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIImageView * line;
@end

@implementation QRCodeTwoViewController

+(UIViewController *)createViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QRCodeTwoViewController" bundle:nil];
    QRCodeTwoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"QRCodeTwoViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    //self.view.backgroundColor = [UIColor redColor];
    [self configView];
    [self setCropRect:kScanRect];
    //[self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.3];

    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        // 无权限 引导去开启
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请开启设备相机权限" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self arrowResponse];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }else{
         [self setupCamera];
    }
   
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initReturnBtn];
    [self defaultBackButtonItem];
    [self initTitleBarColor];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)initTitleBarColor{
    NSDictionary *dict = @{ NSUnderlineColorAttributeName: [UIColor whiteColor],NSFontAttributeName: [UIFont systemFontOfSize:20] };
    self.navigationController.navigationBar.titleTextAttributes = dict;
}
-(void)initReturnBtn{
    UIBarButtonItem *leftN = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return_image"] style:UIBarButtonItemStylePlain target:self action:@selector(arrowResponse)];
    self.navigationItem.leftBarButtonItem = leftN;
}
-(void)arrowResponse{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)defaultBackButtonItem{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = UICOLORFROMRGB(0x007bc9);
    self.navigationController.navigationBar.subviews[0].backgroundColor = UICOLORFROMRGB(0x007bc9);
}

-(void)configView{

    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.originY-40*HEIGHT_RATIO, SCREEN_WIDTH, 15*HEIGHT_RATIO)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"请对准条码到框内即可扫描";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:label];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }else {
        num --;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}


- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    
    
    [cropLayer setNeedsDisplay];
    NSLog(@"1");
    [self.view.layer addSublayer:cropLayer];
}

- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/SCREEN_HEIGHT;
    CGFloat left = LEFT/SCREEN_WIDTH;
    CGFloat width = 220/SCREEN_WIDTH;
    CGFloat height = 220/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"扫描结果：%@",stringValue);
        [AccountInfoOC ShareAccountInfoOC].qrCodeData = stringValue;
        NSArray *arry = metadataObject.corners;
        for (id temp in arry) {
            //NSLog(@"%@",temp);
        }
        
        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:stringValue preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            if (_session != nil && timer != nil) {
//                [_session startRunning];
//                [timer setFireDate:[NSDate date]];
//            }
//
//        }]];
        WebViewController *web = [[WebViewController alloc]init];
        web.pushClass = @"0";
        [self.navigationController pushViewController:web animated:YES];

        
    } else {
        NSLog(@"无扫描信息");
        return;
    }
    
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _output = nil;
    _preview = nil;
    NSLog(@"QR页面销毁2");
}

-(void)dealloc{
    NSLog(@"QR页面销毁");
    NSLog(@"------------------------");
    NSLog(@"%@",self.classForCoder);
    NSLog(@"------------------------");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
