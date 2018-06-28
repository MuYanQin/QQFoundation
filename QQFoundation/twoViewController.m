//
//  twoViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/25.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "twoViewController.h"
#import "NSDate+QQCalculate.h"
#import "MCDownloadManager.h"
#import "UIImage+Usually.h"
#import "UIView+MCPopView.h"
#import "UIView+MBProgress.h"
#import "fiveViewController.h"
#import "MCPushMediator.h"
#import "MCScrollTableView.h"
@interface twoViewController ()
@property (nonatomic,copy) NSString *dateAsString;
@property (nonatomic , strong) UIImageView * BackGroudImageview;
@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"two";
    self.view.backgroundColor = [UIColor yellowColor];
    [self nav_RightItemWithStr:@"Done" Selector:@selector(click)];
    MCScrollTableView *ss = [[MCScrollTableView alloc]initWithFrame:CGRectMake(0, 64,KScreenWidth, KScreenHeight - 64 - 80)];
    [self.view addSubview:ss];
    
    UIView *rr = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 100)];
    rr.backgroundColor = [UIColor lightGrayColor];
    ss.headerView = rr;
    
}
- (void)click
{
    [MCPushMediator pushToClassFromStaring:@"fiveVintroller" takeParameters:nil callBack:^(id data) {
        NSLog(@"213213");
    }];
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
