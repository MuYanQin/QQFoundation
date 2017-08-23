//
//  UIView+AlertMessage.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AlertMessage)
/**
 *  alert类型提示框
 *
 *  @param message 传入的提示信息
 */
- (void)message:(NSString *)message;
/**
 *  alert类型提示框
 *
 *  @param message 传入的提示信息
 *  @param delay   延时时间
 */
- (void)message:(NSString *)message andDelay:(CGFloat)delay;
@end
