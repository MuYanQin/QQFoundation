//
//  UIColor+Hexadecimal.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hexadecimal)
/**
 *  @brief  根据十六进制配色数值返回颜色对象
 *
 *  @param hex 十六进制配色数值
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

/**
 *  @brief  根据十六进制配色字符串返回颜色对象
 *
 *  @param string 十六进制配色字符串
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)string;

/** RGBA返回颜色对象（R、G、B在0~255） */
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;

/**
 颜色返回图片

 @param color 颜色
 @return 纯颜色的图片
 */
- (UIImage *)createImageWithColor:(UIColor *)color;
@end
