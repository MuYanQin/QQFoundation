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
#import "UILabel+MCChained.h"
#import "UIButton+MCChained.h"
@interface MCRewardViewController ()

@end

@implementation MCRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"案例使用2";
    UILabel * TLabel  = [UILabel getLabel].Qtext(@"秦慕乔").Qframe(CGRectMake(100, 100, 100, 30));
    [self.view addSubview:TLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.QtitleFont([UIFont systemFontOfSize:14]).QtitleText(@"测试").Qframe(CGRectMake(100, 200, 100, 40)).Qtarget(self,@selector(clic)).QtitleClolor([UIColor redColor]).QbackgroudClolor([UIColor lightGrayColor]);
    [self.view addSubview:button];
}
- (void)clic
{
    NSLog(@"123");
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
