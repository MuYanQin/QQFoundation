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
@interface fristViewController ()

@end

@implementation fristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"one";
    UITextField *textfeild = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    textfeild.placeholder = @"请输入手机号";
    [self.view addSubview:textfeild];
    QQButton *btn = [QQButton buttonWithFrame:CGRectMake(0, 64, 100, 100) title:@"123" andBlock:^(UIButton *myButton) {
        if ([QQTool isNumbers:textfeild.text]) {
            NSLog(@"正确");
        }else{
            NSLog(@"错误");
            
        }
        
    }];
    [self.view addSubview:btn];

                     
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
