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

#if DEBUG
#define QQLog(...) NSLog(__VA_ARGS__)
#else
#define QQLog(...)
#endif

#endif /* QQAppDefine_h */
