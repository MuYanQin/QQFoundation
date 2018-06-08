//
//  QQTabbarViewController.m
//  tabbarTest
//
//  Created by Maybe on 2017/12/21.
//  Copyright © 2017年 JJBangKeJi. All rights reserved.
//

#import "QQTabBarController.h"
#import "DefaultAnimation.h"
#import "UIColor+Hexadecimal.h"
#import "MCTabBarItem.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#define kwidth          [UIScreen mainScreen].bounds.size.width
#define kheight        [UIScreen mainScreen].bounds.size.height
static const NSInteger ButtonTag = 100;
static const NSInteger tabbarHeight = 80;
@interface QQTabBarController ()
@property (nonatomic,strong) MCTabBarItem *lastItem;
@end

@implementation QQTabBarController
- (instancetype)init
{
    if (self = [super init]) {
//        self.tabBar.hidden = YES;
//        [self.tabBar setShadowImage:[UIImage new]];
//        [self.tabBar setBackgroundImage:[UIImage new]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVC];
    [self createVc];
    [self.tabBar addSubview:self.tabBarView];
//    [self.view addSubview:self.tabBarView];
    
}
- (void)viewWillLayoutSubviews{
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = tabbarHeight;
    tabFrame.origin.y = self.view.frame.size.height - tabbarHeight;
    self.tabBar.frame = tabFrame;
    CGRect rect = self.tabBar.bounds;
    self.tabBarView.frame = rect;
}
- (void)initVC{
    self.one = [fristViewController new];
    self.two = [twoViewController new];
    self.three = [threeViewController new];
    self.four = [fourViewController new];
    self.five = [fourViewController new];

    self.viewControllers = @[[[QQNavigationController alloc]initWithRootViewController:self.one],
                             [[QQNavigationController alloc]initWithRootViewController:self.two],
                             [[QQNavigationController alloc]initWithRootViewController:self.three],
                             [[QQNavigationController alloc]initWithRootViewController:self.four],
                             [[QQNavigationController alloc]initWithRootViewController:self.five]];
}
- (void)createVc
{
    NSArray *heightBackground = @[@"navigation_home_active",@"navigation_reward_active",@"navigation_Finding_car_active",@"navigation_authorized_active",@"navigation_mine_active"];
    NSArray *backgroud = @[@"navigation_home_defaut",@"navigation_reward_defaut",@"navigation_Finding_car_defaut",@"navigation_authorized_defaut",@"navigation_mine_defaut"];
    NSArray *VCname = @[@"首页",@"悬赏",@"寻车",@"授权",@"我的"];
    self.item0 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
    self.item1 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
    self.item1.isHasBackGroudImageview = YES;
    self.item2 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
    self.item2.backgroundColor = [UIColor clearColor];
    self.item3 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];
    self.item4 =[MCTabBarItem buttonWithType:UIButtonTypeCustom];

    NSArray *items = @[self.item0,self.item1,self.item2,self.item3,self.item4];
    float TabWidth = kwidth/backgroud.count;
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        MCTabBarItem *item = items[i];
        item.frame = CGRectMake(i*TabWidth, 0, TabWidth, tabbarHeight);
        item.tag = ButtonTag + i;
        item.backgroundColor = [UIColor redColor];
        item.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        [item setTitle:VCname[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor colorWithR:102 G:102 B:102 A:1] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor colorWithR:102 G:102 B:102 A:1] forState:UIControlStateSelected];
        if (i == 0) {
            item.selected  = YES;
            self.lastItem = item;
            self.SelectIndex = 0;
        }
        [item setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:heightImage] forState:UIControlStateSelected];
        [item addTarget:self action:@selector(selectedTab:)
       forControlEvents:UIControlEventTouchUpInside];

        [self.tabBarView addSubview:item];
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
//    [self.tabBar  addSubview:self.tabBarView];//每次点击的时候加一次  不然响应事件会被覆盖
    if (self.SelectIndex ==1) {
        self.item1.BackGroudImageName = @"navigation_reward_BG";
    }else{
        self.item1.BackGroudImageName = @"";
    }
    [self QQTabBarController:self didSelect:self.viewControllers[self.selectedIndex]];
}
- (void)QQTabBarController:(QQTabBarController *)TabBarController  didSelect:(UIViewController *)viewcontroller
{
    NSLog(@"%ld",(long)TabBarController.SelectIndex);
}
//设置选中的下标
- (void)setTabIndex:(NSInteger)index
{
    MCTabBarItem *item = [self.tabBarView viewWithTag:index + ButtonTag];
    [self selectedTab:item];
}

- (UIView *)tabBarView
{
    if (!_tabBarView) {
        _tabBarView = [[UIView alloc]init];
        _tabBarView.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, 0.4)];
        line.backgroundColor = [UIColor lightGrayColor];
        line.alpha = 0.4;
        [_tabBarView addSubview:line];
    }
    return _tabBarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

