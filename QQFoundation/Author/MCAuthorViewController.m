//
//  MCAuthorViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCAuthorViewController.h"
#import "MCSearchCell.h"
#import "MCAuthorSecView.h"
@interface MCAuthorViewController ()

@end

@implementation MCAuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabManager[@"MCSearchItem"] = @"MCSearchCell";
    self.BaseQQTableView.height = self.BaseQQTableView.height - MCTabbarHeight;
    if (self.fromHovering) {
        self.BaseQQTableView.top = 0;
    }else{
        self.BaseQQTableView.height = self.BaseQQTableView.height - MCTabbarHeight;
    }
    
    for (int j = 0; j<5; j++) {
        QQTableViewSection *section = [QQTableViewSection section];
        MCAuthorSecItem *secItem = [[MCAuthorSecItem alloc]init];
        secItem.text = [NSString stringWithFormat:@"这是第%d个SecView",j];
        section.secItem = secItem;
        section.sectionHeight = 50;
        for (int i = 0; i<=10; i++) {
            MCSearchItem *item = [[MCSearchItem alloc]init];
            item.text = [NSString stringWithFormat:@"Author=%d",i];
            item.selcetCellHandler = ^(MCSearchItem * item) {
                NSLog(@"%@",item.indexPath);
            };
            item.allowSlide = YES;
            item.slideTextArray = @[@"删除"];
            [section addItem:item];
        }
        [self.BaseMutableArray addObject:section];
    }
    [self.tabManager replaceWithSectionsFromArray:self.BaseMutableArray];
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
