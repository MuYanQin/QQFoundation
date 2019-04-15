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
    }
    return self;
}
- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation{
    [self.tableViewManager.TableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];

}
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation{
    NSInteger row = self.indexPath.row;
    [self.tableViewManager.items removeObjectAtIndex:row];
    [self.tableViewManager.TableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:animation];
}
- (NSIndexPath *)indexPath
{
    return [NSIndexPath indexPathForRow:[self.tableViewManager.items indexOfObject:self] inSection:0];
}
@end
