//
//  MCMineViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCMineViewController.h"
#import "QQNetManager.h"
@interface MCMineViewController ()

@end

@implementation MCMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //http://www.iopan.cn/medical/f/getUserInfor
    [[QQNetManager Instance]RTSGetWith:@"www.ipan.com:8080:maintan/f/" Parameters:nil From:self Successs:^(id responseObject) {
        
    } False:^(NSError *error) {
        
    }];
    
    [[QQNetManager Instance]RTSGetWith:@"http://www.iopan.cn/medical/f/getUserInfor" Parameters:@{@"userid":@"18e660daa75840e38e042ce176308e76"} From:self Successs:^(id responseObject) {
        
    } False:^(NSError *error) {
        
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
