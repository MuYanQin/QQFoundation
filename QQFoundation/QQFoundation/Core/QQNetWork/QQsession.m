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
@end

@implementation QQsession

- (NSURLSessionDataTask *)TXDWith:(NSString *)url Param:(NSDictionary *)param from:(UIViewController *)controller txdType:(QQSessionType)txdType cacheType:(CacheType)cacheType success:(void (^)(id))success False:(void (^)(NSError *))False
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
    NSURLSessionDataTask * operation;
    [[QQNetManager Instance] insertQQConnection:self];
    [self loading];
    switch (txdType) {
        case get:
        {
            operation = [[QQNetManager Instance].sessionManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleResponseObject:responseObject cacheType:cacheType key:self.urlStr Controller:controller Success:success failure:False];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleResponseObject:error Controller:controller failure:False];
            }];
            break;
        }
        case post:
        {
            [[QQNetManager Instance].sessionManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleResponseObject:responseObject cacheType:cacheType key:self.urlStr Controller:controller Success:success failure:False];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleResponseObject:error Controller:controller failure:False];
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
                                       Dic:(NSDictionary *)dic
                              MutableArray:(NSMutableArray *)Images
                                      from:(UIViewController *)controller
                                  fileMark:(NSString *)fileMark
                                  Progress:(void (^)(NSProgress *uploadProgress))Progress
                                   success:(void(^)(id responseObject))success
                                     False:(void(^)(NSError *error))False
{
    NSString *TrueUrl = [NSString stringWithFormat:@"%@%@",QQBaseUrl,urlStr];
    NSMutableDictionary *TrueDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self loading];
    NSURLSessionDataTask * operation = [[QQNetManager Instance].sessionManager POST:TrueUrl parameters:TrueDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in Images) {
            NSData * data = [QQTool imageData:image];
            [formData appendPartWithFileData:data name:fileMark
                                    fileName:[NSString stringWithFormat:@"%@.png",[NSDate GetNowDate:@"YYYYMMDDHHmmSSS"]]
                                    mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        Progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponseObject:responseObject cacheType:ignore key:nil Controller:controller Success:success failure:False];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponseObject:error Controller:controller failure:False];
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
@end

