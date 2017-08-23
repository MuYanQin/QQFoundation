//
//  uiview+MB.h
//  Teacher
//
//  Created by tlt on 16/8/11.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface  UIView (uiview_MB)

/**信息提示框*/
@property(strong, nonatomic) MBProgressHUD * hud;
/**提示信息*/
- (void)Message:(NSString *)message;

/**提示信息，N秒后关闭*/
- (void)Message:(NSString *)message HiddenAfterDelay:(NSTimeInterval)delay;

/**自定义提示框位置*/
- (void)Message:(NSString *)message YOffset:(float)yoffset HiddenAfterDelay:(NSTimeInterval)delay;

/**展示Loading标示*/
- (void)Loading:(NSString *)message;

- (void)Loading_0314;

/**隐藏*/
- (void)HiddenAfterDelay:(NSTimeInterval)delay;

/**隐藏*/
- (void)Hidden;

/*是否Loading中*/
- (BOOL)IsLoading;
@end
