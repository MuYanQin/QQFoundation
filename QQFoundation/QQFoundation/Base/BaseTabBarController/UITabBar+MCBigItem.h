//
//  UITabBar+MCBigItem.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/24.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (MCBigItem)
//传递那个大的button 为了超出部分能响应事件
@property (nonatomic , strong) UIButton * BigButton;
@end
