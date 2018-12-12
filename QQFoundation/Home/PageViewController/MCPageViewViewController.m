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
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *controllers = [NSMutableArray array];
    
//    for (int i = 0; i<8; i++) {
//        if (i%2 == 0) {
//            [controllers addObject:[MCPageViewSub1ViewController new]];
//        }else{
//            [controllers addObject:[MCPageViewSub2ViewController new]];
//        }
//    }
    [controllers addObject:[MCPageViewSub1ViewController new]];
    [titles addObject:[NSString stringWithFormat:@"title_%d",1]];

    [controllers addObject:[MCPageViewSub2ViewController new]];
    [titles addObject:[NSString stringWithFormat:@"title_%d",2]];
    [controllers addObject:[MCPageViewSub3ViewController new]];
    [titles addObject:[NSString stringWithFormat:@"title_%d",3]];

    
    self.PageView = [[MCPageView alloc]initWithFrame:CGRectMake(0, MCNavHeight, KScreenWidth, KScreenHeight - MCNavHeight - MCBottomDistance) titles:titles controllers:controllers];
    self.PageView.titleButtonWidth = 60;
    self.PageView.lineWitdhScale = 0.2;
    self.PageView.selectTitleFont = [UIFont systemFontOfSize:18];
    self.PageView.selectTitleColor = [UIColor purpleColor];
    [self.PageView setBadgeWithIndex:3 badge:0];
    [self.PageView setBadgeWithIndex:4 badge:58];
    [self.PageView setBadgeWithIndex:5 badge:-1];
    [self.PageView setBadgeWithIndex:6 badge:1000];
    [self.view addSubview:self.PageView];
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
