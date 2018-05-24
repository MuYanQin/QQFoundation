//
//  TabarItem.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/20.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabarItem : UIButton

/**
 设置角标  0 就是一个红点  小于0 消失   大于999  显示999+
 */
@property (nonatomic,assign) NSInteger Badge;

/**
 角标的背景颜色。默认红色
 */
@property (nonatomic,strong) UIColor *BackColor;

/**
 角标文字颜色。默认白色
 */
@property (nonatomic,strong) UIColor *TextColor;
@end
