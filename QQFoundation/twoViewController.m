//
//  twoViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/25.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "twoViewController.h"
#import "fiveViewController.h"
#import "MCPushMediator.h"
#import "QQTabBarController.h"
#import "MCFactory.h"
@interface twoViewController ()

@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"two";

    [self nav_RightItemWithStr:@"Done" Selector:@selector(click)];
    UILabel *label = getLabel([UIFont systemFontOfSize:14],@"123", [UIColor redColor], left, CGRectMake(10, 70, 80, 20));
    [self.view addSubview:label];
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
