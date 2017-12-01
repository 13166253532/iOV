//
//  QRCodeAVCaptureDevice.m
//  SHYTB
//
//  Created by xiejiangbo on 2017/11/13.
//  Copyright © 2017年 yin chen. All rights reserved.
//
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
#define UICOLORFROMRGB(hexColor) [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1.0]
#define TOP (SCREEN_HEIGHT-220)/2
#define LEFT (SCREEN_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)
#import "QRCodeAVCaptureDevice.h"
#import <AVFoundation/AVFoundation.h>
@interface QRCodeAVCaptureDevice ()<AVCaptureMetadataOutputObjectsDelegate>{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
}
//@property (strong,nonatomic)AVCaptureDevice * device;
//@property (strong,nonatomic)AVCaptureDeviceInput * input;
//@property (strong,nonatomic)AVCaptureMetadataOutput * output;
//@property (strong,nonatomic)AVCaptureSession * session;
//@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIImageView * line;
@end
@implementation QRCodeAVCaptureDevice
+(AVCaptureVideoPreviewLayer *)getAVCaptureVideoPreviewLayer:(nullable id<AVCaptureMetadataOutputObjectsDelegate>)objectsDelegate queue:(nullable dispatch_queue_t)objectsCallbackQueue AndView:(UIView *)view{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:objectsDelegate queue:objectsCallbackQueue];
    //设置扫描区域
    CGFloat top = TOP/SCREEN_HEIGHT;
    CGFloat left = LEFT/SCREEN_WIDTH;
    CGFloat width = 220/SCREEN_WIDTH;
    CGFloat height = 220/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [output setRectOfInterest:CGRectMake(top,left, height, width)];
    // Session
    AVCaptureSession * session = [[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([session canAddInput:input])
    {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output])
    {
        [session addOutput:output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code, nil]];
    AVCaptureVideoPreviewLayer * preview =[AVCaptureVideoPreviewLayer layerWithSession: session];
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.frame = view.layer.bounds;
    // Start
    [session startRunning];
    
    return preview;
}
+(AVCaptureDevice *)getAVCaptureDevice{
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    return device;
}
//+(AVCaptureMetadataOutput *)getAVCaptureMetadataOutput{
//   AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
//    return output;
//}
@end
