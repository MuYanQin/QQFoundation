//
//  QQNetManegr.h
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/17.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QQsession.h"
#import <UIKit/UIKit.h>
#define Deprecated(instead) NS_DEPRECATED_IOS(2_0, 5_0, instead)
static NSString *const successCode = @"200";//配置正确返回的code码
static NSInteger const cuntomErrorCode = 8001; //自定义返回的errorCode值 不符合正确返回码的数据都在失败回调里
@interface QQNetManager : NSObject
@property (assign, nonatomic)    BOOL   IsConsolePrint;///< default is 'YES'  是否打印取消下载的URL
@property (nonatomic , strong) NSCache * dataCache;//缓存数据 最大3M 超出会被清理
@property (nonatomic , assign) NSInteger  cacheMin;//缓存时间。秒为单位  默认60S
+ (instancetype)defaultManager;

/**
 普通的get请求

 @param url 请求的网址
 @param parameters 请求拼接的参数
 @param controller 请求所在的界面
 @param Success 成功的回调
 @param False 失败的回调
 */
- (void)RTSGetWith:(NSString *)url
        Parameters:(NSDictionary *)parameters
              From:(UIViewController *)controller
          Successs:(void(^)(id responseObject))Success
             False:(void (^)(NSError * error))False;

/**
 普通的Post请求

 @param url 请求的网址
 @param parameters 请求拼接的参数
 @param controller 请求的界面
 @param Success 成功的回调
 @param False 失败的回调
 */
-(void)RTSPostWith:(NSString *)url
        Parameters:(NSDictionary *)parameters
              From:(UIViewController *)controller
          Successs:(void(^)(id responseObject))Success
             False:(void (^)(NSError * error))False;

/**
 带缓存的get请求 （一些不变的网址请求）
 
 @param url 请求的网址
 @param parameters 请求拼接的参数
 @param controller 请求的界面
 @param Success 成功的回调
 @param False 失败的回调
 */
- (void)RTSGetCacheWith:(NSString *)url
             Parameters:(NSDictionary *)parameters
                   From:(UIViewController *)controller
               Successs:(void(^)(id responseObject))Success
                  False:(void (^)(NSError * error))False;


/**
 上传图片的使用

 @param url 请求网址
 @param parameters 请求的参数
 @param Images 图片的数组
 @param controller 请求的界面
 @param fileMark 后台接受图片的字段
 @param Progress 上传的进度回调
 @param Success 成功的回调
 @param False 失败的回调
 */
- (void)RTSUploadWith:(NSString *)url
           Dictionary:(NSDictionary *)parameters
         MutableArray:(NSMutableArray *)Images
                 From:(UIViewController *)controller
                 fileMark:(NSString *)fileMark
             Progress:(void (^)(NSProgress *uploadProgress))Progress
              Success:(void(^)( id responseObject))Success
                False:(void(^)(NSError *error))False;


- (void)insertQQConnection:(QQsession *)hc;///<插入对象
- (void)deleteQQConnection:(QQsession *)hc;///<删除对象


//在返回的地方调用此方法取消下载
- (void)deleteConnectionVC:(UIViewController *)vc;///<销毁控制器时取消下载


- (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters;
@end
