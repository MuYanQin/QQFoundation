//
//  QQButton.h
//  QQButtonManer
//
//  Created by Yuan er on 16/3/13.
//  Copyright © 2016年 Yuan er. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+MCChained.h"
@interface QQButton : UIButton
@property (nonatomic , strong) id info;

/**
 开始倒计时
 */
- (void)startCountdown;

/**
 重置倒计时
 */
- (void)resetCountdown;
@end
