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
        self.allowSlide = NO;
        self.cellHeight = 0;
    }
    return self;
}
- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation{
    [UIView performWithoutAnimation:^{
        [self.tableViewManager.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
    }];
}
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation{
    NSInteger row = self.indexPath.row;
    [self.section removeItemAtIndex:row];
    
    [UIView performWithoutAnimation:^{
        [self.tableViewManager.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:self.section.index]] withRowAnimation:animation];
    }];
    
}
- (NSIndexPath *)indexPath
{
    return [NSIndexPath indexPathForRow:[self.section.items indexOfObject:self] inSection:self.section.index];
}
@end
