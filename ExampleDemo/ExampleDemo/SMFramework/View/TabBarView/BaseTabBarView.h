//
//  BaseTabBarView.h
//  NineClouds
//
//  Created by xiejiangbo on 2017/12/26.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseTabBarViewDelegate <NSObject>

-(void)getIndex:(int)index;
@end

@interface BaseTabBarView : NSObject
@property(nonatomic,weak)id<BaseTabBarViewDelegate>delegate;
+ (BaseTabBarView *)ShareBaseTabBarView;
-(UIImageView *)getBaseTabBarView:(UIImageView *)bagImageView AndHeight:(CGFloat *)height;
//-(void)initAllView;
-(void)oneAction;
-(void)twoAction;
-(void)thrAction;
-(void)forAction;
-(void)fiveAction;

@end
