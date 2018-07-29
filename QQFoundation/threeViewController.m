//
//  threeViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/25.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "threeViewController.h"
#import "fourViewController.h"
#import "MCPageView.h"
#import "twoViewController.h"
#import "fristViewController.h"
@interface threeViewController ()<MCPageViewDelegate>
@property (nonatomic , strong) MCPageView * Content;
@end

@implementation threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title  = @"three";
    self.Content = [[MCPageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) titles:@[@"frist",@"seconed",@"秦慕乔",@"秦慕乔",@"秦慕乔",@"秦慕乔",@"秦慕乔",@"秦慕乔",@"秦慕乔",@"秦慕乔"] controllers:@[[[twoViewController alloc]init],[[fristViewController alloc]init],[[twoViewController alloc]init],[[twoViewController alloc]init],[[twoViewController alloc]init],[[twoViewController alloc]init],[[twoViewController alloc]init],[[twoViewController alloc]init],[[twoViewController alloc]init],[[twoViewController alloc]init]]];
    self.Content.delegate = self;
    self.Content.selectTitleColor = [UIColor blackColor];
    self.Content.defaultTitleFont = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.Content.selectTitleFont = [UIFont systemFontOfSize:16 weight:UIFontWeightHeavy];
    self.Content.titleButtonWidth = 80;
    
    [self.view addSubview:self.Content];
    
}
- (void)MCPageView:(MCPageView *)MCPageView didSelectIndex:(NSInteger)Index
{
    NSLog(@"%ld",(long)Index);
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
