//
//  QQDataSoureceItem.m
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQTableViewItem.h"
#import "QQTableViewManager.h"
@implementation QQTableViewItem
- (instancetype)init
{
    if (self = [super init]) {
        self.CellHeight = 44;
        self.allowSlide = NO;
    }
    return self;
}
- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation{
    [self.tableViewManager.TableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];

}
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation{
    [self.tableViewManager.items removeObjectAtIndex:self.indexPath.row];
    [self.tableViewManager.TableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
}
@end
