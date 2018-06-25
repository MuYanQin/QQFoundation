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
#define VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//按比例获取高度
#define  WGiveHeight(HEIGHT) HEIGHT * [UIScreen mainScreen].bounds.size.height/568.0
//按比例获取宽度
#define  WGiveWidth(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/320.0
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#if DEBUG
#define QQLog(...) NSLog(__VA_ARGS__)
#else
#define QQLog(...)
#endif


#endif /* QQAppDefine_h */
