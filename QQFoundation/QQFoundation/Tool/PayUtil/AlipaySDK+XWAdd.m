//
//  AlipaySDK+XWAdd.m
//  yyjx
//
//  Created by wazrx on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AlipaySDK+XWAdd.h"
#import <objc/runtime.h>

static void * const xwAdd_partnerID_key = "xwAdd_partnerID_key";
static void * const xwAdd_sellerID_key = "xwAdd_sellerID_key";
static void * const xwAdd_partnerPrivKey_key = "xwAdd_partnerPrivKey_key";
static void * const xwAdd_callbackConfig_key = "xwAdd_callbackConfig_key";

@implementation AlipaySDK (XWAdd)

+ (void)xwAdd_sendPayWithOrderInfo:(NSString *)orderInfo
                         appScheme:(NSString *)appScheme
                    callbackConfig:(void (^)(BOOL successed))config {
    //保存回调block
    objc_setAssociatedObject(self, xwAdd_callbackConfig_key, config, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //发起支付请求
    [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        [self _xwAdd_checkResultWithDict:resultDic];
    }];
    
}

+ (void)xwAdd_handleOpenURL:(NSURL *)url {
    if (![url.host isEqualToString:@"safepay"]) {
        return;
    }
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        [self _xwAdd_checkResultWithDict:resultDic];
    }];
}

#pragma mark - private methods

+ (void)_xwAdd_checkResultWithDict:(NSDictionary *)resultDic{
    void (^config)(BOOL successed) = objc_getAssociatedObject(self, xwAdd_callbackConfig_key);
    if (!config) {
        return;
    }
    config([resultDic[@"resultStatus"] intValue] == 9000);
    config = nil;
    objc_setAssociatedObject(self, xwAdd_callbackConfig_key, nil, OBJC_ASSOCIATION_ASSIGN);
}

+ (void)_xwAdd_saveValueWithKey:(void *)key value:(id)value{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (id)_xwAdd_readValueWithKey:(void *)key{
    return objc_getAssociatedObject(self, key);
}
@end
