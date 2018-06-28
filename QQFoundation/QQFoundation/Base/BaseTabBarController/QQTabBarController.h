//
//  QQTabbarViewController.h
//  tabbarTest
//
//  Created by Maybe on 2017/12/21.
//  Copyright © 2017年 JJBangKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fristViewController.h"
#import "twoViewController.h"
#import "threeViewController.h"
#import "fourViewController.h"
#import "QQNavigationController.h"
@class MCTabBarItem;
@interface QQTabBarController : UITabBarController
@property (nonatomic,strong) UIView *tabBarView;
@property (nonatomic,assign) NSInteger SelectIndex;//选中的下标

@property (nonatomic,strong) fristViewController *one;
@property (nonatomic,strong) twoViewController *two;
@property (nonatomic,strong) threeViewController *three;
@property (nonatomic,strong) fourViewController *four;
@property (nonatomic,strong) fourViewController *five;

/**第一个item*/
@property (nonatomic,strong) MCTabBarItem *item0;
/**第二个item*/
@property (nonatomic,strong) MCTabBarItem *item1;
/**第三个item*/
@property (nonatomic,strong) MCTabBarItem *item2;
/**第四个item*/
@property (nonatomic,strong) MCTabBarItem *item3;
/**第五个item*/
@property (nonatomic,strong) MCTabBarItem *item4;
/**
 修改选中的下标

 @param index 下标
 */
- (void)setTabIndex:(NSInteger)index;

@end

