//
//  QQAppDefine.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/6/6.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#ifndef QQAppDefine_h
#define QQAppDefine_h

#define QQWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define onePoint (1 / [UIScreen mainScreen].scale)



#define VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define KScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define KScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define kIs_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define MCNavHeight  (kIs_iPhoneX ?(88):(64))
#define MCTabbarHeight  (kIs_iPhoneX?83:49)
#define MCBottomDistance  (kIs_iPhoneX?34:0)

#if DEBUG
#define MCLog(...) NSLog(__VA_ARGS__)
#else
#define MCLog(...)
#endif


#endif /* QQAppDefine_h */
