//
//  UIView+AlertMessage.m
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "UIView+AlertMessage.h"

@implementation UIView (AlertMessage)
/**
 *  alert类型提示框
 *
 *  @param message 传入的提示信息
 */
- (void)message:(NSString *)message
{
    UIAlertController *AlertControler = [UIAlertController alertControllerWithTitle:nil    message:message preferredStyle:UIAlertControllerStyleAlert];
    [[[UIApplication sharedApplication].delegate window].rootViewController presentViewController:AlertControler animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AlertControler dismissViewControllerAnimated:YES completion:nil];
        
    });
}
/**
 *  alert类型提示框
 *
 *  @param message 传入的提示信息
 *  @param delay   延时时间
 */
- (void)message:(NSString *)message andDelay:(CGFloat)delay
{
    UIAlertController *AlertControler = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [[[UIApplication sharedApplication].delegate window].rootViewController presentViewController:AlertControler animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AlertControler dismissViewControllerAnimated:YES completion:nil];
    });
}
@end
