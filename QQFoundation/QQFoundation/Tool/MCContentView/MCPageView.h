//
//  MCPageView.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/10.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCPageView;
@protocol MCPageViewDelegate <NSObject>
- (void)MCPageView:(MCPageView *)MCPageView didSelectIndex:(NSInteger)Index;
@end

@interface MCPageView : UIView

@property (nonatomic , assign) id<MCPageViewDelegate>  delegate;
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
 属性可选 默认平分整个屏幕 最小60
 */
@property (nonatomic , assign) CGFloat  titleButtonWidth;


/**
 item下  横线的颜色
 */
@property (nonatomic , strong) UIColor * lineColor;


/**
 是否可以滑动 默认yes
 */
@property (nonatomic , assign) BOOL  canSlide;

/**
 手动选中某个iem

 @param index item下标
 */
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
