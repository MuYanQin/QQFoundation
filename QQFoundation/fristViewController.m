//
//  fristViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/12.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fristViewController.h"
#import "QQButton.h"
#import "fiveViewController.h"
#import "QQTabBarController.h"
#import "QQButton.h"
#import "QQImagePicker.h"
#import "QQTool.h"
#import "QQTextField.h"
@interface fristViewController ()

@end

@implementation fristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"one";

//    QQButton *button = [QQButton buttonWithFrame:CGRectMake(100, 100, 80, 30) title:@"" ClickBlock:^(QQButton *myButton) {
//        NSLog(@"dianji");
//        [self.navigationController pushViewController:[fiveViewController new] animated:YES];
//    }];
//    [button setTitle:@"秦慕乔" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:12];
//    button.backgroundColor = [UIColor purpleColor];
//    [button setImage:[UIImage imageNamed:@"icon_em_al"] forState:UIControlStateNormal];
//    [self.view addSubview:button];

    QQTextField *text = [[QQTextField alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
    text.maxLength = 10;
    text.placeholder = @"123";
    [self.view addSubview:text];
                     
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
