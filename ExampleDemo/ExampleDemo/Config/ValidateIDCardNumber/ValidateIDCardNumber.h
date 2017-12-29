//
//  ValidateIDCardNumber.h
//  CarRental
//
//  Created by xiejiangbo on 2017/5/18.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateIDCardNumber : NSObject
+ (ValidateIDCardNumber *)ShareValidateIDCardNumber;
-(BOOL)checkUserIDCard:(NSString *)userID ;
@end
