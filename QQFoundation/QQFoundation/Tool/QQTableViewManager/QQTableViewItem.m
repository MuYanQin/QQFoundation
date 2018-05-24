//
//  QQDataSoureceItem.m
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQTableViewItem.h"

@implementation QQTableViewItem
- (instancetype)init
{
    if (self = [super init]) {
        self.CellHeight = 44;
    }
    return self;
}
- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation{
    [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];

}
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation{
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.indexPath.row inSection:self.indexPath.section]] withRowAnimation:animation];
}
@end
