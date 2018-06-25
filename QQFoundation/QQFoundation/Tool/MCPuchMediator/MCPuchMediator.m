//
//  MCPuchMediator.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/25.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPuchMediator.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@implementation MCPuchMediator

+ (void)pushToClassFromStaring:(NSString *)ClassString takeParameters:(NSDictionary *)Parameters callBack:(void (^)(id))callBack
{
    if (ClassString.length <=0) {
        NSLog(@"MCPuchMediator error log -> classString can't be nil!");
        return;
    }
    Class class = NSClassFromString(ClassString);
    UIViewController *ViewController =(UIViewController *)[[class alloc]init];
    if (!ViewController) {
        NSLog(@"MCPuchMediator error log -> %@ is can't push  because it is't exist!",ClassString);
        return;
    }
    if (callBack) {
        ViewController.pushCallBack = callBack;
    }
    [ViewController setValuesForKeysWithDictionary:Parameters];
    [[self currentViewController].navigationController pushViewController:ViewController animated:YES];
}

+ (UIViewController*)currentViewController
{
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

+ (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if (viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}
@end

@implementation NSObject (MCParameters)

- (void)setPushCallBack:(callBack)pushCallBack
{
    objc_setAssociatedObject(self, @selector(pushCallBack), pushCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);

}
- (callBack)pushCallBack
{
    return objc_getAssociatedObject(self, _cmd);
}
@end

