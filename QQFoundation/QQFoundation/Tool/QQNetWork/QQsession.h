//
//  QQsession.h
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/17.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QQsession : NSObject
@property (copy, nonatomic) NSString *urlStr;///<记录当前下载的URl



- (NSURLSessionDataTask *)TXDGetWithUrl:(NSString *)url
                                    Dic:(NSDictionary *)dic
                                   from:(UIViewController *)controller
                                success:(void(^)(id responseObject))success
                                  False:(void(^)(NSError *error))False;

- (NSURLSessionDataTask *)TXDPostWithUrl:(NSString *)url
                                     Dic:(NSDictionary *)dic
                                    from:(UIViewController *)controller
                                 success:(void(^)(id responseObject))success
                                   False:(void(^)(NSError *error))False;

- (NSURLSessionDataTask *)TXDTableWithUrl:(NSString *)url
                                      Dic:(NSDictionary *)dic
                                     from:(UIViewController *)controller
                                  success:(void(^)(id responseObject))success
                                    False:(void(^)(NSError *error))False;

- (NSURLSessionDataTask *)TXDGetCacheWithUrl:(NSString *)url
                                         Dic:(NSDictionary *)dic
                                        from:(UIViewController *)controller
                                     success:(void(^)(id responseObject))success
                                       False:(void(^)(NSError *error))False;


- (NSURLSessionDataTask *)TXDUploadWithUrl:(NSString *)urlStr
                                       Dic:(NSDictionary *)dic
                              MutableArray:(NSMutableArray *)Images
                                      from:(UIViewController *)controller
                                  Progress:(void (^)(NSProgress *uploadProgress))Progress
                                   success:(void(^)(id responseObject))success
                                     False:(void(^)(NSError *error))False;


- (void)cancelWithOperation:(NSURLSessionDataTask *)operation;

@end
