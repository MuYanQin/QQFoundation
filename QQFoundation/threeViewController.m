//
//  threeViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/25.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "threeViewController.h"
#import "fourViewController.h"
@interface threeViewController ()

@end

@implementation threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"3333";
    self.navigationItem.title  = @"three";

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[fourViewController new] animated:YES];
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
