//
//  MCPuchMediator.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/25.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MCPushMediator : NSObject

/**
push到某个界面
 @param ClassString push对象的类命字符串
 @param Parameters 要传递的参数 可为空
 @param callBack 界面即将消失的回调函数  携带的data参数需要 需要手动在即将消失的界面赋值  self.callBackData = @"";即可
 */
+ (void)pushToClassFromStaring:(NSString *)ClassString takeParameters:(NSDictionary *)Parameters  callBack:(void(^)(id callBackData))callBack;
@end



typedef  void(^callBack)(id data);

@interface NSObject (MCParameters)
@property (nonatomic, copy) callBack pushCallBack;
@property (nonatomic , strong) id callBackData;
@end
