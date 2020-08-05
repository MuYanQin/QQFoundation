//
//  MCDownloadManager.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/12.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MCDownloadItem;
@interface MCDownloadManager : NSObject
+ (instancetype)defaultManager;

- (void)addCompletionHandler:(void(^)())completionHandler identifier:(NSString *)identifier;
/**
 开始下载任务
 如果是已下载完成则直接返回 之前暂停的 继续下载
 @param downloadString 下载地址
 @return 任务状态
 */
- (MCDownloadItem *)startDownloadWith:(NSString *)downloadString;

/**
 暂停一个任务

 @param downloadString 下载的url
 */
- (void)pauseTaskWith:(NSString *)downloadString;

/**
 暂停全部任务
 */
- (void)PauseAllTask;

/**
 恢复一个任务

 @param downloadString 下载URL
 */
- (void)resumeTaskWith:(NSString *)downloadString;

/**
 恢复全部任务
 */
- (void)resumeAllTask;

/**
 删除一个文件

 @param downloadString 下载URL
 */
- (void)removeFileWith:(NSString *)downloadString;

/**
 清空全部文件
 */
- (void)cleanDisk;
@end
