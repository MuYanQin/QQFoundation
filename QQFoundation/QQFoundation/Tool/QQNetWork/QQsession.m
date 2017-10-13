//
//  QQsession.m
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/17.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import "QQsession.h"
#import "AFNetworking.h"
#import "QQNetManager.h"
#import "NSDate+QQCalculate.h"
#import "YYCache.h"
#import "uiview+MB.h"
@interface QQsession ()
@end

@implementation QQsession
static YYCache *HttpCache;
static NSString *const QQCacheName = @"QQNetWorkCache";
static AFHTTPSessionManager *manager;
-(AFHTTPSessionManager *)sharedHTTPSession{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 30.f;
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        [manager setSecurityPolicy:self.customSecurityPolicy];//是否开启ssl验证
        //设置请求头
//        [[WSUtils getRequestHeaderDict] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//            [manager.requestSerializer setValue:[WSLUtil strRelay:obj] forHTTPHeaderField:[WSLUtil strRelay:key]];
//        }];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return manager;
}
//设置证书的时候 后台验证
- (AFSecurityPolicy*)customSecurityPolicy
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}
+ (void)initialize
{
    HttpCache = [YYCache cacheWithName:QQCacheName];
}

//手机上的小菊花用    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
//来实现就好了  我这里是自己写的
- (NSURLSessionDataTask *)TXDGetWithUrl:(NSString *)url Dic:(NSDictionary *)dic from:(UIViewController *)controller success:(void (^)(id))success False:(void (^)(NSError *))False
{
    //没网络的情况时直接返回
//    if (![self requestBeforeJudgeConnect]) {
//        [[QQNetManager defaultManager] showProgressHUDWithType:0];
//        return nil;
//    }
    NSString *TrueUrl = [NSString stringWithFormat:@"%@%@",@"",url];//域名和接口拼接起来的
    NSMutableDictionary *TrueDic = [NSMutableDictionary dictionaryWithDictionary:dic];//方便加请求参数
    [[QQNetManager defaultManager] insertQQConnection:self];
    [controller.view Loading_0314];
    NSURLSessionDataTask * operation = [self.sharedHTTPSession GET:TrueUrl parameters:TrueDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self handleResponseObject:responseObject IsCache:NO key:nil Controller:controller Success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponseObject:error Controller:controller failure:False];
    }];
    
    [[QQNetManager defaultManager] insertConnectionVC:controller QQConnection:self SessionDataTask:operation];
    
    return operation;
}
//common post
- (NSURLSessionDataTask *)TXDPostWithUrl:(NSString *)url Dic:(NSDictionary *)dic from:(UIViewController *)controller success:(void (^)(id))success False:(void (^)(NSError *))False
{
    //没网络的情况时直接返回
//    if (![self requestBeforeJudgeConnect]) {
//        [[QQNetManager defaultManager] showProgressHUDWithType:0];
//        return nil;
//    }
    NSString *TrueUrl = [NSString stringWithFormat:@"%@%@",@"域名",url];
    NSMutableDictionary *TrueDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [[QQNetManager defaultManager] insertQQConnection:self];
    [controller.view Loading_0314];
    
    NSURLSessionDataTask * operation = [self.sharedHTTPSession POST:TrueUrl parameters:TrueDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponseObject:responseObject IsCache:NO key:nil Controller:controller Success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponseObject:error Controller:controller failure:False];
    }];
    [[QQNetManager defaultManager] insertConnectionVC:controller QQConnection:self SessionDataTask:operation];
    
    return operation;

}
//get with cache
- (NSURLSessionDataTask *)TXDGetCacheWithUrl:(NSString *)url Dic:(NSDictionary *)dic from:(UIViewController *)controller success:(void (^)(id))success False:(void (^)(NSError *))False
{
    NSString *TrueUrl = [NSString stringWithFormat:@"%@%@",@"域名",url];
    //没网络的情况时 判断有没有缓存 有就直接拿出来
    NSString *keyStr =[self cacheKeyWithURL:TrueUrl parameters:dic];
    if ([HttpCache containsObjectForKey:keyStr]) {// is have cache
        success([HttpCache objectForKey:keyStr]);// have  return
        return nil; //NO:  go on
    }
    
//    if (![self requestBeforeJudgeConnect]) {
//        [[QQNetManager defaultManager] showProgressHUDWithType:0];
//        False(nil);
//        return nil;
//    }
    NSMutableDictionary *TrueDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [[QQNetManager defaultManager] insertQQConnection:self];///<
    [controller.view Loading_0314];
    
    NSURLSessionDataTask * operation = [self.sharedHTTPSession GET:TrueUrl parameters:TrueDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self handleResponseObject:responseObject IsCache:YES key:keyStr Controller:controller Success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponseObject:error Controller:controller failure:False];
    }];
    
    [[QQNetManager defaultManager] insertConnectionVC:controller QQConnection:self SessionDataTask:operation];
    
    return operation;
    

}
//tableview load
- (NSURLSessionDataTask *)TXDTableWithUrl:(NSString *)url Dic:(NSDictionary *)dic from:(UIViewController *)controller success:(void (^)(id))success False:(void (^)(NSError *))False
{
#pragma mark  -  后面把tableview的第一个界面的缓存  用户下啦更新
    //没网络的情况时直接返回
//    if (![self requestBeforeJudgeConnect]) {
//        [[QQNetManager defaultManager] showProgressHUDWithType:0];
//        NSError *error = nil;
//        False(error);//没有网络 但是tableview的刷新等操作时要 结束得熬的所以单拿出
//        return nil;
//    }
    NSString *TrueUrl = [NSString stringWithFormat:@"%@%@",@"域名",url];
    NSMutableDictionary *TrueDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [[QQNetManager defaultManager] insertQQConnection:self];
    [controller.view Loading_0314];
    
    NSURLSessionDataTask * operation = [self.sharedHTTPSession POST:TrueUrl parameters:TrueDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
        [[QQNetManager defaultManager] deleteQQConnection:self];
        [[QQNetManager defaultManager] deleteConnectionVC:controller];///<下载成功 删除数组里存储

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        False(error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
        [[QQNetManager defaultManager] deleteQQConnection:self];
        [[QQNetManager defaultManager] deleteConnectionVC:controller];///<下载失败 删除数组里存储

    }];
    [[QQNetManager defaultManager] insertConnectionVC:controller QQConnection:self SessionDataTask:operation];
    
    return operation;

}
// upload files
- (NSURLSessionDataTask *)TXDUploadWithUrl:(NSString *)urlStr Dic:(NSDictionary *)dic MutableArray:(NSMutableArray *)Images from:(UIViewController *)controller Progress:(void (^)(NSProgress *))Progress success:(void (^)(id))success False:(void (^)(NSError *))False
{
    //没网络的情况时直接返回
//    if (![self requestBeforeJudgeConnect]) {
//        [[QQNetManager defaultManager] showProgressHUDWithType:0];
//        return nil;
//    }
    NSString *TrueUrl = [NSString stringWithFormat:@"%@%@",@"域名",urlStr];
    NSMutableDictionary *TrueDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //    [TrueDic setObject:[UserInfo defaultManager].Token  forKey:@"token"];
    [[QQNetManager defaultManager] insertQQConnection:self];
    [controller.view Loading_0314];
    
    NSURLSessionDataTask * operation = [self.sharedHTTPSession POST:TrueUrl parameters:TrueDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = nil;
        for (int j = 0; j<Images.count; j++) {
//            data = [QQTool imageData:Images[j]];
//            [formData appendPartWithFileData:data name:@"files"
//                                    fileName:[NSString stringWithFormat:@"%@.png",[QQTool GetNowDate:@"YYYYMMddHHmmSSS"]]
//                                    mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        Progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponseObject:responseObject IsCache:NO key:TrueUrl Controller:controller Success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponseObject:error Controller:controller failure:False];
    }];
    [[QQNetManager defaultManager] insertConnectionVC:controller QQConnection:self SessionDataTask:operation];
    return operation;
}
#pragma mark - 统一处理下载返回的数据
- (void)handleResponseObject:(id)responseObject  IsCache:(BOOL)Cache key:(NSString *)key Controller:(UIViewController *)controller Success:(void(^)( id  _Nullable responseObject))successBlock;
{
    if (Cache) {
        [HttpCache setObject:responseObject forKey:key withBlock:nil];//需要缓存则
    }
    //MB延时处理  不做延时处理的话 直接就因为hidden 导致提示出不来  也可以在下面单独区分隐藏
    if ([responseObject[@"code"] isEqualToString:@"1"]) {
        [controller.view Hidden];
        successBlock(responseObject);
    }else{
        [controller.view Message:responseObject[@"msg"]  HiddenAfterDelay:2];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    [[QQNetManager defaultManager] deleteQQConnection:self];
    [[QQNetManager defaultManager] deleteConnectionVC:controller];///<下载成功 删除数组里存储

}
- (void)handleResponseObject:(NSError *)error  Controller:(UIViewController *)controller failure:(void(^)(NSError *error))failureBlock
{

//主动退出怎么才能不显示失败的提示 -999就是取消此次下载
    if (error.code == -1001){
        [controller.view Message:@"请求超时，请重试！" HiddenAfterDelay:2];
    }else  if (error.code != -999) {//-999是请求被取消
        [controller.view Hidden];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            failureBlock(error);///<请求超时不是错误
        });
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;//请求失败关闭小菊花
    [[QQNetManager defaultManager] deleteQQConnection:self];//请求结束 从字典里删除本次请求
    [[QQNetManager defaultManager] deleteConnectionVC:controller];///<下载失败 删除数组里存储
    
}
#pragma mark - 取消下载
- (void)cancelWithOperation:(NSURLSessionDataTask *)operation
{
    [operation cancel];
    [[QQNetManager defaultManager] deleteQQConnection:self];
}
#pragma mark - 组织URL存取的key
- (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    if(!parameters){
        return URL;
    };
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    return cacheKey;
}
#pragma mark  网络判断
-(BOOL)requestBeforeJudgeConnect
{
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        NSLog(@"Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  =(isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}
@end

