//
//  QQTableViewSection.m
//  QQFoundation
//
//  Created by leaduadmin on 2019/4/17.
//  Copyright © 2019 慕纯. All rights reserved.
//

#import "QQTableViewSection.h"
#import "QQTableViewManager.h"
#import "QQTableViewItem.h"
@interface QQTableViewSection ()
@property (nonatomic , strong) NSMutableArray *mutiItems;
@end

@implementation QQTableViewSection
+ (instancetype)section
{
    return [[self alloc] init];
}
- (instancetype)init
{
    if (self = [super init]) {
        self.mutiItems = [NSMutableArray array];
    }
    return self;
}
- (NSMutableArray *)items
{
    return self.mutiItems;
}
- (NSUInteger)index
{
    QQTableViewManager *tableViewManager = self.tableViewManager;
    return [tableViewManager.sections indexOfObject:self];
}
- (void)addItem:(QQTableViewItem *)item
{
    item.section = self;
    [self.mutiItems addObject:item];
}
- (void)addItemWithArray:(NSMutableArray<QQTableViewItem *> *)items
{
    for (QQTableViewItem *item in items) {
        item.section = self;
    }
    [self.mutiItems addObjectsFromArray:items];;
}
- (void)removeItemAtIndex:(NSInteger)index
{
    [self.mutiItems removeObjectAtIndex:index];
}
- (void)insertItem:(QQTableViewItem *)item  atIndex:(NSInteger)index
{
    item.section = self;
    [self.mutiItems insertObject:item atIndex:index];
}
@end
