//
//  MBProgressHUD+Category.h
//  wanlb
//
//  Created by 刘永峰 on 16/3/15.
//  Copyright © 2016年 Witgo. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Category)

/**
 *
 *  @brief 显示加载提示
 *
 *  @param title     文本
 *  @param superView 父视图
 *
 *  @return hud
 */
+ (MBProgressHUD *)showHUD:(NSString *)title toView:(UIView *)superView;

/**
 *  @brief  隐藏加载提示
 */
+ (void)hideHUD;

/**
 *  @brief 显示提示文本框
 *
 *  @param text      提示文本
 *  @param superView 父视图
 */
+ (void)showTotast:(NSString *)text toView:(UIView *)superView;
@end
