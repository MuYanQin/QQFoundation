//
//  QQNetManegr.h
//  QQNetManager
//
//  Created by Yuan er on 16/4/17.
//  Copyright © 2016年 Yuan er. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//显示网络请求的view
#import "MCMonitorView.h"
#import "QQsession.h"
#define Deprecated(instead) NS_DEPRECATED_IOS(2_0, 5_0, instead)
@class QQsession;
static NSString *const successCode = @"200";//配置正确返回的code码

@interface QQNetManager : NSObject
/**监控数据请求的View*/
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
@property (nonatomic , assign) NSInteger  cacheSec;

+ (instancetype)Instance;

/**
 普通的get请求

 @param url 请求的网址
 @param parameters 请求拼接的参数
 @param controller 请求所在的界面
 @param successs 成功的回调
 @param failed 失败的回调
 */
- (void)RTSGetWith:(NSString *)url
        parameters:(NSDictionary *)parameters
              from:(UIViewController *)controller
          successs:(void(^)(id responseObject))successs
             failed:(void (^)(NSError * error))failed;

/**
 普通的Post请求
 @param url 请求的网址
 @param parameters 请求拼接的参数
 @param controller 请求的界面
 @param successs 成功的回调
 @param failed 失败的回调
 */
-(void)RTSPostWith:(NSString *)url
        parameters:(NSDictionary *)parameters
              from:(UIViewController *)controller
          successs:(void(^)(id responseObject))successs
             failed:(void (^)(NSError * error))failed;

/**
 Json提交的的Post请求
 @param url 请求的网址
 @param parameters 请求拼接的参数
 @param controller 请求的界面
 @param successs 成功的回调
 @param failed 失败的回调
 */
-(void)RTSPostJsonWith:(NSString *)url
        parameters:(NSDictionary *)parameters
              from:(UIViewController *)controller
          successs:(void(^)(id responseObject))successs
             failed:(void (^)(NSError * error))failed;

/**
 带缓存的get请求 （一些不变的网址请求）
 
 @param url 请求的网址
 @param parameters 请求拼接的参数
 @param controller 请求的界面
 @param successs 成功的回调
 @param failed 失败的回调
 */
- (void)RTSGetCacheWith:(NSString *)url
             parameters:(NSDictionary *)parameters
                  cache:(CacheType)cache
                   from:(UIViewController *)controller
               successs:(void(^)(id responseObject))successs
                  failed:(void (^)(NSError * error))failed;


/**
 上传图片的使用

 @param url 请求网址
 @param parameters 请求的参数
 @param images 图片字典的数组
 @param controller 请求的界面
 @param fileMark 后台接受图片的字段。为空的话 就用图片的名称
 @param progress 上传的进度回调
 @param success 成功的回调
 @param failed 失败的回调
 */
- (void)RTSUploadWith:(NSString *)url
           parameters:(NSDictionary *)parameters
         imageArray:(NSMutableArray *)images
                 from:(UIViewController *)controller
                 fileMark:(NSString *)fileMark
             progress:(void (^)(NSProgress *uploadProgress))progress
              success:(void(^)( id responseObject))success
                failed:(void(^)(NSError *error))failed;


- (void)insertQQConnection:(QQsession *)hc;///<插入对象
- (void)deleteQQConnection:(QQsession *)hc;///<删除对象

//在返回的地方调用此方法取消下载
- (void)deleteConnectionVC:(UIViewController *)vc;///<销毁控制器时取消下载
@end
