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
//MARK:重写字典的写入方法
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self registerClass:(NSString *)key forCellWithReuseIdentifier:obj];
}
- (id)objectAtKeyedSubscript:(id <NSCopying>)key
{
    return self.registeredClasses[key];
}
#pragma mark - UITableViewDelegate
/**返回几个section*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/**每个section返回几个cell*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}
/**注册cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewItem * item = self.items[indexPath.row];
    item.tableViewManager = self;    
    UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"QQTableViewManager_%@", [item class]];
    Class cellClass = self.registeredClasses[item.class];
    
    QQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:cellStyle reuseIdentifier:cellIdentifier];
        [cell cellDidLoad];
    }
    cell.item = item;
    cell.detailTextLabel.text = nil;
    return cell;
}
/**cell将要显示*/
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewCell * qCell = (QQTableViewCell *)cell;
    [qCell cellWillAppear];
}
/**cell显示完成-》cell隐藏*/
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewCell * qCell = (QQTableViewCell *)cell;
    [qCell cellDidDisappear];
}
/**返回cell的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewItem *item = self.items[indexPath.row];
    return item.CellHeight;
}
/**cell点击事件*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id item = self.items[indexPath.row];
    if ([item respondsToSelector:@selector(selcetCellHandler)]) {
        QQTableViewItem *actionItem = (QQTableViewItem *)item;
        if (actionItem.selcetCellHandler)
            actionItem.selcetCellHandler(item);
    }
}
/**返回是否可以编辑*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    QQTableViewItem *item = self.items[indexPath.row];
    return item.allowSlide;
}
/**UITableViewRowAction的点击事件*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        id item = self.items[indexPath.row];
        QQTableViewItem *actionItem = (QQTableViewItem *)item;
        if (actionItem.slideCellHandler)
            actionItem.slideCellHandler(item);
    }
}
/**默认的单个按钮 返回文字*/
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    id item = self.items[indexPath.row];
    QQTableViewItem *actionItem = (QQTableViewItem *)item;
    return actionItem.slideText ? actionItem.slideText: @"删除";
}
/**配合MCHovering的滑动处理*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.TableView.scrollViewDidScroll) {
        self.TableView.scrollViewDidScroll(scrollView);
    }
    
}
/**自定义返回文字、背景色*/
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
   __block NSMutableArray  *btnArray = [NSMutableArray array];

    QQTableViewItem *item = (QQTableViewItem *)self.items[indexPath.row];

    if (item.slideTextArray && item.slideTextArray.count >0) {
        [item.slideTextArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 添加一个按钮
            UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:obj handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            }];
            // 设置背景颜色
            action.backgroundColor = item.slideColorArray[idx];
            [btnArray addObject:action];
        }];
    }
    return btnArray;
}
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
- (void)insertItem:(QQTableViewItem *)Item Index:(NSInteger)index
{
    [self.items insertObject:Item atIndex:index];
    [self.TableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)deleteItemWithItem:(QQTableViewItem *)item
{
    NSInteger index = [self.items indexOfObject:item];
    [self.items removeObject:item];
    NSIndexPath *toDelete = [NSIndexPath indexPathForRow:index inSection:0];
    [self.TableView deleteRowsAtIndexPaths:@[toDelete] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)deleteItemWithIndex:(NSInteger )index
{
    [self.items removeObjectAtIndex:index];
    NSIndexPath *toDelete = [NSIndexPath indexPathForRow:index inSection:0];
    [self.TableView deleteRowsAtIndexPaths:@[toDelete] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)reloadData
{
    [self.TableView reloadData];
}
@end
