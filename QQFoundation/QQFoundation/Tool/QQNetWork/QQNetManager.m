//
//  QQNetManegr.m
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/17.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import "QQNetManager.h"
#import "QQTool.h"
@implementation QQNetManager
{
    NSURLSessionDataTask *operation;
    NSLock *lock;
}
- (id)init
{
    if (self = [super init]) {
        _dataDic = [[NSMutableDictionary alloc]init];
        _VCS = [NSMutableArray array];
        _IsConsolePrint = YES;
    }
    return self;
}
+ (id)defaultManager{
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
    QQsession *QS= [_dataDic objectForKey:[self cacheKeyWithURL:url parameters:parameters]];
    if (!QS) {
        QS = [[QQsession alloc]init];
        QS.urlStr = [self cacheKeyWithURL:url parameters:parameters];
        [QS TXDGetWithUrl:url Dic:parameters from:controller success:^(id responseObject) {
            Success(responseObject);
        } False:^(NSError *error) {
            False(error);
        }];
    }
}

- (void)RTSGetCacheWith:(NSString *)url Parameters:(NSDictionary *)parameters From:(UIViewController *)controller Successs:(void (^)(id))Success False:(void (^)(NSError *))False
{
    QQsession *QS= [_dataDic objectForKey:[self cacheKeyWithURL:url parameters:parameters]];
    if (!QS) {
        QS = [[QQsession alloc]init];
        QS.urlStr = [self cacheKeyWithURL:url parameters:parameters];
        [QS TXDGetCacheWithUrl:url Dic:parameters from:controller success:^(id responseObject) {
            Success(responseObject);
        } False:^(NSError *error) {
            False(error);
        }];
    }
}
- (void)RTSPostWith:(NSString *)url Parameters:(NSDictionary *)parameters From:(UIViewController *)controller Successs:(void (^)(id))Success False:(void (^)(NSError *))False
{
    QQsession *QS= [_dataDic objectForKey:[self cacheKeyWithURL:url parameters:parameters]];
    if (!QS) {
        QS = [[QQsession alloc]init];
        QS.urlStr = [self cacheKeyWithURL:url parameters:parameters];
        [QS TXDPostWithUrl:url Dic:parameters from:controller success:^(id responseObject) {
            Success(responseObject);
        } False:^(NSError *error) {
            False(error);
        }];
    }
}
- (void)RTSTableWith:(NSString *)url Parameters:(NSDictionary *)parameters From:(UIViewController *)controller Successs:(void (^)(id))Success False:(void (^)(NSError *))False
{
    QQsession *QS= [_dataDic objectForKey:[self cacheKeyWithURL:url parameters:parameters]];
    if (!QS) {
        QS = [[QQsession alloc]init];
        QS.urlStr = [self cacheKeyWithURL:url parameters:parameters];
        [QS TXDTableWithUrl:url Dic:parameters from:controller success:^(id responseObject) {
            Success(responseObject);
        } False:^(NSError *error) {
            False(error);
        }];
    }
}
- (void)RTSUploadWith:(NSString *)url Dictionary:(NSDictionary *)parameters MutableArray:(NSMutableArray *)Images From:(UIViewController *)controller Progress:(void (^)(NSProgress *))Progress Success:(void (^)(id))Success False:(void (^)(NSError *))False
{
    QQsession *QS= [_dataDic objectForKey:[self cacheKeyWithURL:url parameters:parameters]];
    if (!QS) {
        QS = [[QQsession alloc]init];
        QS.urlStr = [self cacheKeyWithURL:url parameters:parameters];
        [QS TXDUploadWithUrl:url Dic:parameters MutableArray:Images from:controller Progress:^(NSProgress *uploadProgress) {
            Progress(uploadProgress);
        } success:^(id responseObject) {
            Success(responseObject);
        } False:^(NSError *error) {
            False(error);
        }];
    }
}

//为了防止单个网络请求多次请求 例如刷新
- (void)insertQQConnection:(QQsession *)hc
{
    if (!hc.urlStr)return;
    [_dataDic setObject:hc forKey:hc.urlStr];
    
}
- (void)deleteQQConnection:(QQsession *)hc
{
    [_dataDic removeObjectForKey:hc.urlStr];
    
}
/**
 某个线程A调用lock方法。这样，NSLock将被上锁。可以执行“关键部分”，完成后，调用unlock方法。
 
 如果，在线程A 调用unlock方法之前，另一个线程B调用了同一锁对象的lock方法。那么，线程B只有等待。直到线程A调用了unlock
 */
- (void)insertConnectionVC:(UIViewController *)VC  QQConnection:(QQsession *)hc  SessionDataTask:(NSURLSessionDataTask *)task
{
    [lock lock];
    NSString *VCName = [NSString stringWithFormat:@"%@",VC];
    NSDictionary *Dic = @{VCName:hc,@"Task":task};
    [_VCS addObject:Dic];
    [lock unlock];
}
//控制器消失的时候取消下载
- (void)deleteConnectionVC:(UIViewController *)vc
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_VCS];
        NSMutableArray *VCArray = [NSMutableArray arrayWithArray:vc.childViewControllers];
        //自定义的nav里面修改了一定有值
        [VCArray addObject:vc];///<把父控制器加进来
        
        /**
         有的三方滑动视图  或者自己的写的segment都会用到addchildviewcontroller：
         但是点击返回直接返回到上一个界面  segment的父视图是自己写的另一个界面 而三方的滑动视图是别人的
         */
        //这里主要还是根据入库的控制器来写不是一定的  根据个人需要
        for (UIViewController *VC in VCArray) {
            @autoreleasepool {
                NSString *VCName = [NSString stringWithFormat:@"%@",VC];
                for (NSDictionary *TempDic in tempArr) {///<在存储请求的数据里找对应的界面
                    @autoreleasepool {
                        if (TempDic[VCName]) {
                            [self deleteQQConnection:TempDic[VCName]];
                            [(QQsession *)TempDic[VCName] cancelWithOperation:TempDic[@"Task"]];
                            if (_IsConsolePrint) {
                                NSLog(@"Cancel this url '%@'",[(QQsession *)TempDic[VCName] urlStr]);
                            }
                            [_VCS removeObject:TempDic];
                        }
                    }
                }
            }
        }
        [lock unlock];
    });
}
- (void)showProgressHUDWithType:(NSInteger)type {
    //解决alert重弹出
    if (_alert.isVisible) {
        return;
    }
    NSString *msg = nil;
    switch (type) {
        case 0:
        {
            msg =@"网络连接异常，请检查网络！";
            break;
        }
        case 1:
        {
            msg = @"服务故障，正在抢修！";
            break;
        }
            
        default:
            break;
    }
    _alert  =  [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
    [_alert show];
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
    return cacheKey;
}
@end
