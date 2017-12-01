//
//  QRCodeAVCaptureDevice.h
//  SHYTB
//
//  Created by xiejiangbo on 2017/11/13.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface QRCodeAVCaptureDevice : NSObject
+(AVCaptureDevice *_Nullable)getAVCaptureDevice;
+(AVCaptureVideoPreviewLayer *_Nullable)getAVCaptureVideoPreviewLayer:(nullable id<AVCaptureMetadataOutputObjectsDelegate>)objectsDelegate queue:(nullable dispatch_queue_t)objectsCallbackQueue AndView:(UIView *_Nullable)view;
//+(AVCaptureDeviceInput *)getAVCaptureDeviceInput:(AVCaptureDevice *)device;
//+(AVCaptureMetadataOutput *)getAVCaptureMetadataOutput;
@end
