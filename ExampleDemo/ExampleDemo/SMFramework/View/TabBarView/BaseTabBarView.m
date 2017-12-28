//
//  BaseTabBarView.m
//  NineClouds
//
//  Created by xiejiangbo on 2017/12/26.
//  Copyright © 2017年 yin chen. All rights reserved.
//
#define kDEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
//定义屏幕的高度
#define kDEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
#import "BaseTabBarView.h"

@interface BaseTabBarView (){
    CGFloat *bagHeight;
}
@property(nonatomic,strong)UIImageView *bagImageView;
@property(nonatomic,strong)UIButton *oneBtn;
@property(nonatomic,strong)UIButton *twoBtn;
@property(nonatomic,strong)UIButton *thrBtn;
//@property(nonatomic,strong)UIButton *forBtn;
//@property(nonatomic,strong)UIButton *fiveBtn;

@property(nonatomic,strong)UIImageView *oneImage;
@property(nonatomic,strong)UIImageView *twoImage;
@property(nonatomic,strong)UIImageView *thrImage;
//@property(nonatomic,strong)UIImageView *forImage;
//@property(nonatomic,strong)UIImageView *fiveImage;
@property(nonatomic,strong)UIImageView *fengeImage;

@property(nonatomic,strong)UILabel *oneLabel;
@property(nonatomic,strong)UILabel *twoLabel;
@property(nonatomic,strong)UILabel *thrLabel;
//@property(nonatomic,strong)UILabel *forLabel;
//@property(nonatomic,strong)UILabel *fiveLabel;
@property (strong, nonatomic)NSArray *tabBarTitle;
@property (strong, nonatomic)NSArray *tabBarNomImageArray;
@property (strong, nonatomic)NSArray *tabBarSelectImageArray;
@end
@implementation BaseTabBarView

+ (BaseTabBarView *)ShareBaseTabBarView{
    static BaseTabBarView *baseTabBarView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseTabBarView = [[BaseTabBarView alloc]init];
        baseTabBarView.tabBarTitle = @[@"待办",@"审批",@"我的"];
        baseTabBarView.tabBarNomImageArray = @[@"tabbar_pupcoming_nor",@"tabbar_approved_nor",@"tabbar_mine_nor"];
        baseTabBarView.tabBarSelectImageArray = @[@"tabbar_pupcoming_select",@"tabbar_approved_select",@"tabbar_mine_select"];
    });
    return baseTabBarView;
}
-(UIImageView *)getBaseTabBarView:(UIImageView *)bagImageView AndHeight:(CGFloat *)height{
    self.bagImageView = bagImageView;
    self.bagImageView.userInteractionEnabled = YES;
    self.bagImageView.backgroundColor = [UIColor whiteColor];
    bagHeight = height;
    [self addView];
    [self addInitView];
    [self addInitBtn];
    
    return self.bagImageView;
}

