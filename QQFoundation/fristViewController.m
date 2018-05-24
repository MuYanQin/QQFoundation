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
#import "QQTextField.h"
#import "QQAlertController.h"
#import "UIView+QQFrame.h"
#import "QQTableViewManager.h"
#import "QQOneItem.h"
@interface fristViewController ()
@property (strong, nonatomic)QQTableViewManager *manager;
@end

@implementation fristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"one";
    [self.view addSubview:self.BaseQQTableView];
    
    self.manager = [[QQTableViewManager alloc] initWithTableView:self.BaseQQTableView];
    
    self.manager[@"QQOneItem"] = @"QQOneCell";
    QQOneItem *it1 = [[QQOneItem alloc]init];
    it1.CellHeight = 10;
    [self.manager replaceSectionsWithSectionsFromArray:[NSMutableArray arrayWithArray:@[it1]]];
    
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
