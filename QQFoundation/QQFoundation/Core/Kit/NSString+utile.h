//
//  NSString+utile.h
//  QQFoundation
//
//  Created by leaduMac on 2020/8/9.
//  Copyright © 2020 慕纯. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (utile)
/**
 * 是否为数字
 */
- (BOOL)isNumbers;

/**
 去除所有空格

 @return string
 */
- (NSString *)deleteAllSpace;
/**
 去除字符串首位的空格

 @return 去除空格口德字符串
 */
- (NSString *)trimStringHAT;

/// md5加密
- (NSString *)md5;

/// base64 加密
- (NSString *)base64;
/**
 计算字符串高度

 @param width 控件的宽度
 @param font 字体大小
 @return 高度
 */
- (CGFloat)textHeight:(CGFloat)width font:(CGFloat)font;
/**
 计算字符串宽度
 
 @param height 控件的高度
 @param font 字体大小
 @return 宽度
 */
- (CGFloat)textWidth:(CGFloat)height font:(CGFloat)font;
@end

NS_ASSUME_NONNULL_END
