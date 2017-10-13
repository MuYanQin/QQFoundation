//
//  QQDevice.m
//  QQUIKit
//
//  Created by ZhangQun on 2017/3/29.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "QQDevice.h"

@implementation QQDevice
+ (CGFloat)GetSystemVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
+ (NSString *)AppName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];    //获取App名称
}
+ (NSString *)APPBundleID
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
+ (NSString *)APPBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
+ (NSString *)APPVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
@end
