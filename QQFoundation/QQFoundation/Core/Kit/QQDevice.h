//
//  QQDevice.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/3/29.
//  Copyright © 2017年 Yuan er. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QQDevice : NSObject

/**
 获取系统版本

 @return 返回系统版本号
 */
+ (CGFloat)systemVersion;

/**
 获取app名称
 
 @return app名称
 */
+ (NSString *)AppName;

/**
 获取Bundleid
 
 @return Bundleid
 */
+ (NSString *)APPBundleID;

/**
 appbuild几次
 
 @return 次数
 */
+ (NSString *)APPBuild;

/**
 app当前版本号
 
 @return 版本号
 */
+ (NSString *)APPVersion;
@end
