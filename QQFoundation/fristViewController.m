//
//  fristViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/12.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fristViewController.h"
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
    it2.CellHeight = 190;
    it2.allowSlide = YES;
    it2.slideText = @"喜欢";
    it2.bgColor = [UIColor purpleColor];
    it2.CellSelcetHandler = ^(QQOneItem * item) {
        QQTwoItem *it23 = [[QQTwoItem alloc]init];
        it23.CellHeight = 70;
        it23.allowSlide = YES;
        it23.bgColor = [UIColor purpleColor];
        it23.CellSlideHandler = ^(QQTwoItem * itemT) {
            [itemT deleteRowWithAnimation:UITableViewRowAnimationNone];
        };
        it23.CellSelcetHandler = ^(QQTwoItem * iteme) {
            NSLog(@"%ld",(long)iteme.indexPath.row);
        };
        [it23 insertRow:2 WithAnimation:UITableViewRowAnimationNone];
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
