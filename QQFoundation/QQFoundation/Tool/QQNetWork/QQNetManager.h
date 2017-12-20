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

@interface QQNetManager : NSObject
{
    NSMutableDictionary *_dataDic;///<纪录下载的url
    NSMutableArray      *_VCS; ///<纪录当前控制器有哪些下载
    UIAlertView         * _alert;///<防止alert重复出现
}
@property (assign, nonatomic)    BOOL   IsConsolePrint;///< default is 'YES'  是否打印取消下载的URL
+ (id)defaultManager;


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
 @param Progress 上传的进度回调
 @param Success 成功的回调
 @param False 失败的回调
 */
- (void)RTSUploadWith:(NSString *)url
           Dictionary:(NSDictionary *)parameters
         MutableArray:(NSMutableArray *)Images
                 From:(UIViewController *)controller
             Progress:(void (^)(NSProgress *uploadProgress))Progress
              Success:(void(^)( id responseObject))Success
                False:(void(^)(NSError *error))False;

/**
  QQTableview使用的请求，因为统一处理的失败请求 无失败的返回  故TableView 独有一个

 @param url 请求的网址
 @param parameters 请求的参数
 @param controller 请求的界面
 @param Success 成功的回调
 @param False 失败的回调
 */
- (void)RTSTableWith:(NSString *)url
          Parameters:(NSDictionary *)parameters
                From:(UIViewController *)controller
            Successs:(void(^)(id responseObject))Success
               False:(void (^)(NSError * error))False;




- (void)insertQQConnection:(QQsession *)hc;///<插入对象
- (void)deleteQQConnection:(QQsession *)hc;///<删除对象

- (void)showProgressHUDWithType:(NSInteger)type;///<显示提示
//控制器用
- (void)insertConnectionVC:(UIViewController *)VC
              QQConnection:(QQsession *)hc
           SessionDataTask:(NSURLSessionDataTask *)task;///<插入当前控制器的

//在返回的地方调用此方法取消下载
- (void)deleteConnectionVC:(UIViewController *)vc;///<销毁控制器时取消下载

@end
