//
//  QQNetManegr.m
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/17.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import "QQNetManager.h"
#import "QQTool.h"
#import <CommonCrypto/CommonDigest.h>
@interface QQNetManager()
@property (nonatomic , strong) NSMutableDictionary * dataDic;///<纪录下载的url
@property (nonatomic , strong) NSMutableArray * controllerRequest;///<纪录页面的请求

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
        _IsConsolePrint = YES;
        _dataCache = [[NSCache alloc]init];
        _dataCache.totalCostLimit = 3 * 1024 * 1024;
    }
    return self;
}
+ (instancetype)defaultManager{
    static  QQNetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}
- (void)setIsConsolePrint:(BOOL)IsConsolePrint
{
    _IsConsolePrint = IsConsolePrint;
}

- (void)RTSGetWith:(NSString *)url Parameters:(NSDictionary *)parameters From:(UIViewController *)controller Successs:(void (^)(id))Success False:(void (^)(NSError *))False
{
    [self filtrationTxdWithUrl:url Param:parameters from:controller txdType:get cacheType:ignore success:Success False:False];
}

- (void)RTSGetCacheWith:(NSString *)url Parameters:(NSDictionary *)parameters From:(UIViewController *)controller Successs:(void (^)(id))Success False:(void (^)(NSError *))False
{
    [self filtrationTxdWithUrl:url Param:parameters from:controller txdType:get cacheType:localDate success:Success False:False];
}
- (void)RTSPostWith:(NSString *)url Parameters:(NSDictionary *)parameters From:(UIViewController *)controller Successs:(void (^)(id))Success False:(void (^)(NSError *))False
{
    [self filtrationTxdWithUrl:url Param:parameters from:controller txdType:post cacheType:ignore success:Success False:False];
}

- (void)filtrationTxdWithUrl:(NSString *)url
                       Param:(NSDictionary *)param
                        from:(UIViewController *)controller
                     txdType:(QQSessionType)txdType
                   cacheType:(CacheType)cacheType
                     success:(void(^)(id responseObject))success
                       False:(void(^)(NSError *error))False
{
    QQsession *session= [_dataDic objectForKey:[self cacheKeyWithURL:url parameters:param]];
    if (!session) {
        session = [[QQsession alloc]init];
        session.urlStr = [self cacheKeyWithURL:url parameters:param];
        session.controllerName = NSStringFromClass([controller class]);
        [session TXDWith:url Param:param from:controller txdType:txdType cacheType:cacheType success:success False:False];
    }
}

- (void)RTSUploadWith:(NSString *)url
           Dictionary:(NSDictionary *)parameters
         MutableArray:(NSMutableArray *)Images
                 From:(UIViewController *)controller
             fileMark:(NSString *)fileMark
             Progress:(void (^)(NSProgress *uploadProgress))Progress
              Success:(void(^)( id responseObject))Success
                False:(void(^)(NSError *error))False
{
    if (Images.count <=0) {
        return;
    }
    QQsession *session= [_dataDic objectForKey:[self cacheKeyWithURL:url parameters:parameters]];
    if (!session) {
        session = [[QQsession alloc]init];
        session.urlStr = [self cacheKeyWithURL:url parameters:parameters];
        [session TXDUploadWithUrl:url Dic:parameters MutableArray:Images from:controller fileMark:fileMark Progress:Progress success:Success False:False];
    }
}

//为了防止单个网络请求多次请求 例如刷新
- (void)insertQQConnection:(QQsession *)hc
{
    if (!hc.urlStr)return;
    [_dataDic setObject:hc forKey:hc.urlStr];
    if (hc.controllerName.length >0) {
        [_controllerRequest addObject:hc];
    }
}
- (void)deleteQQConnection:(QQsession *)hc
{
    [_dataDic removeObjectForKey:hc.urlStr];
    [_controllerRequest removeObject:hc];
}
//控制器消失的时候取消下载
- (void)deleteConnectionVC:(UIViewController *)delvc
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
                        if ([session.controllerName isEqualToString: VCName]) {
                            [self deleteQQConnection:session];
                            [session.SessionTask cancel];
                            if (_IsConsolePrint) {
                                NSLog(@"Cancel this url '%@'",session.urlStr);
                            }
                        }
                    }
                }
            }
        }
        [lock unlock];
    });
}
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
