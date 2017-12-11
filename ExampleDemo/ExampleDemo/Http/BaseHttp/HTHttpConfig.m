//
//  HTHttpConfig.m
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "HTHttpConfig.h"
static NSString const * kPVHttpConfig_AccessToken = @"kPVHttpConfig_AccessToken";
static NSString const *kRegisterKey = @"HTHttpConfig";
//内网
static NSString const *kServiceAddressURL = @"http://222.66.127.246:7001/sapb1";
//static NSString const *kServiceAddressURL = @"https://www.wingmediadream.com/wingmedia/v1";
//外网
//static NSString const *kServiceAddressURL2 = @"https://www.wingmediadream.com/wingmedia/v1";
static NSString const *kServiceAddressURL2 = @"http://222.66.127.246:7001/sapb1";
@implementation HTHttpConfig
+(HTHttpConfig *)sharedInstance
{
    static HTHttpConfig *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedInstance = [[HTHttpConfig alloc] init];
    });
    return _sharedInstance;
}

-(NSString const *)getServerAddress:(NSString *)addressKey{
    if (self.isout) {
        return kServiceAddressURL2;
    }
    return kServiceAddressURL;
}

+(const NSString *)registerKey{
    return kRegisterKey;
}

-(NSString *)accessToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:(NSString *)kPVHttpConfig_AccessToken];
}

-(void)setAccessToken:(NSString *)accessToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:accessToken forKey:(NSString *)kPVHttpConfig_AccessToken];
}
@end
