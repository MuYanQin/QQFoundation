//
//  MCRewardViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "MCRewardViewController.h"
#import "MCVerificationCodeView.h"
#import "MCUserInfo.h"
#import "UILabel+MCChained.h"
#import "UIButton+MCChained.h"
#import "QQButton.h"
#import "NSString+Manage.h"
#import "NSMutableAttributedString+Manage.h"
#import "MCHoveringView.h"

#import "MCAuthorViewController.h"
#import "MCSearchTViewController.h"
#import "MCMineViewController.h"
@interface MCRewardViewController ()<MCHoveringListViewDelegate>
@property (nonatomic , strong) UIView * headerView;
@end
@implementation MCRewardViewController
{
    MCSearchTViewController *search;
    MCAuthorViewController *Author;
    MCMineViewController *mine;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"案例使用2";
    search= [MCSearchTViewController new];
    Author.fromHovering = YES;
    search.BaseQQTableView.height = search.BaseQQTableView.height - MCTabbarHeight - 50;
    Author  = [MCAuthorViewController new];
    Author.fromHovering = YES;
    mine = [MCMineViewController new];
    mine.fromHovering = YES;

    self.headerView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.headerView.backgroundColor = [UIColor purpleColor];
    
    
    MCHoveringView *hovering = [[MCHoveringView alloc]initWithFrame:CGRectMake(0, MCNavHeight, KScreenWidth, KScreenHeight - MCNavHeight - MCBottomDistance - MCTabbarHeight) deleaget:self];
    hovering.isMidRefresh = NO;
    [self.view addSubview:hovering];
    
    hovering.pageView.selectTitleFont = [UIFont systemFontOfSize:16];
    hovering.pageView.defaultTitleFont = [UIFont systemFontOfSize:16];
    hovering.pageView.defaultTitleColor = [UIColor redColor];
    hovering.pageView.selectTitleColor = [UIColor purpleColor];
}
- (NSArray<UIScrollView *> *)listView
{
    return @[search.BaseQQTableView,Author.BaseQQTableView,mine.BaseQQTableView];
}
- (UIView *)headView
{
    return self.headerView;
}
- (NSArray<UIViewController *> *)listCtroller
{
    return @[search,Author,mine];
}
- (NSArray<NSString *> *)listTitle
{
    return @[@"搜索",@"认证",@"我的"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
