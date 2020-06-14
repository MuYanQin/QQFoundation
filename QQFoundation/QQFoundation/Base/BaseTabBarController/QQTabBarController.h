//
//  QQTabbarViewController.h
//  tabbarTest
//
//  Created by Maybe on 2017/12/21.
//  Copyright © 2017年 JJBangKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCTabBarItem,QQTabBarController;

@protocol QQTabBarControllerDelegate <NSObject>

@optional

/// 获取中间凸起b按钮的点击事件
- (void)clickBigItem;

/// 获取按钮的点击事件
/// @param tab tab
/// @param index 下标
- (void)QQTabBarController:(QQTabBarController *)tab didSelectdIndex:(NSInteger)index;

@end

@interface QQTabBarController : UITabBarController


/// 实例化方法
/// @param items item的数据
/// @param navClass UINavigationController 的class
- (instancetype)initTabWithItems:(NSArray<MCTabBarItem *> *)items navClass:(Class)navClass;

/**代理*/
@property (nonatomic , assign) id<QQTabBarControllerDelegate>  customDelegate;
/**字体*/
@property (nonatomic , strong) UIFont * font;
/**默认字体颜色*/
@property (nonatomic,strong) UIColor * defaultColor;
/**选中字体颜色*/
@property (nonatomic,strong) UIColor * selectedColor;
/**
 修改选中的下标
 @param index 下标
 */
- (void)setTabIndex:(NSInteger)index;
@end

