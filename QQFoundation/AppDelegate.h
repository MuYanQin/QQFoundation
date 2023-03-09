//
//  AppDelegate.h
//  QQFoundation
//
//  Created by ZhangQun on 2017/8/23.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic , strong) QQTabBarController * TabBar0;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic , strong) QQTabBarController * TabBar;
@property (nonatomic , strong) QQTabBarController * TabBar2;
@property (nonatomic , strong) QQTabBarController * TabBa3;
@property (nonatomic , strong) QQTabBarController * TabBar4;

@property (nonatomic , strong) NSMutableArray * array;
@property (nonatomic , strong) NSMutableDictionary * dic;


@end

