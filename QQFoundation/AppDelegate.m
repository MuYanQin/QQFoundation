//
//  AppDelegate.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/8/23.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "AppDelegate.h"
#import "QQNavigationController.h"
#import "MCDownloadManager.h"
@interface AppDelegate ()
@property (nonatomic , strong) NSTimer * timer;
@property (nonatomic , assign) NSInteger  duration;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = self.TabBar;

    [self.window makeKeyAndVisible];
    return YES;
}
- (QQTabBarController *)TabBar
{
    if (!_TabBar) {
        _TabBar = [[QQTabBarController alloc]init];
    }
    return _TabBar;
}
- (void)applicationWillResignActive:(UIApplication *)application{
    
    [self testTimer];
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
 */
-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%s", __func__);
    [[MCDownloadManager defaultManager]addCompletionHandler:completionHandler identifier:identifier];
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
