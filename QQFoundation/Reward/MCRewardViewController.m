//
//  MCRewardViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCRewardViewController.h"
#import "MCVerificationCodeView.h"
#import "MCUserInfo.h"
#import "MCChained.h"
#import "QQButton.h"
#import "NSString+Manage.h"
#import "NSMutableAttributedString+Manage.h"
#import "MCHoveringView.h"

#import "MCAuthorViewController.h"
#import "MCSearchTViewController.h"
#import "MCMineViewController.h"
@interface MCRewardViewController ()<MCHoveringListViewDelegate>

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
    Author  = [MCAuthorViewController new];
    mine = [MCMineViewController new];
    
    MCHoveringView *hovering = [[MCHoveringView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64) deleaget:self];
    hovering.isMidRefresh = YES;
    [self.view addSubview:hovering];
}
- (NSArray<UIScrollView *> *)listView
{
    return @[search.BaseQQTableView,Author.BaseQQTableView,mine.BaseQQTableView];
}
- (UIView *)headView
{
    return    [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 200)];
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
