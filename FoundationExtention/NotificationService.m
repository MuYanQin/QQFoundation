//
//  NotificationService.m
//  FoundationExtention
//
//  Created by qinmuqiao on 2018/7/2.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    //30s的时间来处理数据。完成之后手动调用 contentHandler 30秒系统自动调用
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
//    bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
//    bestAttemptContent.body = "我是新修改的body"
//    bestAttemptContent.title = "我是新修改的title"
//    bestAttemptContent.subtitle = "我是subTitle"
//
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
