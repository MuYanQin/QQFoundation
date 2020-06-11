//
//  QQNavigationController.h
//  Customer
//
//  Created by 秦慕乔 on 16/5/16.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQNavigationControllerDelegate <NSObject>

@optional

/// 返回需要隐藏nav的vc
- (UIViewController *)needHiddenNav;

@end
@interface QQNavigationController : UINavigationController
@property (nonatomic,assign) BOOL forbidSlider;//是否禁止滑动
@property (nonatomic , assign) id<QQNavigationControllerDelegate>  hiddenDelegate;

@end

