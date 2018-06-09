//
//  threeViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/25.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "threeViewController.h"
#import "fourViewController.h"
#import "MCContent.h"
#import "twoViewController.h"
@interface threeViewController ()
@property (nonatomic , strong) MCContent * Content;
@end

@implementation threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"3333";
    self.navigationItem.title  = @"three";
    self.Content = [[MCContent alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) titles:@[@"frist",@"seconed"] controllers:@[[[twoViewController alloc]init],[[fourViewController alloc]init]]];
    [self.view addSubview:self.Content];
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
