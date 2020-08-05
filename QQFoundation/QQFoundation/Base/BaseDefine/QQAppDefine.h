//
//  QQAppDefine.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/6/6.
//  Copyright © 2017年 Yuan er. All rights reserved.
//

#ifndef QQAppDefine_h
#define QQAppDefine_h

#define QQWeakSelf  __weak __typeof(&*self)weakSelf = self;

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define onePoint (1 / [UIScreen mainScreen].scale)



#define VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define KScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define KScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#define MCStatueBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height


#define MCBottomDistance ((MCStatueBarHeight>20) ? 34.0 : 0)

#define MCNavHeight ((MCStatueBarHeight>20) ? 88.0 : 64.0)
#define MCTabbarHeight 49

#if DEBUG
#define MCLog(...) NSLog(__VA_ARGS__)
#else
#define MCLog(...)
#endif


#endif /* QQAppDefine_h */
