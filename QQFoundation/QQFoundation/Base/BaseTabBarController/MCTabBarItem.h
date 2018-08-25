//
//  MCTabBarItem.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/8.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCTabBarItem : UIButton
/**
 设置角标  0 就是一个红点  小于0 消失   大于999  显示999+
 */
@property (nonatomic,assign) NSInteger Badge;

/**
 角标的背景颜色。默认红色
 */
@property (nonatomic,strong) UIColor *BadgeBackColor;

/**
 角标文字颜色。默认白色
 */
@property (nonatomic,strong) UIColor *BadgeTextColor;

@end
