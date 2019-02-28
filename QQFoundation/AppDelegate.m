//
//  AppDelegate.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/8/23.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "AppDelegate.h"
#import "MCDownloadManager.h"
#import "MCDetectionView.h"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>
#import "QQNetManager.h"
#import "MCUserInfo.h"

#import "MCHomeViewController.h"
#import "MCRewardViewController.h"
#import "MCSearchTViewController.h"
#import "MCAuthorViewController.h"
#import "MCMineViewController.h"
#import "QQNavigationController.h"
#import "MCTabBarItem.h"
@interface AppDelegate ()<JPUSHRegisterDelegate>
@property (nonatomic , strong) NSTimer * timer;
@property (nonatomic , assign) NSInteger  duration;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = self.TabBar;
    [self.window makeKeyAndVisible];
    [QQNetManager Instance].Domains = @[@"http://222.73.56.13:9020",@"www.baodu.com",@"www.jd.com"];
    
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //2e0551392cfc2b695e42a88d  自己的
    [JPUSHService setupWithOption:launchOptions appKey:@"2e0551392cfc2b695e42a88d"
                          channel:nil
                 apsForProduction:NO
            advertisingIdentifier:nil];
    [self registerRemoteNotification];
    return YES;
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
#pragma mark - iOS 10及以上中收到推送消息
//ios 10 而是在前台的时候回调
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *dic = notification.request.content.userInfo;
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}
// ios 10 从后台进入的时候回调
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    NSLog(@"%@",response.notification.request.content.userInfo);
    //        NSInteger x=[UIApplication sharedApplication].applicationIconBadgeNumber;
    //软件处于后台的时候不会走此方法点击一次  角标➖一
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
}
#pragma mark - APP运行中接收到通知(推送)处理 - iOS 10以下版本收到推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    //在已经打开app时收到通知
    if (application.applicationState == UIApplicationStateActive) {
        //振动
        completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
    } else if( application.applicationState == UIApplicationStateBackground){
        
    }else{//带激活状态
    }
} 
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"\n-->%@<--\n", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
}
/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}
- (QQTabBarController *)TabBar
{
    if (!_TabBar) {
        
        MCTabBarItem * item0 = [MCTabBarItem buttonWithType:UIButtonTypeCustom];
        item0.vc = [MCHomeViewController   new];
        
        MCTabBarItem * item1 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
        item1.vc = [MCRewardViewController new];

        MCTabBarItem * item2 =[MCTabBarItem  buttonWithType:UIButtonTypeCustom];
        item2.vc = [MCSearchTViewController new];

        MCTabBarItem * item3 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
        item3.vc = [MCAuthorViewController new];

        MCTabBarItem * item4 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
        item4.vc = [MCMineViewController   new];
        _TabBar = [[QQTabBarController alloc]initTabWithItems:@[item0,item1,item2,item3,item4] navClass:[QQNavigationController class]];
    }
    return _TabBar;
}
- (void)applicationWillResignActive:(UIApplication *)application{
    
//    [self testTimer];
    NSLog(@"%s",__func__);
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [self.timer invalidate];
    self.timer = nil;
    self.duration = 0;
    NSLog(@"%s", __func__);
}
- (void)testTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:true];
    [self.timer fire];
}

- (void)timerRun {
    _duration += 1;
    NSLog(@"%zd", _duration);
    NSLog(@"background time remain: %f", [UIApplication sharedApplication].backgroundTimeRemaining);
}

/**
 经过上面的代码测试 参考别人的：https://www.sohu.com/a/206606189_208051
 通过上面测试出completionHandler，在第一个后台下载任务完成时回调，这时后台App已经被唤醒，定时器开始输出计时秒数。然后其它的下载任务完成时不会再次回调该方法。所有下载任务完成时，没有处理completionHandler计时器继续运行。 调用执行completionHandler计时器停止运行，App继续处于休眠状态。
 
 1、闪退后下载并没有中断，手动杀死软件的不会再下载
 2、抓包发现闪退后下载并没有终止，也没有另起一个下载进程。故并不像网上所说的那样闪退后临时文件清除 重新开始一份下载（抓包每开启一个下载任务就会有个新的请求）
 3、下载的时候会下载俩个文件 一是下载的文件本身 一个是文件下载的记录信息  重启app的时候拿文件记录信息取下载文件
 4、下载的过程中出现网络挣断 再恢复可以下载（app没有杀死）
 */
-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%s", __func__);
    [[MCDownloadManager defaultManager]addCompletionHandler:completionHandler identifier:identifier];
}

- (void)registerRemoteNotification {
    /*
     警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
