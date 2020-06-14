//
//  MCNavHiddenViewController.m
//  QQFoundation
//
//  Created by leaduMac on 2020/6/14.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import "MCNavHiddenViewController.h"
#import "MCSearchCell.h"
#import "MCNavShadeViewController.h"
#import "QQNavigationController.h"
@interface MCNavHiddenViewController ()<QQNavigationNavHiddenDelegate>

@end

@implementation MCNavHiddenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"导航栏隐藏";
    
    self.tabManager[@"MCSearchItem"] = @"MCSearchCell";
    self.BaseQQTableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.Qtext(@"点我返回").Qfont(12).Qtarget(self, @selector(backClick))
    .QbgClolor([UIColor purpleColor]);
    button.frame = CGRectMake(20, 20, 70, 30);
    [self.view addSubview:button];
    
    QQTableViewSection *section = [QQTableViewSection section];
    QQWeakSelf
    for (int i = 0; i<=30; i++) {
        MCSearchItem *item = [[MCSearchItem alloc]init];
        item.text = [NSString stringWithFormat:@"点击查看渐变隐藏%d",i];
        item.selcetCellHandler = ^(MCSearchItem * item) {
            [weakSelf.navigationController pushViewController:[MCNavShadeViewController new] animated:YES];
        };
        item.allowSlide = YES;
        [section addItem:item];
    }
    [self.BaseMutableArray addObject:section];
    [self.tabManager replaceWithSectionsFromArray:self.BaseMutableArray];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((QQNavigationController *)self.navigationController).navHiddenDelegate = self;
}
- (UIViewController *)needHiddenNav{
    return self;
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
