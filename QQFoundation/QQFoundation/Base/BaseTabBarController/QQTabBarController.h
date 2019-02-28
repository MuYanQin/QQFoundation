//
//  QQTabbarViewController.h
//  tabbarTest
//
//  Created by Maybe on 2017/12/21.
//  Copyright © 2017年 JJBangKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCTabBarItem;
@interface QQTabBarController : UITabBarController

@property (nonatomic,assign) NSInteger SelectIndex;

/**字体*/
@property (nonatomic , strong) UIFont * font;
/**默认字体颜色*/
@property (nonatomic,strong) UIColor * defaultColor;
/**选中字体颜色*/
@property (nonatomic,strong) UIColor * selectedColor;

- (instancetype)initTabWithItems:(NSArray<MCTabBarItem *> *)items navClass:(Class)navClass;

/**
 修改选中的下标

 @param index 下标
 */
- (void)setTabIndex:(NSInteger)index;

@end

