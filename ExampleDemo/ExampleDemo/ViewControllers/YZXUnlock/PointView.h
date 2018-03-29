//
//  PointView.h
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/29.
//  Copyright © 2018年 yin chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                       withID:(NSString *)ID;
@property (nonatomic, copy, readonly) NSString             *ID;

//选中
@property (nonatomic, assign) BOOL             isSelected;
//解锁失败
@property (nonatomic, assign) BOOL             isError;
//解锁成功
@property (nonatomic, assign) BOOL             isSuccess;
@end
