//
//  QQTabbarViewController.m
//  tabbarTest
//
//  Created by Maybe on 2017/12/21.
//  Copyright © 2017年 JJBangKeJi. All rights reserved.
//

#import "QQTabBarController.h"
#define width          [UIScreen mainScreen].bounds.size.width
#define height        [UIScreen mainScreen].bounds.size.height
#define ButtonTag  100
#define tabbarHeight  44 //目前还不支持自定义高度   用的是系统的高度 这样不用刻意去适配Phone X了
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
    [self.tabBar  addSubview:self.tabBarView];
    
}

- (void)initVC{
    self.one = [fristViewController new];
    self.two = [twoViewController new];
    self.three = [threeViewController new];
    self.four = [fourViewController new];
    self.viewControllers = @[[[QQNavigationController alloc]initWithRootViewController:self.one],
                             [[QQNavigationController alloc]initWithRootViewController:self.two],
                             [[QQNavigationController alloc]initWithRootViewController:self.three],
                             [[QQNavigationController alloc]initWithRootViewController:self.four]];
}
- (void)createVc
{
    NSArray *heightBackground = @[@"square-hight",@"friendly-light",@"message-light",@"mine-light"];
    NSArray *backgroud = @[@"square",@"friendly",@"message",@"mine"];
    NSArray *VCname = @[@"首页",@"接单大厅",@"订单",@"消息"];
    self.item0 =[TabarItem buttonWithType:UIButtonTypeCustom];
    self.item1 =[TabarItem buttonWithType:UIButtonTypeCustom];
    self.item2 =[TabarItem buttonWithType:UIButtonTypeCustom];
    self.item3 =[TabarItem buttonWithType:UIButtonTypeCustom];
    NSArray *items = @[self.item0,self.item1,self.item2,self.item3];
    float TabWidth = width/backgroud.count;
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        TabarItem *item = items[i];
        item.frame = CGRectMake(i*TabWidth, 0, TabWidth, tabbarHeight);
        item.tag = ButtonTag + i;
        item.titleLabel.font = [UIFont systemFontOfSize:11];
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        [item setTitle:VCname[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
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
        
    }
    return _tabBarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

