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
#import "QQTwoItem.h"
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
    self.manager[@"QQTwoItem"] = @"QQTwoCell";

    QQOneItem *it1 = [[QQOneItem alloc]init];
    it1.CellHeight = 50;
    it1.allowSlide = YES;
    it1.slideText = @"收藏";
    
    it1.CellSelcetHandler = ^(QQOneItem * item) {
    };
    it1.CellSlideHandler = ^(id item) {

    };
    
    QQTwoItem *it2 = [[QQTwoItem alloc]init];
    it2.CellHeight = 70;
    it2.allowSlide = YES;
    it2.slideText = @"喜欢";
    it2.bgColor = [UIColor purpleColor];
    it2.CellSelcetHandler = ^(QQOneItem * item) {
        QQTwoItem *it2 = [[QQTwoItem alloc]init];
        it2.CellHeight = 70;
        it2.allowSlide = YES;
        it2.slideText = @"喜欢";
        it2.bgColor = [UIColor purpleColor];
        [self.manager addItems:@[it2]];
    };
    it2.CellSlideHandler = ^(id item) {
        

    };
    [self.manager replaceSectionsWithSectionsFromArray:[NSMutableArray arrayWithArray:@[it1,it2]]];
    
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
