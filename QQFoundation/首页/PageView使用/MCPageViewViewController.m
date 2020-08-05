//
//  MCPageViewViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/9/19.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPageViewViewController.h"
#import "MCPageView.h"
#import "MCPageViewSub1ViewController.h"
#import "MCPageViewSub2ViewController.h"
#import "MCPageViewSub3ViewController.h"

@interface MCPageViewViewController ()
@property (nonatomic , strong) MCPageView * PageView;
@end

@implementation MCPageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self nav_RightItemWithStr:@"角标" Selector:@selector(badgeClick)];
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *controllers = [NSMutableArray array];
    [controllers addObject:[MCPageViewSub1ViewController new]];
    [titles addObject:@"社会"];

    [controllers addObject:[MCPageViewSub2ViewController new]];
    [titles addObject:@"军事"];
    [controllers addObject:[MCPageViewSub3ViewController new]];
    [titles addObject:@"娱乐"];

    
    self.PageView = [[MCPageView alloc]initWithFrame:CGRectMake(0, MCNavHeight, KScreenWidth, KScreenHeight - MCNavHeight - MCBottomDistance) titles:titles controllers:controllers];
    //默认评分屏幕
    self.PageView.titleButtonWidth = 60;
    self.PageView.lineHeight = 5;
    self.PageView.lineWitdhScale = 0.3;

    self.PageView.lineColor = [UIColor purpleColor];
    self.PageView.selectTitleFont = [UIFont systemFontOfSize:16];
    self.PageView.defaultTitleFont = [UIFont systemFontOfSize:16];
    self.PageView.defaultTitleColor = [UIColor redColor];
    self.PageView.selectTitleColor = [UIColor purpleColor];
    [self.PageView selectIndex:1];
    [self.view addSubview:self.PageView];
}
- (void)badgeClick
{
    [self.PageView setBadgeWithIndex:3 badge:0];
    [self.PageView setBadgeWithIndex:0 badge:0];
    [self.PageView setBadgeWithIndex:1 badge:58];
    [self.PageView setBadgeWithIndex:5 badge:-1];
    [self.PageView setBadgeWithIndex:2 badge:1000];
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
