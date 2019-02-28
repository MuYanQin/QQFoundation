//
//  QQTabbarViewController.m
//  tabbarTest
//
//  Created by Maybe on 2017/12/21.
//  Copyright © 2017年 JJBangKeJi. All rights reserved.
//

#import "QQTabBarController.h"
#import "DefaultAnimation.h"
#import "MCFactory.h"
#import "MCTabBarItem.h"
#import "UITabBar+MCBigItem.h"
#define kwidth          [UIScreen mainScreen].bounds.size.width
static const NSInteger ButtonTag = 100;

static const NSInteger tabbarHeight = 80;//自定义TabBar的高度
@interface QQTabBarController ()
@property (nonatomic,strong) MCTabBarItem *lastItem;
@end

@implementation QQTabBarController
- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

}
- (instancetype)initTabWithItems:(NSArray<MCTabBarItem *> *)items navClass:(Class)navClass;
{
    if (self = [super init]) {
        
        [self initVC:items navClass:navClass];
        [self createVc:items];
        //去除tab的横线
        [self.tabBar setBackgroundImage:[UIImage new]];
        [self.tabBar setShadowImage:[UIImage new]];
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //去除系统的UITabBarButton
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *btn in self.tabBar.subviews) {
        //遍历系统tabbar的子控件
        if ([btn isKindOfClass:class]) {
            [btn removeFromSuperview];
        }
    }
}
/**
 改变tabbar的高度
 */
- (void)viewWillLayoutSubviews{
    //这里设置高度  默认就是系统的高度
//    CGRect tabFrame = self.tabBar.frame;
//    tabFrame.size.height = tabbarHeight;
//    tabFrame.origin.y = self.view.frame.size.height - tabbarHeight;
//    self.tabBar.frame = tabFrame;
}
- (void)initVC:(NSArray<MCTabBarItem *> *)items navClass:(Class)navClass{
    NSMutableArray *vcs = [NSMutableArray array];
    for (MCTabBarItem *item in items) {
        UINavigationController *nav = (UINavigationController *) [[navClass alloc] initWithRootViewController:item.vc];
        [vcs addObject:nav];
    }

    self.viewControllers = vcs;
}
- (void)createVc:(NSArray<MCTabBarItem *> *)items
{
    float TabWidth = kwidth/items.count;
    for (int i=0; i<items.count; i++) {
        MCTabBarItem *item = items[i];
        item.frame = CGRectMake(i*TabWidth, 0, TabWidth, self.tabBar.frame.size.height);
        [item setImage:item.defaultImg forState:UIControlStateNormal];
        [item setImage:item.selectedImg forState:UIControlStateSelected];
        [item setTitle:item.text forState:UIControlStateNormal];
        item.tag = ButtonTag + i;
        item.titleLabel.font = self.font;
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        [item setTitleColor:self.defaultColor forState:UIControlStateNormal];
        [item setTitleColor:self.selectedColor forState:UIControlStateSelected];
        if (i == 0) {
            item.selected  = YES;
            self.lastItem = item;
            self.SelectIndex = 0;
        }
        [item addTarget:self action:@selector(selectedTab:)forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:item];
    }

}
- (void)selectedTab:(MCTabBarItem *)item
{
    if (self.lastItem) {
        self.lastItem.selected = NO;
    }
    self.selectedIndex = item.tag - ButtonTag;
    self.SelectIndex = self.selectedIndex;
    item.selected = YES;
    self.lastItem = item;
    [self QQTabBarController:self didSelect:self.viewControllers[self.selectedIndex]];
}
- (void)QQTabBarController:(QQTabBarController *)TabBarController  didSelect:(UIViewController *)viewcontroller
{

}
//设置选中的下标
- (void)setTabIndex:(NSInteger)index
{
    MCTabBarItem *item = [self.tabBar viewWithTag:index + ButtonTag];
    [self selectedTab:item];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

