//
//  NSString+QQCalculate.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/14.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (QQCalculate)

/**
 * 是否为数字和字母
 */
- (BOOL)IsNumbersAndChinese;
/**
 * 是否为数字
 */
- (BOOL)isNumbers;

/**
 去除所有空格

 @return string
 */
- (NSString *)DeleteAllSpace;
/**
 去除字符串首位的空格

 @return 去除空格口德字符串
 */
- (NSString *)TrimStringHAT;
/**
 计算字符串高度

 @param width 控件的宽度
 @param font 字体大小
 @return 高度
 */
- (CGFloat)GetTextHeight:(CGFloat)width font:(CGFloat)font;
/**
 计算字符串宽度
 
 @param height 控件的高度
 @param font 字体大小
 @return 宽度
 */
- (CGFloat)GetTextWidth:(CGFloat)height font:(CGFloat)font;

@end
