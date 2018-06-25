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
@interface fristViewController ()
@end

@implementation fristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"one";
    
    self.tabManager[@"QQOneItem"] = @"QQOneCell";
    self.tabManager[@"QQTwoItem"] = @"QQTwoCell";
    
    QQOneItem *it1 = [[QQOneItem alloc]init];
    it1.CellHeight = 50;
    it1.allowSlide = YES;
    it1.slideText = @"收藏";
    it1.selcetCellHandler = ^(QQOneItem * item) {
    };
    it1.slideCellHandler  = ^(id item) {
    };
    
    QQTwoItem *it2 = [[QQTwoItem alloc]init];
    it2.CellHeight = 190;
    it2.allowSlide = YES;
    it2.slideText = @"喜欢";
    it2.bgColor = [UIColor purpleColor];
    it2.selcetCellHandler = ^(QQOneItem * item) {

    };
    it2.slideCellHandler = ^(id item) {
        
    };
    [self.tabManager replaceSectionsWithSectionsFromArray:[NSMutableArray arrayWithArray:@[it1,it2]]];
    
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
