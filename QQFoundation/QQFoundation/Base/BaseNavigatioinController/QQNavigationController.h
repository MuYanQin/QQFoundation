//
//  QQNavigationController.h
//  Customer
//
//  Created by 秦慕乔 on 16/5/16.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQNavigationNavBackDelegate <NSObject>

@optional
/**
 获取返回的点击事件
 使用时viewController 在viewWillAppear中添加代理
 @return 获取点击事件的viewController
*/
- (UIViewController *)backItemClickEvent;

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
@property (nonatomic , assign) id<QQNavigationNavHiddenDelegate>  navHiddenDelegate;

@property (nonatomic , assign) id<QQNavigationNavBackDelegate>  navBackDelegate;

@end

