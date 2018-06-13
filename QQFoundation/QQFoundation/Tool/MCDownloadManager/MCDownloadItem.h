//
//  MCDownloadItem.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/12.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,MCDownload){
    MCDownloadWaiting = 0,
    MCDownloadLoading = 1,
    MCDownloadComplete = 2,
    MCDownloadError = 3
};
@interface MCDownloadItem : NSObject


/**
 下载状态
 */
@property (nonatomic , assign) MCDownload  loadStatus;
/**
 下载地址
 */
@property (nonatomic , copy) NSString * downloadString;


/**
 下载任务
 */
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

/**
 保存在本地的地址
 */
@property (nonatomic , copy) NSString * savePath;

/**
 断点续传用的resumeData
 */
@property (nonatomic , strong) NSDate * resumeData;
@end
