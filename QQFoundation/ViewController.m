//
//  ViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/8/23.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "ViewController.h"
#import "QQScanVC.h"
#import "fristViewController.h"
#import "UIColor+Hexadecimal.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"我的时机";
    self.view.backgroundColor = [UIColor colorWithR:255 G:178 B:32 A:1];

    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[fristViewController new] animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
