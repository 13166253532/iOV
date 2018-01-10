//
//  CharacterJudgment.h
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/1/10.
//  Copyright © 2018年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterJudgment : NSObject
//只能输入纯数字
+ (BOOL)validateNumber:(NSString*)number;
+ (BOOL)onlyNumbers:(NSString*)number;
//只能输入纯大小写字母
+ (BOOL)onlyLetters:(NSString *)letters;
@end
