//
//  CharacterJudgment.m
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/1/10.
//  Copyright © 2018年 yin chen. All rights reserved.
//
#define NUMBER @"0123456789"
#define LETTER @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#import "CharacterJudgment.h"
@interface CharacterJudgment()<UITextFieldDelegate>

@end


@implementation CharacterJudgment
//只能输入纯数字
+ (BOOL)validateNumber:(NSString*)number{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+(BOOL)onlyNumbers:(NSString*)number{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBER] invertedSet];
    NSString *filtered = [[number componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [number isEqualToString:filtered];
}

//只能输入纯大小写字母
+(BOOL)onlyLetters:(NSString *)letters{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:LETTER] invertedSet];
    NSString *filtered = [[letters componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [letters isEqualToString:filtered];
}

@end
