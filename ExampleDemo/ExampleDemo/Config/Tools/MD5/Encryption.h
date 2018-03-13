//
//  Encryption.h
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/3/13.
//  Copyright © 2018年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject
//md5加密方法
+ (NSString *)md5EncryptWithString:(NSString *)string;
@end
