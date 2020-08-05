//
//  NotificationService.m
//  MCServerExtension
//
//  Created by qinmuqiao on 2018/7/3.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "NotificationService.h"
#import <AVFoundation/AVFoundation.h>
#import "MCPlayerMusic.h"
#import <AVFoundation/AVFoundation.h>
@interface NotificationService ()
@property (nonatomic , strong) AVAudioPlayer * AudioPlayer;
@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;
@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    self.bestAttemptContent.title = @"测试Extension";
    self.bestAttemptContent.body = @"秦慕乔";
    //此处也可由推送设置
    //官方说30s以内 https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SupportingNotificationsinYourApp.html#//apple_ref/doc/uid/TP40008194-CH4-SW10
//    self.bestAttemptContent.sound = [UNNotificationSound soundNamed:@"wechatMusic.mp3"];
    //手机震动 可用循环写 连续调用   推送的sound 设置文件名。 mutable-content设置为true
    //重要提醒。一定要看文件有没有加入bunld中！！！！
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
