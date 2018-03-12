//
//  DownloadViewController.m
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/2/5.
//  Copyright © 2018年 yin chen. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()<NSURLSessionDownloadDelegate>

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)downloadFileWithURL:(NSString *)urlStr{
    
    //默认配置
    
    NSURLSessionConfiguration *configuration= [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //得到session对象
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // url
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建任务
    
    NSURLSessionDownloadTask* downloadTask = [session downloadTaskWithURL:url];
    
    //开始任务
    
    [downloadTask resume];
    
}

#pragma mark -- NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask

didFinishDownloadingToURL:(NSURL *)location{
    
    NSError *saveError;
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *savePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.amr",@"xiazai"]];
    
    NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
    
    //把下载的内容从cache复制到document下
    
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
                                                    
                                                                    
    if (!saveError) {
        
        NSLog(@"save success");
        
    }else{
        
        NSLog(@"save error:%@",saveError.localizedDescription);
        
    }
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask

      didWriteData:(int64_t)bytesWritten

 totalBytesWritten:(int64_t)totalBytesWritten

totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    NSLog(@"%@",[NSString stringWithFormat:@"下载进度:%f",(double)totalBytesWritten/totalBytesExpectedToWrite]);
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask

 didResumeAtOffset:(int64_t)fileOffset

expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}


@end
