//
//  QQNavigationController.h
//  Customer
//
//  Created by Yuan er on 16/5/16.
//  Copyright © 2016年 Yuan er. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQNavigationNavBackDelegate <NSObject>

@optional
/**
 获取返回的点击事件
 使用时viewController 在viewWillAppear中添加代理
 @return 获取点击事件的viewController
*/
- (void)backItemClickEvent;

- (UIViewController *)needBackNav;

@end

@protocol QQNavigationNavHiddenDelegate <NSObject>

@optional

/**
 隐藏nav
 在viewWillApear中添加代理
 @return 隐藏nav 的viewController
*/
- (UIViewController *)needHiddenNav;

@end


@interface QQNavigationController : UINavigationController

/**是否禁止滑动*/
@property (nonatomic,assign) BOOL forbidSlider;///<是否禁止滑动

/// 代理
@property (nonatomic , weak) id<QQNavigationNavHiddenDelegate>  navHiddenDelegate;

@property (nonatomic , weak) id<QQNavigationNavBackDelegate>  navBackDelegate;

@end

