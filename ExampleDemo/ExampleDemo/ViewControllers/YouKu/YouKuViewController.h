//
//  YouKuViewController.h
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/4/17.
//  Copyright © 2018年 yin chen. All rights reserved.
//

#import "BaseOCViewController.h"

@interface YouKuViewController : BaseOCViewController

@property (nonatomic, assign) BOOL islocal;
@property (nonatomic, retain) id videoItem;

+(UIViewController *)createViewControllerWithVid:(NSString *)vid platform:(NSString *)platform quality:(NSString *)quality;
@end
