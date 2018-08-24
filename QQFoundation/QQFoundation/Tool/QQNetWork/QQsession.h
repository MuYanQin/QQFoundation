//
//  QQsession.h
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/17.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger,QQSessionType){
    post = 0,
    get
};

typedef NS_ENUM (NSInteger,CacheType){
    ignore = 0,
    localData
};
@interface QQsession : NSObject
@property (copy, nonatomic) NSString *urlStr;///<记录当前下载的URl  MD5加密后的
@property (nonatomic , strong) NSURLSessionDataTask * SessionTask;//记录某次下载的任务
@property (nonatomic , copy) NSString * controllerName;//记录某次下载所在界面的名称

- (NSURLSessionDataTask *)TXDWith:(NSString *)url
                            Param:(NSDictionary *)param
                             from:(UIViewController *)controller
                          txdType:(QQSessionType)txdType
                          cacheType:(CacheType)cacheType
                          success:(void(^)(id responseObject))success
                            False:(void(^)(NSError *error))False;

- (NSURLSessionDataTask *)TXDUploadWithUrl:(NSString *)urlStr
                                       Dic:(NSDictionary *)dic
                              MutableArray:(NSMutableArray *)Images
                                      from:(UIViewController *)controller
                                  fileMark:(NSString *)fileMark
                                  Progress:(void (^)(NSProgress *uploadProgress))Progress
                                   success:(void(^)(id responseObject))success
                                     False:(void(^)(NSError *error))False;
@end
