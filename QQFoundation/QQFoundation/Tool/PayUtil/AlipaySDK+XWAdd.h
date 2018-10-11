//
//  AlipaySDK+XWAdd.h
//  yyjx
//
//  Created by wazrx on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 集成步骤：
 1、导入相关库，配置info.plist、配置Scheme、配置header search paths，进行编译前准备
 2、调用xwAdd_registerAlipayWithPartnerID:sellerID:partnerPrivKey:方法注册支付宝支付，该方法在客户端签名时候才需要调用
 4、在appDelegate中的handleURL中调用xwAdd_handleOpenURL设置回调
 5、调用xwAdd_sendPayRequest方法发起支付申请，该方法分为有客户端签名和服务端签名两个版本
 6、在回调block中处理相关逻辑
 */

#import <AlipaySDK/AlipaySDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlipaySDK (XWAdd)

/**
 *  发起支付 (服务器端签名版本)
 *
 *  @param orderInfo 服务器签名好的订单信息
 *  @param appScheme 设置的app的URLScheme
 *  @param config    支付完成后的回调（无论是网页版本还是支付宝客户端的版本都通过此block回调）（successed = YES 代表支付成功）
 */
+ (void)xwAdd_sendPayWithOrderInfo:(NSString *)orderInfo
                         appScheme:(NSString *)appScheme
                    callbackConfig:(void (^)(BOOL successed))config;

/**
 *  处理回调的openUrl，请在AppDelegate对应的方法中调用
 *
 *  @param url 回调的openURL
 */
+ (void)xwAdd_handleOpenURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
