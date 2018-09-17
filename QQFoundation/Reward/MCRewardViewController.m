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
#import "QQButton.h"
#import "NSString+Manage.h"
#import "NSMutableAttributedString+Manage.h"
@interface MCRewardViewController ()

@end

@implementation MCRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"案例使用2";
    UILabel * TLabel  = [UILabel getLabel].Qtext(@"秦慕乔").Qframe(CGRectMake(100, 100, 100, 30));
    [self.view addSubview:TLabel];
    
    QQButton *button = [QQButton buttonWithType:UIButtonTypeCustom];
    button.QtitleFont([UIFont systemFontOfSize:14]).QtitleText(@"测试文字位置").Qframe(CGRectMake(100, 200, 200, 50)).Qtarget(self,@selector(clic:)).QtitleClolor([UIColor redColor]).QbackgroudClolor([UIColor lightGrayColor]).Qimage([UIImage imageNamed:@"tab_launch"]).QInfo(@"info").QtextPosition(Tright).QimageSize(CGSizeMake(50, 50));
    [self.view addSubview:button];
    
    UILabel *leb = [UILabel getLabel].Qtext(@"我是个好人").QtextColor([UIColor redColor]).Qclick(self,@"tttt").Qframe(CGRectMake(100, 300, 100, 30));
    [self.view addSubview:leb];
}
- (void)tttt
{
    NSLog(@"===============");
}
- (void)clic:(QQButton *)btn;
{
    NSLog(@"%@",btn.info);
    [btn startCountdown];
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
