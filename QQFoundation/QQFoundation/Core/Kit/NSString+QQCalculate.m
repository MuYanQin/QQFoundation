//
//  NSString+QQCalculate.m
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/14.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "NSString+QQCalculate.h"

@implementation NSString (QQCalculate)


- (BOOL)IsNumbersAndChinese{
    NSString *bankNum=@"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
/**
 * 是否为数字
 */
-(BOOL)isNumbers{
    NSString *carRegex = @"^[0-9]*$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}
/**
  去除所有空格
 */
- (NSString *)DeleteAllSpace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
/*
 去除字符串首位的空格
 */
- (NSString *)TrimStringHAT{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
/*
 计算字符串高度
 */
- (CGFloat)GetTextHeight:(CGFloat)width font:(CGFloat)font{
    CGFloat autoheight;
    
    autoheight =[self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font] } context:nil].size.height;
    return autoheight;
}
/*
 计算字符串宽度
 */
- (CGFloat)GetTextWidth:(CGFloat)height font:(CGFloat)font{
    CGFloat autowidth;
    
    autowidth =[self boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font] } context:nil].size.width;
    return autowidth;
}

@end