-(void)addView{
    self.fengeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bagImageView.bounds.size.width, 0.5)];
    self.fengeImage.backgroundColor = COLOR_WITH_HEX(0xD7D7D7);
    [self.bagImageView addSubview:self.fengeImage];
    
}
-(void)addInitBtn{
    
    self.oneBtn = [self getBtn];
    self.oneBtn.frame = CGRectMake(0, 0, self.bagImageView.bounds.size.width/self.tabBarTitle.count, *(bagHeight));
    [self.oneBtn addTarget:self action:@selector(oneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self oneAction];
    
    self.twoBtn = [self getBtn];
    self.twoBtn.frame = CGRectMake(self.bagImageView.bounds.size.width/self.tabBarTitle.count, 0, self.bagImageView.bounds.size.width/self.tabBarTitle.count, *(bagHeight));
    [self.twoBtn addTarget:self action:@selector(twoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.thrBtn = [self getBtn];
    self.thrBtn.frame = CGRectMake((self.bagImageView.bounds.size.width/self.tabBarTitle.count)*2, 0, self.bagImageView.bounds.size.width/self.tabBarTitle.count, *(bagHeight));
    [self.thrBtn addTarget:self action:@selector(thrBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.forBtn = [self getBtn];
//    self.forBtn.frame = CGRectMake(self.bagImageView.bounds.size.width/5*3, 0, self.bagImageView.bounds.size.width/5, self.bagImageView.bounds.size.height);
//    [self.forBtn addTarget:self action:@selector(forBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.fiveBtn = [self getBtn];
//    self.fiveBtn.frame = CGRectMake(self.bagImageView.bounds.size.width/5*4, 0, self.bagImageView.bounds.size.width/5, self.bagImageView.bounds.size.height);
//    [self.fiveBtn addTarget:self action:@selector(fiveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bagImageView addSubview:self.oneBtn];
    [self.bagImageView addSubview:self.twoBtn];
    [self.bagImageView addSubview:self.thrBtn];
//    [self.bagImageView addSubview:self.forBtn];
//    [self.bagImageView addSubview:self.fiveBtn];
}
-(UIButton *)getBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    return btn;
}
-(void)addInitView{
    CGFloat h=*(bagHeight);
    CGFloat w=self.bagImageView.bounds.size.width;
    
    self.oneImage = [[UIImageView alloc]initWithFrame:CGRectMake((w/self.tabBarTitle.count-h/2)/2, 5, h/2, h/2)];
    //self.oneImage.contentMode = UIViewContentModeScaleAspectFit;
    self.oneImage .image = [UIImage imageNamed:self.tabBarNomImageArray[0]];
    self.oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5+h/2, w/self.tabBarTitle.count, h/3)];
    self.oneLabel.text = self.tabBarTitle[0];
    self.oneLabel = [self getLabel:self.oneLabel];
    
    self.twoImage = [[UIImageView alloc]initWithFrame:CGRectMake(w/self.tabBarTitle.count+(w/self.tabBarTitle.count-h/2)/2, 5, h/2, h/2)];
    self.twoImage .image = [UIImage imageNamed:self.tabBarNomImageArray[1]];
    self.twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/self.tabBarTitle.count, 5+h/2, w/self.tabBarTitle.count, h/3)];
    self.twoLabel.text = self.tabBarTitle[1];
    self.twoLabel = [self getLabel:self.twoLabel];
    
    self.thrImage = [[UIImageView alloc]initWithFrame:CGRectMake(w/self.tabBarTitle.count*2+(w/self.tabBarTitle.count-h/2)/2, 5, h/2, h/2)];
    self.thrImage .image = [UIImage imageNamed:self.tabBarNomImageArray[2]];
    self.thrLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/self.tabBarTitle.count*2, 5+h/2, w/self.tabBarTitle.count, h/3)];
    self.thrLabel.text = self.tabBarTitle[2];
    self.thrLabel = [self getLabel:self.thrLabel];
    
    
//    self.forImage = [[UIImageView alloc]initWithFrame:CGRectMake(w/5*3+(w/5-h/2)/2, 5, h/2, h/2)];
//    self.forImage .image = [UIImage imageNamed:@"Control_image"];
//    self.forLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/5*3, 5+h/2, w/5, h/3)];
//    self.forLabel.text = @"控制";
//    self.forLabel = [self getLabel:self.forLabel];
    
//    self.fiveImage = [[UIImageView alloc]initWithFrame:CGRectMake(w/5*4+(w/5-h/2)/2, 5, h/2, h/2)];
//    self.fiveImage .image = [UIImage imageNamed:@"Bluetooth_key"];
//    self.fiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/5*4, 5+h/2, w/5, h/3)];
//    self.fiveLabel.text = @"蓝牙钥匙";
//    self.fiveLabel = [self getLabel:self.fiveLabel];
    
    [self.bagImageView addSubview:self.oneImage];
    [self.bagImageView addSubview:self.twoImage];
    [self.bagImageView addSubview:self.thrImage];
//    [self.bagImageView addSubview:self.forImage];
//    [self.bagImageView addSubview:self.fiveImage];
    
    [self.bagImageView addSubview:self.oneLabel];
    [self.bagImageView addSubview:self.twoLabel];
    [self.bagImageView addSubview:self.thrLabel];
