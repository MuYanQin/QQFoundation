//
//  fristViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/12.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fristViewController.h"
#import "QQOneItem.h"
#import "QQTwoItem.h"
#import "fiveViewController.h"
#import "MCPushMediator.h"
#import "MCAlertView.h"
#import "UIView+MCPopView.h"
@interface fristViewController ()
@end

@implementation fristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"one";
    self.view.backgroundColor = [UIColor purpleColor];
    self.tabManager[@"QQOneItem"] = @"QQOneCell";
    self.tabManager[@"QQTwoItem"] = @"QQTwoCell";
//    self.BaseQQTableView.isHasHeaderRefresh = NO;//设置是否有刷新
    [self.BaseQQTableView setUpWithUrl:@"" Parameters:@{} formController:self];
    
    NSMutableArray *itemArray  = [NSMutableArray array];
    QQOneItem *it1 = [[QQOneItem alloc]init];
    it1.allowSlide = YES;
    it1.leftString = @"首页1";
    it1.bgColor = [UIColor yellowColor];
    it1.slideText = @"收藏";
    it1.imageString = @"home_01";
    it1.selcetCellHandler = ^(QQOneItem * item) {
        [MCPushMediator pushToClassFromStaring:@"fiveViewController" takeParameters:@{@"userId":@"12345678"} callBack:^(id data) {
            NSLog(@"%@",data);
        }];
    };
//    it1.slideCellHandler  = ^(id item) {
//        NSLog(@"it1 侧滑被点击了！！");
//    };
    [itemArray addObject:it1];
    
    QQOneItem *it2 = [[QQOneItem alloc]init];
    it2.allowSlide = YES;
    it2.bgColor = [UIColor redColor];
    it2.leftString = @"首页2";
    it2.slideText = @"删除";
    it2.imageString = @"home_02";
    it2.selcetCellHandler = ^(QQOneItem * item) {
        MCAlertView *alertview = [[MCAlertView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
        alertview.backgroundColor = [UIColor whiteColor];
        [UIView showView:alertview showType:viewShowTypeFadeIn dissType:viewDissTypeFadeOut positionType:viewPositionTypeCenter dismissOnBackgroundTouch:YES];
    };
//    it2.slideCellHandler  = ^(id item) {
//
//    };
    [itemArray addObject:it2];
    
    QQOneItem *it3 = [[QQOneItem alloc]init];
    it3.allowSlide = YES;
    it3.bgColor = [UIColor purpleColor];
    it3.leftString = @"首页3";
    it3.slideText = @"喜欢";
    it3.imageString = @"home_03";
    it3.selcetCellHandler = ^(QQOneItem * item) {
    };
    it3.slideCellHandler  = ^(id item) {
    };
    [itemArray addObject:it3];
    
    QQTwoItem *it4 = [[QQTwoItem alloc]init];
    it4.leftSting = @"主标题";
    it4.CellHeight = 100;
    it4.rightSting = @"副标题";
    it4.selcetCellHandler = ^(QQOneItem * item) {
    };
    [itemArray addObject:it4];

    for (int i = 0 ; i<10; i++) {
        QQOneItem *ewq = [[QQOneItem alloc]init];
        ewq.allowSlide = YES;
        ewq.leftString = @"首页1";
        ewq.bgColor = [UIColor yellowColor];
        ewq.slideText = @"收藏";
        ewq.imageString = @"home_01";
        ewq.selcetCellHandler = ^(QQOneItem * item) {
            NSLog(@"%d",item.indexPath);
        };
        ewq.slideCellHandler  = ^(id item) {
            NSLog(@"it1 侧滑被点击了！！");
        };
        [itemArray addObject:ewq];
    }
    
    [self.tabManager replaceSectionsWithSectionsFromArray:itemArray];
    
}
- (void)QQtableView:(QQtableView *)QQtableView isPullDown:(BOOL)PullDown SuccessDataArray:(NSArray *)DataArray
{
    if (PullDown) {
//    array    removeALl
//        array add
    }else{
//  add
    }
}
- (void)QQtableView:(QQtableView *)QQtableView requestFailed:(NSError *)error
{
    
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
