//
//  QQNetManegr.h
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/17.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//显示网络请求的view
#import "MCMonitorView.h"
#define Deprecated(instead) NS_DEPRECATED_IOS(2_0, 5_0, instead)
@class QQsession,AFHTTPSessionManager;
static NSString *const successCode = @"200";//配置正确返回的code码
@interface QQNetManager : NSObject
@property (nonatomic , strong) AFHTTPSessionManager * sessionManager;
@property (nonatomic , strong) MCMonitorView * monitorView;

/**
 是否打开监控 默认yes打开
 在didFinishLaunchingWithOptions初始化一次即可
 */
@property (nonatomic , assign) BOOL  isMonitor;

/**
 切换url功能的url数组。仅当isMonitor == yes 有意义
 在didFinishLaunchingWithOptions初始化一次即可
 */
@property (nonatomic , strong) NSArray * Domains;

/**
 缓存数据 最大3M 超出会被清理
 */
@property (nonatomic , strong) NSCache * dataCache;

/**
 缓存时间。秒为单位  默认60S
 */
@property (nonatomic , assign) NSInteger  cacheMin;

+ (instancetype)Instance;

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
 @param Images 图片字典的数组 格式@[@{@"imageName":image}] key:图片名称。 value 图片对象
 @param controller 请求的界面
 @param fileMark 后台接受图片的字段。为空的话 就用图片的名称
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
@end
