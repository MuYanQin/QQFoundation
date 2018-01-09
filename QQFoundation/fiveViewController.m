//
//  fiveViewController.m
//  QQFoundation
//
//  Created by Maybe on 2017/12/22.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fiveViewController.h"
#import "UIColor+Hexadecimal.h"
@interface fiveViewController ()

@end

@implementation fiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Five";
}
- (void)viewWillDisappear:(BOOL)animated
{
   self.navigationController.navigationBar.barTintColor = [UIColor colorWithR:0 G:122 B:255 A:1];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
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
