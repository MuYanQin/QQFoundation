//
//  UIImage+Usually.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Usually)
/**
 获取灰色的图片
 */
+ (UIImage*)getGrayImage:(UIImage*)sourceImage;

/**
 传入字符串获取二维码

 @param string 要处理的字符串

 @return 二维码
 */
+ (UIImage *)SetQrcodeImageWithString:(NSString *)string;

/**
 *  @brief  通过路径加载图片 图片一定不能在Assets中
 *
 *  @param imageName 图片名
 *
 *  @return UIImage实例
 */
+ (UIImage *)imageWithName:(NSString *)imageName;

//圆角切割
- (UIImage *)QQ_getCornerRadius:(CGFloat)cornerRadius;
@end
