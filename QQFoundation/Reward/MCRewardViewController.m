//
//  MCRewardViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCRewardViewController.h"
#import "MCVerificationCodeView.h"
#import "MCUserInfo.h"
@interface MCRewardViewController ()

@end

@implementation MCRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"案例使用2";
    /**
     @property (nonatomic,copy) NSString *avatar;//头像
     @property (nonatomic,copy) NSString *openId;
     @property (nonatomic,copy) NSString *name;//性别
     */
    NSDictionary *dic = @{@"avatar":@"www.baidu.com",@"openId":@"123213123",@"name":@"秦慕乔",@"tags":@[@"帅",@"酷",@"富",@"高",]};
    [MCUserInfo writeUserInfo:dic];
    NSLog(@"getUserDic== %@",[MCUserInfo getUserDic]);
    NSLog(@"%@ %@ %@ %@",[MCUserInfo instance].avatar,[MCUserInfo instance].openId,[MCUserInfo instance].name,[MCUserInfo instance].tags);
    
    [MCUserInfo cleanUpInfo];
    NSLog(@"======================================");
    NSLog(@"getUserDic== %@",[MCUserInfo getUserDic]);
    NSLog(@"%@ %@ %@ %@",[MCUserInfo instance].avatar,[MCUserInfo instance].openId,[MCUserInfo instance].name,[MCUserInfo instance].tags);
    
    NSLog(@"======================================");

    [MCUserInfo writeUserInfo:dic];
    NSLog(@"getUserDic== %@",[MCUserInfo getUserDic]);
    NSLog(@"%@ %@ %@ %@",[MCUserInfo instance].avatar,[MCUserInfo instance].openId,[MCUserInfo instance].name,[MCUserInfo instance].tags);
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
