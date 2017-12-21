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
@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong)UIWebView *uiwebView;
@end

@implementation WebViewController
+(UIViewController *)createViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WebViewController" bundle:nil];
    WebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 300)];
    label.backgroundColor = [UIColor blackColor];
    //[self.view addSubview:label];
    [self isNavigationBarObstructed];
    [self initTitleBar];
    [self addSetWebView];
    self.title = @"webVC";
}
#pragma mark ----- 添加UIWebView
-(void)addUIWebView{
    //if (@available(iOS 11.0, *)) {
    self.uiwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WHIDTH, SCREEN_HEIGHT+20)];
    //} else {
    //  self.uiwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WHIDTH, SCREEN_HEIGHT)];
    //}
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"common" withExtension:@"html" subdirectory:@"review/list/view/"];
    NSLog(@"%@",url);
    //    NSString *urlStr=[NSString stringWithFormat:@"%@?traceBackCode=%@",url,@"0108717853295782"];
    NSString *urlStr=[NSString stringWithFormat:@"%@?traceBackCode=%@",url,[AccountInfoOC ShareAccountInfoOC].qrCodeData];
    
    NSURL *url2 = [NSURL URLWithString:urlStr];
    NSLog(@"%@",url2);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url2]; // url的位置
    [self.uiwebView loadRequest:urlRequest];
    //[self.uiwebView loadHTMLString:urlStr baseURL:url2];
    self.uiwebView.scrollView.bounces = NO;
    self.uiwebView.delegate = self;
    [self.view addSubview:self.uiwebView];
    hud = [[MBProgressHUD alloc] init];
    hud.center = self.view.center;
    [self.view addSubview: hud];
    [hud setMode: MBProgressHUDModeIndeterminate];
    [hud show: YES];
    
}
#pragma mark ----- 添加UIWebViewDelegate
-(void)webView:(UIWebView*)webView DidFailLoadWithError:(NSError*)error{
    NSLog(@"error=%@",error);
}
//当网页视图被指示载入内容而得到通知。应当返回YES，这样会进行加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@",request.URL.absoluteString);
    // 拿到网页的请求地址
    NSString *URLString = request.URL.absoluteString;
    if ([URLString isEqualToString:@"rrcc://AppLogout"]) {
        [self arrowResponse];
    }
    // 判断网页的请求地址协议是否是我们自定义的那个
    //NSRange range = [URLString rangeOfString:@"hm://?src="];
    
    return YES;
}
//当网页视图已经开始加载一个请求后，得到通知。
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [hud setMode: MBProgressHUDModeIndeterminate];
    [hud show: YES];
}
//当网页视图结束加载一个请求之后，得到通知。
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [hud hide: YES];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark ----- 添加webView
-(void)addSetWebView{
    {
        // [AccountInfo sharedInstance].qrCodeData = @"";
        
        hud = [[MBProgressHUD alloc] init];
        [self.view addSubview: hud];
        
        [hud setMode: MBProgressHUDModeIndeterminate];
        [hud show: YES];
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"common" withExtension:@"html" subdirectory:@"review/list/view/"];
        NSLog(@"%@",url);
        NSString *urlStr=[NSString stringWithFormat:@"%@?traceBackCode=%@",url,[AccountInfoOC ShareAccountInfoOC].qrCodeData];
        NSURL *url2 = [NSURL URLWithString:@"https://www.baidu.com"];
        NSLog(@"%@",url2);
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url2]; // url的位置
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 设置偏好设置
        config.preferences = [[WKPreferences alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        // 默认认为YES
        config.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.processPool = [[WKProcessPool alloc] init];
        
        config.userContentController = [[WKUserContentController alloc] init];
        
        // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
        // 我们可以在WKScriptMessageHandler代理中接收到
        WKUserContentController* userContent = [[WKUserContentController alloc] init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [userContent addScriptMessageHandler:self name:@"AppLogout"];
        
        // 将UserConttentController设置到配置文件
        config.userContentController = userContent;
        //NSLog(@"==========%f%f",self.view.bounds.size.height,self.view.bounds.size.width);
        
        if (@available(iOS 11.0, *)) {
            //if ([[ModelJudgeFunc deviceModelName]isEqualToString:@"iPhoneX"]) {
            //self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, -48, SCREEN_WHIDTH, SCREEN_HEIGHT+48) configuration:config];
            //}else{
            //self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WHIDTH, SCREEN_HEIGHT+20) configuration:config];
            //}
        } else {
            //self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WHIDTH, SCREEN_HEIGHT) configuration:config];
        }
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WHIDTH, SCREEN_HEIGHT) configuration:config];
        self.webView.UIDelegate=self;
        self.webView.navigationDelegate=self;
        [self.webView loadRequest:urlRequest];
        [self.view addSubview:self.webView];
        self.webView.multipleTouchEnabled=NO;
        self.webView.backgroundColor=[UIColor clearColor];
        self.webView.UIDelegate=self;
        
        hud = [[MBProgressHUD alloc] init];
        [self.webView addSubview: hud];
        
        [hud setMode: MBProgressHUDModeIndeterminate];
        
        
        [hud show: YES];
    }
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [hud setMode: MBProgressHUDModeIndeterminate];
    [hud show: YES];
    NSString *url=webView.URL.absoluteString;
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [hud hide: YES];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",message.name);
    if ([message.name isEqualToString:@"AppLogout"]) {
        [self arrowResponse];
        //[AccountInfo sharedInstance].password = @"";
        //[[NSUserDefaults standardUserDefaults] synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
