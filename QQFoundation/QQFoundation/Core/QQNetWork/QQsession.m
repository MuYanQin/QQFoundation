//
//  QQsession.m
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/17.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import "QQsession.h"
#import "AFNetworking.h"
#import "NSObject+MB.h"
#import "QQTool.h"
#import "QQNetManager.h"
#import "NSDate+QQCalculate.h"
@interface QQsession ()
@property (nonatomic , strong) AFHTTPSessionManager * sessionManager;
@property (nonatomic , strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestJsonSerializer;
@property (nonatomic , strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestKeyVSerializer;
@end

@implementation QQsession

- (NSURLSessionDataTask *)TXDWith:(NSString *)url param:(NSDictionary *)param from:(UIViewController *)controller txdType:(QQSessionType)txdType cacheType:(CacheType)cacheType commiteType:(CommiteType)commiteType success:(void (^)(id))success failed:(void (^)(NSError *))failed
{
//判断缓存
    if (cacheType == localData) {
        NSDictionary *dic  = [[QQNetManager Instance].dataCache objectForKey:self.urlStr];
        double preTime = [dic[@"time"] boolValue];
        double nowtime = (long)[[NSDate date] timeIntervalSince1970];
        if ((nowtime - preTime)>60) {
            [[QQNetManager Instance].dataCache removeObjectForKey:self.urlStr];
        }else{
            success(dic[@"data"]);
            return nil;
        }
    }
    if (commiteType == keyV) {
        self.sessionManager.requestSerializer = self.requestKeyVSerializer;
    }else{
        self.sessionManager.requestSerializer = self.requestJsonSerializer;
    }
    NSURLSessionDataTask * operation;
    [[QQNetManager Instance] insertQQConnection:self];
    [self loading];
    switch (txdType) {
        case get:
        {
            operation = [self.sessionManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleResponseObject:responseObject cacheType:cacheType key:self.urlStr Controller:controller Success:success failure:failed];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleResponseObject:error Controller:controller failure:failed];
            }];
            break;
        }
        case post:
        {
            [self.sessionManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleResponseObject:responseObject cacheType:cacheType key:self.urlStr Controller:controller Success:success failure:failed];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleResponseObject:error Controller:controller failure:failed];
            }];
            break;
        }
        default:
            break;
    }
    self.SessionTask = operation;
    return operation;
}
//upload files
- (NSURLSessionDataTask *)TXDUploadWithUrl:(NSString *)urlStr
                                       dic:(NSDictionary *)dic
                              imageArray:(NSMutableArray *)images
                                      from:(UIViewController *)controller
                                  fileMark:(NSString *)fileMark
                                  progress:(void (^)(NSProgress *uploadProgress))progress
                                   success:(void(^)(id responseObject))success
                                     failed:(void(^)(NSError *error))failed
{
    NSString *TrueUrl = [NSString stringWithFormat:@"%@%@",QQBaseUrl,urlStr];
    NSMutableDictionary *TrueDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self loading];
    NSURLSessionDataTask * operation = [self.sessionManager POST:TrueUrl parameters:TrueDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in images) {
            NSData * data = [QQTool imageData:image];
            [formData appendPartWithFileData:data name:fileMark
                                    fileName:[NSString stringWithFormat:@"%@.png",[NSDate GetNowDate:@"YYYYMMddHHmmSSS"]]
                                    mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponseObject:responseObject cacheType:ignore key:nil Controller:controller Success:success failure:failed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponseObject:error Controller:controller failure:failed];
    }];
    return operation;
}
#pragma mark - 统一处理下载返回的数据
- (void)handleResponseObject:(id)responseObject  cacheType:(CacheType)cacheType key:(NSString *)key Controller:(UIViewController *)controller Success:(void(^)( id  _Nullable responseObject))successBlock  failure:(void(^)(NSError *error))failureBlock;
{
    if ([QQNetManager Instance].isMonitor) {
        [QQNetManager Instance].monitorView.dataDic = @{self.urlStr:responseObject};
        
    }
    if ([responseObject[@"code"] isEqualToString:successCode]) {
        if (cacheType == localData) {
            double time = (long)[[NSDate date] timeIntervalSince1970];
            [[QQNetManager Instance].dataCache setObject:@{@"data":responseObject,@"time":@(time)} forKey:key];
        }
        successBlock(responseObject);
    }else{
        [self message:[QQTool strRelay:responseObject[@"msg"]]];
        NSDictionary *userInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:[QQTool strRelay:responseObject[@"msg"]], NSLocalizedDescriptionKey,nil];
        NSError *error = [[NSError alloc]initWithDomain:@"QQSession" code:[responseObject[@"code"] integerValue] userInfo:userInfo1];
        failureBlock(error);
    }
    [self hiddenHUD];

    [self doneRequest:controller];
}
- (void)handleResponseObject:(NSError *)error  Controller:(UIViewController *)controller failure:(void(^)(NSError *error))failureBlock
{
    if ([QQNetManager Instance].isMonitor) {
        [QQNetManager Instance].monitorView.dataDic = @{self.urlStr:error};
    }
//主动退出怎么才能不显示失败的提示 -999就是取消此次下载
    if (error.code == -1001){///<请求超时不是错误不用返回错误
        [self message:@"请求超时，请重试！"];
    }else  if (error.code == -999) {//-999是请求被取消
    }else{
        failureBlock(error);
    }
    [self hiddenHUD];
    [self doneRequest:controller];
}
- (void)doneRequest:(UIViewController *)controller
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;//请求失败关闭小菊花
    [[QQNetManager Instance] deleteQQConnection:self];//请求结束 从字典里删除本次请求
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
- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        //        [manager setSecurityPolicy:self.customSecurityPolicy];//是否开启ssl验证
        //设置请求头
        //        [manager.requestSerializer setValue:[WSLUtil strRelay:obj] forHTTPHeaderField:[WSLUtil strRelay:key]];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];//@"application/x-javascript"
    }
    return _sessionManager;
}

//设置证书的时候 后台验证
- (AFSecurityPolicy*)customSecurityPolicy
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}
- (AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestJsonSerializer
{
    if (!_requestJsonSerializer) {
        _requestJsonSerializer = [AFJSONRequestSerializer serializer];
        _requestJsonSerializer.timeoutInterval = 30.f;
    }
    return _requestJsonSerializer;
}
- (AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestKeyVSerializer
{
    if (!_requestKeyVSerializer) {
        _requestKeyVSerializer = [AFHTTPRequestSerializer serializer];
        _requestKeyVSerializer.timeoutInterval = 30.f;
    }
    return _requestKeyVSerializer;
}
@end

