//
//  NSObject+MB.h
//  QQFoundation
//
//  Created by qinmuqiao on 2019/3/21.
//  Copyright © 2019年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MB)<MBProgressHUDDelegate>
/**信息提示框*/
@property(strong, nonatomic) MBProgressHUD * hud;

/**提示信息*/
- (void)message:(NSString *)message;

/**提示信息，N秒后关闭*/
- (void)message:(NSString *)message after:(NSTimeInterval)delay;

/**自定义提示框位置*/
- (void)message:(NSString *)message yOffset:(float)yoffset after:(NSTimeInterval)delay;

/**展示Loading标示*/
- (void)loadingWith:(NSString *)message;

- (void)loading;

/**隐藏*/
- (void)hiddenHUD;

/*是否Loading中*/
- (BOOL)isLoading;

@end

NS_ASSUME_NONNULL_END
