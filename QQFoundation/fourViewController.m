//
//  fourViewController.m
//  QQFoundation
//
//  Created by Maybe on 2017/12/21.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fourViewController.h"
#import "threeViewController.h"
#import "YYFPSLabel.h"


@interface fourViewController ()

@end

@implementation fourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"four";
//    self.view.backgroundColor = [UIColor purpleColor];
    YYFPSLabel *yl = [[YYFPSLabel alloc]initWithFrame:CGRectMake(10, 90, 90, 20)];
    yl.backgroundColor = [UIColor redColor];
    [self.view addSubview:yl];
    
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
