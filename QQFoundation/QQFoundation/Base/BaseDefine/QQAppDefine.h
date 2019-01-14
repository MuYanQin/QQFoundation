//
//  QQAppDefine.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/6/6.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#ifndef QQAppDefine_h
#define QQAppDefine_h

#define QQWeakSelf  __weak __typeof(&*self)weakSelf = self;

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define onePoint (1 / [UIScreen mainScreen].scale)



#define VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define KScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define KScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define MCStatueBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height


//iPhoneX系列
#define Height_StatusBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)

#define MCBottomDistance ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 34.0 : 0)

#define MCNavHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
#define MCTabbarHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)

#if DEBUG
#define MCLog(...) NSLog(__VA_ARGS__)
#else
#define MCLog(...)
#endif


#endif /* QQAppDefine_h */
