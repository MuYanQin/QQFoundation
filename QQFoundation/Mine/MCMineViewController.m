//
//  MCMineViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCMineViewController.h"
#import "MCSearchCell.h"

@interface MCMineViewController ()

@end

@implementation MCMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabManager[@"MCSearchItem"] = @"MCSearchCell";
    if (self.fromHovering) {
        self.BaseQQTableView.top = 0;
    }else{
        self.BaseQQTableView.height = self.BaseQQTableView.height - MCTabbarHeight;
    }
    [self.BaseQQTableView setUpWithUrl:@"" Parameters:@{@"page":@"1",@"name":@"ahah"} formController:self];
    
    [self.BaseQQTableView setUpWithUrl:@"" Parameters:@{@"name":@"ahah"} formController:self];
}
- (void)QQtableView:(QQtableView *)QQtableView requestFailed:(NSError *)error
{
    
}
- (void)QQtableView:(QQtableView *)QQtableView isPullDown:(BOOL)PullDown SuccessData:(id)SuccessData
{
    
}
- (void)initUI{
    QQTableViewSection *sec = [QQTableViewSection section];
    
    for (int i = 0; i<=10; i++) {
        MCSearchItem *item = [[MCSearchItem alloc]init];
        item.text = [NSString stringWithFormat:@"mine=%d",i];
        [sec addItem:item];
    }
    [self.BaseMutableArray addObject:sec];
    [self.tabManager replaceSectionsWithSectionsFromArray:self.BaseMutableArray];
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
