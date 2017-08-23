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
@end
