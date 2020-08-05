//
//  MCPageViewSub1ViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/9/19.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "MCPageViewSub1ViewController.h"
#import "MCSearchCell.h"

@interface MCPageViewSub1ViewController ()

@end

@implementation MCPageViewSub1ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabManager[@"MCSearchItem"] = @"MCSearchCell";
    self.BaseQQTableView.isHasHeaderRefresh = NO;
    self.BaseQQTableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - MCNavHeight);
    QQTableViewSection *sec = [QQTableViewSection section];
    for (int i = 0; i<=100; i++) {
        MCSearchItem *item = [[MCSearchItem alloc]init];
        item.text = [NSString stringWithFormat:@"Search=%d",i];
        [sec addItem:item];
    }
    [self.BaseMutableArray addObject:sec];
    [self.tabManager replaceWithSectionsFromArray:self.BaseMutableArray];
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
