//
//  UIImage+Usually.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 Yuan er. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Usually)
/**
 获取灰色的图片
 */
+ (UIImage*)grayImage:(UIImage*)sourceImage;

/**
 传入字符串获取二维码

 @param string 要处理的字符串

 @return 二维码
 */
+ (UIImage *)qrcodeImageWithString:(NSString *)string;

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

/*
 返回100k以内大小的图片
 */
+(NSData *)imageData:(UIImage *)myimage;


/// 根据本地路径获取视频的第一帧
/// @param url 路径地址
+ (UIImage*)videoPreViewImage:(NSURL *)url;
@end

@interface UIImage (Luban_iOS_Extension_h)

+ (NSData *)lubanCompressImage:(UIImage *)image;
+ (NSData *)lubanCompressImage:(UIImage *)image withMask:(NSString *)maskName;
+ (NSData *)lubanCompressImage:(UIImage *)image withCustomImage:(NSString *)imageName;

@end
