//
//  MCContent.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/9.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCContent;
@protocol MCContentDelegate <NSObject>
- (void)MCContent:(MCContent *)MCContent didSelectIndex:(NSInteger)Index;
@end

@interface MCContent : UIView


@property (nonatomic , strong) NSArray * contentCtrollers;

@property (nonatomic , strong) NSArray * contentTitles;

/**
 可选 默认[UIFont systemFontOfSize:14]
 */
@property (nonatomic , strong) UIFont * defaultTitleFont;
/**
 可选 默认[UIFont systemFontOfSize:14]
 */
@property (nonatomic , strong) UIFont * selectTitleFont;
/**
 可选 默认灰色
 */
@property (nonatomic , strong) UIColor * defaultTitleColor;
/**
 可选 默认黑色
 */
@property (nonatomic , strong) UIColor * selectTitleColor;

/**
 属性可选 默认平分整个屏幕
 */
@property (nonatomic , assign) CGFloat  titleButtonWidth;

- (void)selectIndex:(NSInteger)index;

/**
 实例化方法

 @param frame frame
 @param titles titleS数组
 @param controllers jiemian数组
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles  controllers:(NSArray *)controllers;
@end
