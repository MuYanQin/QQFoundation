//
//  MCDownloadManager.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/12.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCDownloadItem;
@interface MCDownloadManager : NSObject
+ (instancetype)defaultManager;
- (MCDownloadItem *)startDownloadWith:(NSString *)downloadString;
- (void)pauseTaskWith:(MCDownloadItem *)item;
- (void)PauseAllTask;
- (void)resumeTaskWith:(MCDownloadItem *)item;
- (void)resumeAllTask;
@end
