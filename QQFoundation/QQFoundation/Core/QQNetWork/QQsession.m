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
static NSString * const timeKey = @"time";
static NSString * const dataKey = @"data";
@interface QQsession ()
@property (nonatomic , strong) AFHTTPSessionManager * sessionManager;
@property (nonatomic , strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestJsonSerializer;
@property (nonatomic , strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestKeyVSerializer;
@end

@implementation QQsession

- (NSURLSessionDataTask *)TXDWith:(NSString *)url param:(NSDictionary *)param  txdType:(QQSessionType)txdType cacheType:(CacheType)cacheType commiteType:(CommiteType)commiteType success:(void (^)(id))success failed:(void (^)(NSError *))failed
{
    //判断缓存
    if (cacheType == memoryCaceh) {
        NSDictionary *dic  = [[QQNetManager Instance].dataCache objectForKey:self.cacheKey];
        double preTime = [dic[timeKey] doubleValue];
        double nowtime = (long)[[NSDate date] timeIntervalSince1970];
        if ((nowtime - preTime)>[QQNetManager Instance].cacheSec) {
            [[QQNetManager Instance].dataCache removeObjectForKey:self.cacheKey];
        }else{
            success(dic[dataKey]);
            return nil;
        }
    }else if (cacheType == diskCache){
        id value =  [[NSUserDefaults standardUserDefaults] objectForKey:self.cacheKey];
        if (value) {
            success(value);
            return nil;
        }
    }
    //判断提交数据方式
    if (commiteType == keyV) {
        self.sessionManager.requestSerializer = self.requestKeyVSerializer;
    }else{
        self.sessionManager.requestSerializer = self.requestJsonSerializer;
    }
    url = [NSString stringWithFormat:@"%@%@",QQBaseUrl,url];

    NSURLSessionDataTask * operation;
    [[QQNetManager Instance] insertQQConnection:self];
    if (self.controller) {
        [self loading];
    }
    //请求方式
    switch (txdType) {
        case get:
        {
            operation = [self.sessionManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleResponseObject:responseObject cacheType:cacheType Success:success failure:failed];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleResponseObject:error failure:failed];
            }];
            break;
        }
        case post:
        {
            [self.sessionManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleResponseObject:responseObject cacheType:cacheType Success:success failure:failed];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleResponseObject:error failure:failed];
            }];
            break;
        }
        default:
            break;
    }
    self.SessionTask = operation;
    return operation;
}
- (void)extracted:(NSData *)data fileMark:(NSString *)fileMark formData:(id<AFMultipartFormData> _Nonnull)formData {
    [formData appendPartWithFileData:data name:fileMark
                            fileName:[NSString stringWithFormat:@"%@.png",[NSDate GetNowDate:@"YYYYMMddHHmmSSS"]]
                            mimeType:@"image/jpeg"];
}

//upload files
- (NSURLSessionDataTask *)TXDUploadWithUrl:(NSString *)urlStr
                                       dic:(NSDictionary *)dic
                              imageArray:(NSMutableArray *)images
                                  fileMark:(NSString *)fileMark
                                  progress:(void (^)(NSProgress *uploadProgress))progress
                                   success:(void(^)(id responseObject))success
                                     failed:(void(^)(NSError *error))failed
{
    NSString *TrueUrl = [NSString stringWithFormat:@"%@%@",QQBaseUrl,urlStr];
    if (self.controller) {
        [self loading];
    }
    NSURLSessionDataTask * operation = [self.sessionManager POST:TrueUrl parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in images) {
            NSData * data = [QQTool imageData:image];
            [self extracted:data fileMark:fileMark formData:formData];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponseObject:responseObject cacheType:ignore Success:success failure:failed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponseObject:error failure:failed];
    }];
    return operation;
}
#pragma mark - 统一处理下载返回的数据
- (void)handleResponseObject:(id)responseObject  cacheType:(CacheType)cacheType Success:(void(^)( id  _Nullable responseObject))successBlock  failure:(void(^)(NSError *error))failureBlock;
{
    if ([QQNetManager Instance].isMonitor) {
        [QQNetManager Instance].monitorView.dataDic = @{self.urlStr:responseObject};
    }
    if ([responseObject[@"code"] isEqualToString:successCode]) {
        [self hiddenHUD];
        if (cacheType == memoryCaceh) {
            double time = (long)[[NSDate date] timeIntervalSince1970];
            [[QQNetManager Instance].dataCache setObject:@{dataKey:responseObject,timeKey:@(time)} forKey:self.cacheKey];
        }else if (cacheType == diskCache){
            [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:self.cacheKey];
        }
        successBlock(responseObject);
    }else{
        [self message:[QQTool strRelay:responseObject[@"msg"]]];
        NSDictionary *userInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:[QQTool strRelay:responseObject[@"msg"]], NSLocalizedDescriptionKey,nil];
        NSError *error = [[NSError alloc]initWithDomain:@"QQSession" code:[responseObject[@"code"] integerValue] userInfo:userInfo1];
        failureBlock(error);
    }
    //请求结束 从字典里删除本次请求
    [[QQNetManager Instance] deleteQQConnection:self];
}
- (void)handleResponseObject:(NSError *)error failure:(void(^)(NSError *error))failureBlock
{
    if ([QQNetManager Instance].isMonitor) {
        [QQNetManager Instance].monitorView.dataDic = @{self.urlStr:error};
    }
    //-999就是取消此次下载
    if (error.code == -1001){///<请求超时不是错误不用返回错误
        [self message:@"请求超时，请重试！"];
    }else  if (error.code == -999) {//-999是请求被取消
        [self hiddenHUD];
    }else{
        [self hiddenHUD];
    }
    failureBlock(error);
    
    //请求结束 从字典里删除本次请求
    [[QQNetManager Instance] deleteQQConnection:self];
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

