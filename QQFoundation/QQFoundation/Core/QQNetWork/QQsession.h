//
//  QQsession.h
//  QQNetManager
//
//  Created by Yuan er on 16/4/17.
//  Copyright © 2016年 Yuan er. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**请求方式*/
typedef NS_ENUM (NSInteger,QQSessionType){
    post = 0,
    get
};
/**缓存模式*/
typedef NS_ENUM (NSInteger,CacheType){
    ignore = 0,
    diskCache,//磁盘缓存
    memoryCaceh//本地
};
/**提交数据格式*/
typedef NS_ENUM (NSInteger,CommiteType){
    keyV = 0,
    json
};
@interface QQsession : NSObject

/**记录当前请求的的URL*/
@property (copy, nonatomic) NSString *urlStr;
/**记录当前请求的URL  MD5加密后的*/
@property (copy, nonatomic) NSString *cacheKey;
/**记录请求的任务*/
@property (nonatomic , strong) NSURLSessionDataTask * SessionTask;

@property (nonatomic , assign) BOOL  showHUD;

/**
 数据请求

 @param url 请求的URL
 @param param 请求的参数
 @param txdType 请求的方式
 @param cacheType 请求缓存的方式
 @param commiteType 请求提交数据的方式
 @param success 请求成功的回调
 @param failed 请求失败的回调
 @return 返回当前请求的task
 */
- (NSURLSessionDataTask *)TXDWith:(NSString *)url
                            param:(NSDictionary *)param
                          txdType:(QQSessionType)txdType
                        cacheType:(CacheType)cacheType
                      commiteType:(CommiteType)commiteType
                          success:(void(^)(id responseObject))success
                            failed:(void(^)(NSError *error))failed;

/**
 文件上传

 @param urlStr 请求的URL
 @param dic 请求的参数
 @param images 图片的数组
 @param fileMark 图片的标记
 @param progress 进度的回调
 @param success 请求成功的回调
 @param failed 请求失败的回调
 @return 返回当前请求的task
 */
- (NSURLSessionDataTask *)TXDUploadWithUrl:(NSString *)urlStr
                                       dic:(NSDictionary *)dic
                                    images:(NSMutableArray *)images
                                  fileMark:(NSString *)fileMark
                                  progress:(void (^)(NSProgress *uploadProgress))progress
                                   success:(void(^)(id responseObject))success
                                     failed:(void(^)(NSError *error))failed;
@end
