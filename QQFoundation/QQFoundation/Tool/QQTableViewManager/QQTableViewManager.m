//
//  QQTableViewManager.m
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQTableViewManager.h"
#import "QQTableViewItem.h"
#import "QQTableViewCell.h"
@implementation QQTableViewManager
- (id)initWithTableView:(UITableView *)tableView 
{
    if (self = [super init]) {
        self.TableView = tableView;
        self.TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.items = [NSMutableArray array];
        self.registeredClasses = [NSMutableDictionary dictionary];
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    return self;
}
- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [self registerClass:objectClass forCellWithReuseIdentifier:identifier bundle:nil];
}

- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier bundle:(NSBundle *)bundle
{
    NSAssert(NSClassFromString(objectClass), ([NSString stringWithFormat:@"Item class '%@' does not exist.", objectClass]));
    NSAssert(NSClassFromString(identifier), ([NSString stringWithFormat:@"Cell class '%@' does not exist.", identifier]));
    self.registeredClasses[(id <NSCopying>)NSClassFromString(objectClass)] = NSClassFromString(identifier);
    
    // Perform check if a XIB exists with the same name as the cell class
    //
    if (!bundle)
        bundle = [NSBundle mainBundle];
    
    if ([bundle pathForResource:identifier ofType:@"nib"]) {
        [self.TableView registerNib:[UINib nibWithNibName:identifier bundle:bundle] forCellReuseIdentifier:objectClass];
    }
}
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self registerClass:(NSString *)key forCellWithReuseIdentifier:obj];
}
- (id)objectAtKeyedSubscript:(id <NSCopying>)key
{
    return self.registeredClasses[key];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewItem * item = self.items[indexPath.row];
    item.tableViewManager = self;    
    UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"RETableViewManager_%@", [item class]];
    
    Class cellClass = self.registeredClasses[item.class];
    
    QQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:cellStyle reuseIdentifier:cellIdentifier];
    }
    cell.item = item;
    cell.detailTextLabel.text = nil;
    [cell cellDidLoad];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewCell * qCell = (QQTableViewCell *)cell;
    [qCell cellWillAppear];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewItem *item = self.items[indexPath.row];
    return item.CellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id item = self.items[indexPath.row];
    if ([item respondsToSelector:@selector(setCellSelcetHandler:)]) {
        QQTableViewItem *actionItem = (QQTableViewItem *)item;
        if (actionItem.CellSelcetHandler)
            actionItem.CellSelcetHandler(item);
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    QQTableViewItem *item = self.items[indexPath.row];
    return item.allowSlide;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        id item = self.items[indexPath.row];
        QQTableViewItem *actionItem = (QQTableViewItem *)item;
        if (actionItem.CellSlideHandler)
            actionItem.CellSlideHandler(item);
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    id item = self.items[indexPath.row];
    QQTableViewItem *actionItem = (QQTableViewItem *)item;
    return actionItem.slideText ? actionItem.slideText: @"删除";
}
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSMutableArray  *btnArray = [NSMutableArray array];
//
//    // 添加一个删除按钮
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//    }];
//    // 设置背景颜色
//    deleteRowAction.backgroundColor = [UIColor redColor];
//
//    // 添加一个编辑按钮
//    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//    }];
//    // 设置背景颜色
//    editRowAction.backgroundColor = [UIColor redColor];
//
//    // 将按钮们加入数组
//    [btnArray addObject:deleteRowAction];
//    [btnArray addObject:editRowAction];
//
//    return btnArray;
//}
- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray
{
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:otherArray];
    [self.TableView reloadData];
}
- (void)addItems:(NSArray *)objects
{
    [self.items addObjectsFromArray:objects];
    [self.TableView reloadData];
}
- (void)reloadData
{
    [self.TableView reloadData];
}
@end
