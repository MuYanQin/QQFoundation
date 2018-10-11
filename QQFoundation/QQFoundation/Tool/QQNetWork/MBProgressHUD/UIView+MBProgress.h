//
//  UIView+MBProgress.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/21.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface UIView (MBProgress)<MBProgressHUDDelegate>
/**信息提示框*/
@property(strong, nonatomic) MBProgressHUD * hud;

/**提示信息*/
- (void)message:(NSString *)message;

/**提示信息，N秒后关闭*/
- (void)message:(NSString *)message HiddenAfterDelay:(NSTimeInterval)delay;

/**自定义提示框位置*/
- (void)message:(NSString *)message YOffset:(float)yoffset HiddenAfterDelay:(NSTimeInterval)delay;

/**展示Loading标示*/
- (void)loadingWith:(NSString *)message;

- (void)loading;

/**隐藏*/
- (void)hiddenAfterDelay:(NSTimeInterval)delay;

/**隐藏*/
- (void)hiddenHUD;

/*是否Loading中*/
- (BOOL)isLoading;
@end
