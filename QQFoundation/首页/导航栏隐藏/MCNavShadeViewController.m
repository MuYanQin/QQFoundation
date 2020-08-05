//
//  MCNavShadeViewController.m
//  QQFoundation
//
//  Created by leaduMac on 2020/6/14.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "MCNavShadeViewController.h"
#import "MCSearchCell.h"
@interface MCNavShadeViewController ()

@end

@implementation MCNavShadeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"导航栏渐变";

    self.tabManager[@"MCSearchItem"] = @"MCSearchCell";
    self.BaseQQTableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    QQWeakSelf
    self.BaseQQTableView.scrollViewDidScroll = ^(UIScrollView *scrollView) {
        CGFloat alpha = scrollView.contentOffset.y/ 300;
        [weakSelf navAlpha:alpha];
    };
    [self.view addSubview:self.navBar];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner_h"]];
    img.frame = CGRectMake(0, 0, KScreenWidth, 200);
    [self.BaseQQTableView setTableHeaderView:img];
    
    QQTableViewSection *section = [QQTableViewSection section];
    for (int i = 0; i<=30; i++) {
        MCSearchItem *item = [[MCSearchItem alloc]init];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
