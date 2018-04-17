//
//  YouKuViewController.m
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/4/17.
//  Copyright © 2018年 yin chen. All rights reserved.
//

#import "YouKuViewController.h"
//#import "YTEngineOpenViewManager.h"
//#import "YYMediaPlayerEvents.h"


#define MARGIN (DEVICE_TYPE_IPAD ? 15 : 10)
#define BACK_WIDTH (DEVICE_TYPE_IPAD ? 30 : 20)
#define TEXTVIEW_FONT (DEVICE_TYPE_IPAD ? 15 : 12)
#define TEXTVIEW_WIDTH (DEVICE_TYPE_IPAD ? 400 : 250)
#define TEXTVIEW_HEIGHT (DEVICE_TYPE_IPAD ? 45 : 30)
#define TOPVIEW_HEIGHT_SMALL (DEVICE_TYPE_IPAD ? 54 : 44)
#define TOPVIEW_HEIGHT_FULL (DEVICE_TYPE_IPAD ? 88 : 50)
#define STATUS_HEIGHT (DEVICE_TYPE_IPAD ? 25 : 20)


@interface YouKuViewController ()
@property (nonatomic, strong) NSString *itemid; //视频id
@property (nonatomic, strong) NSString *itemPf; // 播放平台
@property (nonatomic, strong) NSString *itemQuality; // 清晰度
//@property (nonatomic, strong) YTEngineOpenViewManager *viewManager;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITextView *textView;
//@property (nonatomic, strong) YYMediaPlayer *cloudPlayer;
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, assign) CGRect playerFrame;
@property (nonatomic, assign) CGRect cloudPlayerFrame;
@end

@implementation YouKuViewController

//@synthesize player = _player;
//@synthesize islocal;
//@synthesize videoItem;

#pragma mark - init & dealloc
+(UIViewController *)createViewControllerWithVid:(NSString *)vid platform:(NSString *)platform quality:(NSString *)quality{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YouKuViewController" bundle:nil];
    YouKuViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"YouKuViewController"];
    vc.itemid = vid;
    vc.itemPf = platform;
    vc.itemQuality = quality;
    NSLog(@"videoid:%@, platform:%@, quality:%@",vid,platform,quality);
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenChangeButtonClicked) name:kYYScreenChangeButtonClickedNotification object:nil];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)screenChangeButtonClicked {
    //NSLog(@"ZN screen did clicked, old screen status:%@",self.player.fullscreen ? @"full" : @"small");
}

@end
