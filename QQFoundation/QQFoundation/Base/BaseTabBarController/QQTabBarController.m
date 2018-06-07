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
#define width          [UIScreen mainScreen].bounds.size.width
#define height        [UIScreen mainScreen].bounds.size.height
static const NSInteger ButtonTag = 100;
static const NSInteger tabbarHeight = 44; //目前还不支持自定义高度   用的是系统的高度 这样不用刻意去适配Phone X了
@interface QQTabBarController ()
@property (nonatomic,strong) TabarItem *lastItem;
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
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar  addSubview:self.tabBarView];
    
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
    self.item0 =[TabarItem buttonWithType:UIButtonTypeCustom];
    self.item1 =[TabarItem buttonWithType:UIButtonTypeCustom];
    self.item2 =[TabarItem buttonWithType:UIButtonTypeCustom];
    self.item2.backgroundColor = [UIColor clearColor];
    self.item3 =[TabarItem buttonWithType:UIButtonTypeCustom];
    self.item4 =[TabarItem buttonWithType:UIButtonTypeCustom];

    NSArray *items = @[self.item0,self.item1,self.item2,self.item3,self.item4];
    float TabWidth = width/backgroud.count;
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        if (i==2) {
            UIImageView *imm = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigation_Finding_car_background"]];
            imm.frame = CGRectMake(i*TabWidth + TabWidth/6, -5, TabWidth*2/3, TabWidth*2/3);
            [self.tabBarView addSubview:imm];
        }
        TabarItem *item = items[i];
        item.frame = CGRectMake(i*TabWidth, 0, TabWidth, tabbarHeight);
        item.tag = ButtonTag + i;
        item.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
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
- (void)selectedTab:(TabarItem *)item
{
    if (self.lastItem) {
        self.lastItem.selected = NO;
    }
    self.selectedIndex = item.tag - ButtonTag;
    self.SelectIndex = self.selectedIndex;
    item.selected = YES;
    self.lastItem = item;
    [self.tabBar  addSubview:self.tabBarView];//每次点击的时候加一次  不然响应事件会被覆盖
    
    [self QQTabBarController:self didSelect:self.viewControllers[self.selectedIndex]];
}
- (void)QQTabBarController:(QQTabBarController *)TabBarController  didSelect:(UIViewController *)viewcontroller
{
    NSLog(@"%ld",(long)TabBarController.SelectIndex);
}
//设置选中的下标
- (void)setTabIndex:(NSInteger)index
{
    TabarItem *item = [self.tabBarView viewWithTag:index + ButtonTag];
    [self selectedTab:item];
}
- (UIView *)tabBarView
{
    if (!_tabBarView) {
        CGRect rect = self.tabBar.bounds;
        _tabBarView = [[UIView alloc]initWithFrame:rect];
        _tabBarView.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 0.4)];
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

