//
//  MCPuchMediator.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/25.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCPuchMediator : NSObject

/**
push到某个界面 当completion不为空时 对应的push对象一定要实现completion block函数才能收到回调

 @param ClassString push对象的类命字符串
 @param Parameters 要传递的参数 可为空
 @param callBack 回调函数
 */
+ (void)pushToClassFromStaring:(NSString *)ClassString takeParameters:(NSDictionary *)Parameters  callBack:(void(^)(id data))callBack;
@end

typedef  void(^callBack)(id data);
@interface NSObject (MCParameters)
@property (nonatomic, copy) callBack pushCallBack;
@end
