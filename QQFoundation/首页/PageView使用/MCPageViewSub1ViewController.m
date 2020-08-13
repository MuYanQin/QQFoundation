//
//  MCPageViewSub1ViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/9/19.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "MCPageViewSub1ViewController.h"
#import "MCSearchCell.h"
#import "MCHomeViewController.h"
@interface MCPageViewSub1ViewController ()

@end

@implementation MCPageViewSub1ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabManager[@"MCSearchItem"] = @"MCSearchCell";
    self.BaseQQTableView.hasHeaderRefresh = NO;
    self.BaseQQTableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - MCNavHeight - 50);
    QQTableViewSection *sec = [QQTableViewSection section];
    for (int i = 0; i<=100; i++) {
        MCSearchItem *item = [[MCSearchItem alloc]init];
        item.selcetCellHandler = ^(id item) {
            [self.navigationController pushViewController:[MCHomeViewController new] animated:YES];
        };
        item.text = [NSString stringWithFormat:@"Search=%d",i];
        [sec addItem:item];
    }
    [self.BaseMutableArray addObject:sec];
    [self.tabManager replaceWithSectionsFromArray:self.BaseMutableArray];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"123");
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"321");
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
