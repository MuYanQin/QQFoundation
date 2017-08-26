//
//  ViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/8/23.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "ViewController.h"
#import "QQScanVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:[QQScanVC new] animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
