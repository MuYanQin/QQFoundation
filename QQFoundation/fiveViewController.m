//
//  fiveViewController.m
//  QQFoundation
//
//  Created by Maybe on 2017/12/22.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fiveViewController.h"
#import "fourViewController.h"
#import "MCPushMediator.h"
@interface fiveViewController ()

@end

@implementation fiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Five";
    self.view.backgroundColor = [UIColor redColor];
    self.callBackData = @"秦慕乔";
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
