//
//  QQNetManegr.h
//  QQNetManager
//
//  Created by Yuan er on 16/4/17.
//  Copyright © 2016年 Yuan er. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QQsession.h"
@class QQsession;

@interface QQNetManager : NSObject


/**建议启动时 配置服务器成功返回状态码 例如：200、000000*/
@property (nonatomic , copy) NSString * successCode;

/**返回code的字段值*/
@property (nonatomic , copy) NSString * codeKey;

/**返回提示信息的字段值*/
@property (nonatomic , copy) NSString * msgKey;

/**基础域名*/
@property (nonatomic , copy) NSString * baseURL;
/**
 缓存数据 最大3M 超出会被清理
 */
@property (nonatomic , strong) NSCache * dataCache;

/**
 缓存时间。秒为单位  默认60S
 */
@property (nonatomic , assign) NSInteger  cacheSec;

+ (instancetype)instance;


/// 配置网络请求参数
/// @param baseURL 基础域名
/// @param codeKey 返回code代码的key
/// @param successCode 正确code 字符
/// @param msgKey 提示信息key
- (void)configNetwork:(NSString *)baseURL codeKey:(NSString *)codeKey successCode:(NSString *)successCode msgStr:(NSString *)msgKey;

/**
 普通的get请求

 @param url 请求的网址
 @param param 请求拼接的参数
 @param controller 请求所在的界面
 @param success 成功的回调
 @param failed 失败的回调
 */
- (void)RTSGetWith:(NSString *)url
             param:(NSDictionary *)param
              from:(UIViewController *)controller
          success:(void(^)(id responseObject))success
             failed:(void (^)(NSError * error))failed;

/**
 普通的Post请求
 @param url 请求的网址
 @param param 请求拼接的参数
 @param controller 请求的界面
 @param success 成功的回调
 @param failed 失败的回调
 */
-(void)RTSPostWith:(NSString *)url
             param:(NSDictionary *)param
              from:(UIViewController *)controller
          success:(void(^)(id responseObject))success
             failed:(void (^)(NSError * error))failed;

/**
 Json提交的的Post请求
 @param url 请求的网址
 @param param 请求拼接的参数
 @param controller 请求的界面
 @param success 成功的回调
 @param failed 失败的回调
 */
-(void)RTSPostJsonWith:(NSString *)url
                 param:(NSDictionary *)param
              from:(UIViewController *)controller
          success:(void(^)(id responseObject))success
             failed:(void (^)(NSError * error))failed;

/**
 带缓存的get请求 （一些不变的网址请求）
 
 @param url 请求的网址
 @param param 请求拼接的参数
 @param controller 请求的界面
 @param success 成功的回调
 @param failed 失败的回调
 */
- (void)RTSGetCacheWith:(NSString *)url
                  param:(NSDictionary *)param
                  cache:(CacheType)cache
                   from:(UIViewController *)controller
               success:(void(^)(id responseObject))success
                  failed:(void (^)(NSError * error))failed;


/**
 上传图片的使用

 @param url 请求网址
 @param param 请求的参数
 @param images 图片字典的数组
 @param controller 请求的界面
 @param fileMark 后台接受图片的字段。为空的话 就用图片的名称
 @param progress 上传的进度回调
 @param success 成功的回调
 @param failed 失败的回调
 */
- (void)RTSUploadWith:(NSString *)url
                param:(NSDictionary *)param
               images:(NSMutableArray *)images
                 from:(UIViewController *)controller
             fileMark:(NSString *)fileMark
             progress:(void (^)(NSProgress *uploadProgress))progress
              success:(void(^)( id responseObject))success
                failed:(void(^)(NSError *error))failed;


- (void)insertQQConnection:(QQsession *)hc;///<插入对象
- (void)deleteQQConnection:(QQsession *)hc;///<删除对象

@end
