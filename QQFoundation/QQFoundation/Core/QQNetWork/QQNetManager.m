//
//  QQNetManegr.m
//  QQNetManager
//
//  Created by Yuan er on 16/4/17.
//  Copyright © 2016年 Yuan er. All rights reserved.
//

#import "QQNetManager.h"
#import "QQTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "QQsession.h"
#import "AFNetworking.h"

@interface QQNetManager()
/**纪录当前正在请求的url*/
@property (nonatomic , strong) NSMutableDictionary * dataDic;
/**纪录页面的请求*/
@property (nonatomic , strong) NSMutableArray * controllerRequest;

@end
@implementation QQNetManager
{
    NSURLSessionDataTask *operation;
    NSLock *lock;
}
- (instancetype)init
{
    if (self = [super init]) {
        _dataDic = [[NSMutableDictionary alloc]init];
        _controllerRequest = [NSMutableArray array];
        _dataCache = [[NSCache alloc]init];
        _dataCache.totalCostLimit = 3 * 1024 * 1024;
        _cacheSec = 60;
    }
    return self;
}
+ (instancetype)instance{
    static  QQNetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}
- (void)configNetwork:(NSString *)baseURL codeKey:(NSString *)codeKey successCode:(NSString *)successCode msgStr:(NSString *)msgKey
{
    self.baseURL = baseURL;
    self.codeKey = codeKey;
    self.successCode =successCode;
    self.msgKey = msgKey;
}

- (void)RTSGetWith:(NSString *)url param:(NSDictionary *)param from:(UIViewController *)controller success:(void(^)(id responseObject))success failed:(void (^)(NSError * error))failed;
{
    
    [self filtrationTxdWithUrl:url param:param from:controller txdType:get cacheType:ignore commiteType:keyV images:nil fileMark:nil progress:nil success:success failed:failed];
}

- (void)RTSPostWith:(NSString *)url param:(NSDictionary *)param from:(UIViewController *)controller success:(void (^)(id responseObject))success failed:(void (^)(NSError *))failed
{
    [self filtrationTxdWithUrl:url param:param from:controller txdType:post cacheType:ignore commiteType:keyV images:nil fileMark:nil progress:nil success:success failed:failed];
}
-(void)RTSPostJsonWith:(NSString *)url param:(NSDictionary *)param from:(UIViewController *)controller success:(void(^)(id responseObject))success failed:(void (^)(NSError * error))failed
{
    [self filtrationTxdWithUrl:url param:param from:controller txdType:post cacheType:ignore commiteType:json images:nil fileMark:nil progress:nil success:success failed:failed];
}
- (void)RTSGetCacheWith:(NSString *)url param:(NSDictionary *)param cache:(CacheType)cache from:(UIViewController *)controller success:(void (^)(id responseObject))success failed:(void (^)(NSError *))failed
{
    [self filtrationTxdWithUrl:url param:param from:controller txdType:get cacheType:cache commiteType:keyV images:nil fileMark:nil progress:nil success:success failed:failed];
}

- (void)RTSUploadWith:(NSString *)url
           param:(NSDictionary *)param
           images:(NSMutableArray *)images
                 from:(UIViewController *)controller
             fileMark:(NSString *)fileMark
             progress:(void (^)(NSProgress *uploadProgress))progress
              success:(void(^)( id responseObject))success
               failed:(void(^)(NSError *error))failed
{

    [self filtrationTxdWithUrl:url param:param from:controller txdType:post cacheType:ignore commiteType:keyV images:images fileMark:fileMark progress:progress success:success failed:failed];
    
}
- (void)filtrationTxdWithUrl:(NSString *)url
                       param:(NSDictionary *)param
                        from:(UIViewController *)controller
                     txdType:(QQSessionType)txdType
                   cacheType:(CacheType)cacheType
                 commiteType:(CommiteType)commiteType
                      images:(NSMutableArray *)images
                    fileMark:(NSString *)fileMark
                    progress:(void (^)(NSProgress *uploadProgress))progress
                     success:(void(^)(id responseObject))success
                       failed:(void(^)(NSError *error))failed
{
    if (!self.baseURL || !self.codeKey || !self.msgKey || !self.successCode) {
        NSString *errStr = [NSString stringWithFormat:@"请正确配置请求数据：baseURL=%@，codeKey=%@，msgKey=%@，successCode=%@",self.baseURL,self.codeKey,self.msgKey,self.successCode];
        failed([self configSessionErrorCode:999999 desc:errStr]);
        return;
    }
    QQsession *session= [_dataDic objectForKey:[self cacheKeyWithURL:url param:param]];
    if (!session) {
        session = [[QQsession alloc]init];
        session.urlStr = url;
        session.cacheKey = [self cacheKeyWithURL:url param:param];
        session.controller = controller;
        if (images.count >0) {
            [session TXDUploadWithUrl:url dic:param images:images fileMark:fileMark progress:progress success:success failed:failed];
        }else{
            [session TXDWith:url param:param txdType:txdType cacheType:cacheType commiteType:commiteType    success:success failed:failed];
        }
    }else{
        failed([self configSessionErrorCode:888888 desc:@"重复请求,已发起该请求!"]);
    }
}
//为了防止单个网络请求多次请求 例如刷新
- (void)insertQQConnection:(QQsession *)hc
{
    if (!hc.cacheKey)return;
    [_dataDic setObject:hc forKey:hc.cacheKey];
    NSString *className =  NSStringFromClass([hc.controller class]);
    if (className.length >0) {
        [_controllerRequest addObject:hc];
    }
}
- (void)deleteQQConnection:(QQsession *)hc
{
    [_dataDic removeObjectForKey:hc.cacheKey];
    [_controllerRequest removeObject:hc];
}
//控制器消失的时候取消下载
- (void)deleteConnectionVC:(UIViewController *)delvc
{
    [lock lock];
    //循环的时候不能移除元素 所以借用一个中间变量
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_controllerRequest];
    //有的三方滑动视图  或者自己的写的segment都会用到addchildviewcontroller：
    NSMutableArray *VCArray = [NSMutableArray arrayWithArray:delvc.childViewControllers];
    //把父控制器加进来
    [VCArray addObject:delvc];

    //这里主要还是根据入库的控制器来写不是一定的  根据个人需要
    for (UIViewController *VC in VCArray) {
        @autoreleasepool {
            NSString *VCName = NSStringFromClass([VC class]);
            for (QQsession *session in tempArr) {///<在存储请求的数据里找对应的界面
                @autoreleasepool {
                    NSString *className =  NSStringFromClass([session.controller class]);
                    if ([className isEqualToString: VCName]) {
                        [self deleteQQConnection:session];
                        [session.SessionTask cancel];
                    }
                }
            }
        }
    }
    [lock unlock];
}
- (NSError *)configSessionErrorCode:(NSInteger)code desc:(NSString *)desc
{
    NSDictionary *userInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:[QQTool strRelay:desc], NSLocalizedDescriptionKey,nil];
    NSError *error = [[NSError alloc]initWithDomain:@"errorCode" code:code userInfo:userInfo1];
    return error;
}

- (NSString *)cacheKeyWithURL:(NSString *)URL param:(NSDictionary *)param
{
    if(!param){
        return [self md5:URL];
    };
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    return [self md5:cacheKey];
}
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end
