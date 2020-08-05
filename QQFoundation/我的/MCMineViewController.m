//
//  MCMineViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "MCMineViewController.h"
#import "MCSearchCell.h"
#import "NSObject+MB.h"
@interface MCMineViewController ()

@end

@implementation MCMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(100, 100, 100, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(100, 200, 100, 40);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(btnClick1) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
    
    /***
    self.tabManager[@"MCSearchItem"] = @"MCSearchCell";
    if (self.fromHovering) {
        self.BaseQQTableView.top = 0;
    }else{
        self.BaseQQTableView.height = self.BaseQQTableView.height - MCTabbarHeight;
    }
    [self.BaseQQTableView setUpWithUrl:@"" Parameters:@{@"page":@"1",@"name":@"ahah"} formController:self];
    
    [self.BaseQQTableView setUpWithUrl:@"" Parameters:@{@"name":@"ahah"} formController:self];
     */
}
- (void)btnClick
{
    //[self message:@"123"];

}
- (void)btnClick1
{
    [self loadingWith:@"加载中。。。"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self message:@"123"];
    });
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
    [self.tabManager replaceWithSectionsFromArray:self.BaseMutableArray];
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
