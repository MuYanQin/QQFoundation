//
//  NSAttributedString+Easy.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSAttributedString (Easy)

/**
 设置中间横线

 @param string 哪些文字设置横线

 @return 有横线的文字
 */
+ (NSAttributedString *)SetTextLineOnMindleWith:(NSString *)string;
/**
 设置下划线
 @param string 哪些文字设置下划线
 
 @return 有下划线 的文字
 */
+ (NSAttributedString *)SetunderlineOneString:(NSString *)string;

/**
 设置文字颜色和背景

 @param TextColor 文字颜色
 @param color     背景颜色
 @param string    字符串

 @return NSAttributedString
 */
+ (NSAttributedString *)SetTextColor:(UIColor *)TextColor  BackgroundColor:(UIColor *)color  andWithString:(NSString *)string;

/**
 设置数字有颜色的

 @param NumberColor 数字的颜色
 @param Font        数字的大小
 @param string      字符串

 @return NSAttributedString
 */
+ (NSAttributedString*)SetNumberColor:(UIColor *)NumberColor NumberFont:(CGFloat)Font andWithString:(NSString *)string;

/**
 设置特定的文字有颜色

 @param color  文字的颜色
 @param str    哪些文字有颜色
 @param string 传入的字符串

 @return NSAttributedString
 */
+ (NSAttributedString *)SetTextcolor:(UIColor *)color text:(NSString *)str  andWithString:(NSString *)string;


/**
 设置图文混排 图片在前面

 @param image  图片
 @param boubds 图片的大小
 @param string 文字

 @return NSAttributedString
 */
+ (NSAttributedString *)setimage:(UIImage *)image  Bounds:(CGRect)boubds andstring:(NSString *)string;

//设置图文混排(图片在后)
+ (NSAttributedString *)setImage:(UIImage *)image  Bounds:(CGRect)bounds andString:(NSString *)string;
@end
