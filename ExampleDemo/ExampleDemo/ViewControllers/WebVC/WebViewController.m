//
//  WebViewController.m
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/4.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
@interface WebViewController ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIGestureRecognizerDelegate>{
    MBProgressHUD *hud;
    NSString *urlStr;
}

@end

@implementation WebViewController
+(UIViewController *)createViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WebViewController" bundle:nil];
    WebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
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



@end
