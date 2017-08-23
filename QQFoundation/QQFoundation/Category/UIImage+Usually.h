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
 *  @brief  通过路径加载图片
 *
 *  @param imageName 图片名
 *
 *  @return UIImage实例
 */
+ (UIImage *)imageWithName:(NSString *)imageName;
/**
 *  @brief  将图片压缩后保存到本地
 *
 *  @param currentImage 目标图片
 *  @param imageName    图片名
 *  @param resultSize   目标大小
 *
 *  @return 保存是否成功
 */
- (BOOL)saveImage:(UIImage *)currentImage withName:(NSString *)imageName resultSize:(CGFloat)resultSize;


/**
 图片等比缩放

 @param size 需要缩放到什么size

 @return 返回缩放后的图片
 */
- (UIImage *)QQ_cropSameImageToSize:(CGSize)size;
/**
 非等比缩放
 @param size 需要缩放到什么size
 
 @return 返回缩放后的图片
 */
- (UIImage *)QQ_noSameImageToSize:(CGSize)size;
//圆角切割
- (UIImage *)QQ_getCornerRadius:(CGFloat)cornerRadius;
@end
