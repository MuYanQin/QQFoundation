//
//  QQBaseURL.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/6/6.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#ifndef QQBaseURL_h
#define QQBaseURL_h

#define   ServerType 1 //1 开发  2 测试  3生产
#if (ServerType == 1)
#define QQBaseUrl  @""

#elif (ServerType == 2)
#define QQBaseUrl  @""

#elif (ServerType == 3)
#define QQBaseUrl  @""

#endif

#endif /* QQBaseURL_h */
