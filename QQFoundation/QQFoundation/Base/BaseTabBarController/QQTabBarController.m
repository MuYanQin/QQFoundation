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
    [self initVC];
    [self createVc];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

//    CGRect tabFrame = self.tabBar.frame;
//    tabFrame.size.height = tabbarHeight;
//    tabFrame.origin.y = self.view.frame.size.height - tabbarHeight;
//    self.tabBar.frame = tabFrame;
//    CGRect rect = self.tabBar.bounds;
//    self.tabBarView.frame = rect;
}
- (void)initVC{
    self.home   = [MCHomeViewController   new];
    self.reward = [MCRewardViewController new];
    self.search = [MCSearchViewController new];
    self.author = [MCAuthorViewController new];
    self.mine   = [MCMineViewController   new];

    self.viewControllers = @[[[QQNavigationController alloc]initWithRootViewController:self.home],
                             [[QQNavigationController alloc]initWithRootViewController:self.reward],
                             [[QQNavigationController alloc]initWithRootViewController:self.search],
                             [[QQNavigationController alloc]initWithRootViewController:self.author],
                             [[QQNavigationController alloc]initWithRootViewController:self.mine]];
}
- (void)createVc
{
    NSArray *heightBackground = @[@"navigation_home_active",@"navigation_reward_active",@"navigation_Finding_car_active",@"navigation_authorized_active",@"navigation_mine_active"];
    NSArray *backgroud = @[@"navigation_home_defaut",@"navigation_reward_defaut",@"navigation_Finding_car_defaut",@"navigation_authorized_defaut",@"navigation_mine_defaut"];
    NSArray *VCname = @[@"首页",@"悬赏",@"寻车",@"授权",@"我的"];
    self.item0 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
    self.item1 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
    self.item1.isHasBackGroudImageview = YES;
    self.item2 =[[MCTabBarItem alloc]init];
    self.item3 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
    self.item4 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];

    self.tabBar.BigButton = self.item2;
    
    NSArray *items = @[self.item0,self.item1,self.item2,self.item3,self.item4];
    float TabWidth = kwidth/backgroud.count;
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        MCTabBarItem *item = items[i];
        if (i == 2) {
            item.frame = CGRectMake(i*TabWidth, -38, TabWidth, TabWidth);
            [item setBackgroundImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
            [item setBackgroundImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateHighlighted];
        }else{
            item.frame = CGRectMake(i*TabWidth, 0, TabWidth, tabbarHeight);
            [item setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:heightImage] forState:UIControlStateSelected];
            [item setTitle:VCname[i] forState:UIControlStateNormal];
        }
        item.tag = ButtonTag + i;
        item.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        [item setTitleColor:getColor(102, 102, 102) forState:UIControlStateNormal];
        [item setTitleColor:getColor(102, 102, 102) forState:UIControlStateSelected];
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
    if (self.SelectIndex ==1) {
        self.item1.BackGroudImageName = @"navigation_reward_BG";
    }else{
        self.item1.BackGroudImageName = @"213123";
    }
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