//    [self.bagImageView addSubview:self.forLabel];
//    [self.bagImageView addSubview:self.fiveLabel];
    
}
-(UILabel *)getLabel:(UILabel *)label{
    label.textColor = COLOR_WITH_HEX(0x999999);
    label.font = [UIFont boldSystemFontOfSize:10];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
-(void)oneBtnAction:(UIButton *)sender{
    [self.delegate getIndex:0];
    [self initAllView];
    [self oneAction];
}
-(void)oneAction{
    [self selecLabelImage:self.oneLabel andImage:self.oneImage andImageName:self.tabBarSelectImageArray[0]];
}
-(void)twoBtnAction:(UIButton *)sender{
    [self.delegate getIndex:1];
    [self initAllView];
    [self twoAction];
}

-(BOOL)isExpired:(NSString *)time{
    NSDateFormatter *dformatters = [[NSDateFormatter alloc]init];
    dformatters.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *newDate = [[NSDate alloc]init];
    NSDate *date1 = [dformatters dateFromString:time];
    if ([date1 compare:newDate] == NSOrderedAscending) {
        return NO;
    }else if([date1 compare:newDate] == NSOrderedDescending){
        return YES;
    }else if([date1 compare:newDate] == NSOrderedSame){
        
    }
    return YES;
}
-(BOOL)isStartTime:(NSString *)time{
    NSDateFormatter *dformatters = [[NSDateFormatter alloc]init];
    dformatters.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *newDate = [[NSDate alloc]init];
    NSDate *date1 = [dformatters dateFromString:time];
    if ([date1 compare:newDate] == NSOrderedAscending) {
        return YES;
    }else if([date1 compare:newDate] == NSOrderedDescending){
        return NO;
    }else if([date1 compare:newDate] == NSOrderedSame){
        
    }
    return NO;
}

-(void)twoAction{
    [self selecLabelImage:self.twoLabel andImage:self.twoImage andImageName:self.tabBarSelectImageArray[1]];
}
-(void)thrBtnAction:(UIButton *)sender{

    [self.delegate getIndex:2];
    [self initAllView];
    [self thrAction];
}
-(void)thrAction{
    [self selecLabelImage:self.thrLabel andImage:self.thrImage andImageName:self.tabBarSelectImageArray[2]];
}
-(void)forBtnAction:(UIButton *)sender{
    [self.delegate getIndex:3];
    [self initAllView];
    [self forAction];
}
-(void)forAction{
    //[self selecLabelImage:self.forLabel andImage:self.forImage andImageName:@"Control_Selecimage"];
}
-(void)fiveBtnAction:(UIButton *)sender{
    [self.delegate getIndex:4];
    [self initAllView];
    [self fiveAction];
}
-(void)fiveAction{
    //[self selecLabelImage:self.fiveLabel andImage:self.fiveImage andImageName:@"Bluetooth_Seleckey"];
}
-(void)selecLabelImage:(UILabel *)label andImage:(UIImageView *)image andImageName:(NSString *)imageName{
    label.textColor = COLOR_WITH_HEX(0x009BF0);
    image.image = [UIImage imageNamed:imageName];
}

-(void)nomLabelImage:(UILabel *)label andImage:(UIImageView *)image andImageName:(NSString *)imageName{
    label.textColor = COLOR_WITH_HEX(0x999999);
    image.image = [UIImage imageNamed:imageName];
}
-(void)initAllView{
    [self nomLabelImage:self.oneLabel andImage:self.oneImage andImageName:self.tabBarNomImageArray[0]];
    [self nomLabelImage:self.twoLabel andImage:self.twoImage andImageName:self.tabBarNomImageArray[1]];
    [self nomLabelImage:self.thrLabel andImage:self.thrImage andImageName:self.tabBarNomImageArray[2]];
    //[self nomLabelImage:self.forLabel andImage:self.forImage andImageName:@"Control_image"];
    //[self nomLabelImage:self.fiveLabel andImage:self.fiveImage andImageName:@"Bluetooth_key"];
}


@end
