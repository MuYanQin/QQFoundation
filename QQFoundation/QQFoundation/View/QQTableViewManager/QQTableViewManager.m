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
#import "QQTableViewSecView.h"  
@implementation QQTableViewManager
- (id)initWithTableView:(UITableView *)tableView 
{
    if (self = [super init]) {
        self.tableView = tableView;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sections = [NSMutableArray array];
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
        [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:bundle] forCellReuseIdentifier:objectClass];
    }
}
//MARK:重写字典的写入方法  自定义下标
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self registerClass:(NSString *)key forCellWithReuseIdentifier:obj];
}
- (id)objectAtKeyedSubscript:(id <NSCopying>)key
{
    return self.registeredClasses[key];
}

- (NSMutableArray *)allItems
{
    __block NSMutableArray *itemArray = [NSMutableArray array];
    [self.sections enumerateObjectsUsingBlock:^(NSArray * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [itemArray addObjectsFromArray:obj];
    }];
    return itemArray;
}
- (void)setAllowEditing:(BOOL)allowEditing
{
    _allowEditing = allowEditing;
    self.tableView.editing = allowEditing;
}
#pragma mark - UITableViewDelegate
/**返回几个section*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}
/**每个section返回几个cell*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (self.sections.count>0) {
        QQTableViewSection *tsection = self.sections[section];
        count = [tsection.items count];
    }
    return count;
}
/**注册cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewSection *section = self.sections[indexPath.section];
    QQTableViewItem * item = section.items[indexPath.row];
    item.tableViewManager = self;    
    UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@", [item class]];
    Class cellClass = self.registeredClasses[item.class];
    
    QQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:cellStyle reuseIdentifier:cellIdentifier];
        [cell cellDidLoad];
    }
    cell.item = item;
    cell.detailTextLabel.text = nil;
    [cell cellWillAppear];
    if (item.cellHeight <=0) {
        item.cellHeight = [cell autoCellHeight];
    }
    return cell;
}
/**cell将要显示*/
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}
/**cell显示完成->cell隐藏*/
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewCell * qCell = (QQTableViewCell *)cell;
    [qCell cellDidDisappear];
}
/**返回cell的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QQTableViewSection *section = self.sections[indexPath.section];
    QQTableViewItem * item = section.items[indexPath.row];
    return (item.cellHeight>0)?item.cellHeight:44;
}
/**cell点击事件*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QQTableViewSection *section = self.sections[indexPath.section];
    QQTableViewItem * item = section.items[indexPath.row];
    if ([item respondsToSelector:@selector(selcetCellHandler)]) {
        QQTableViewItem *actionItem = (QQTableViewItem *)item;
        if (actionItem.selcetCellHandler)
            actionItem.selcetCellHandler(item);
    }
}
/**配合MCHovering的滑动处理*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.scrollViewDidScroll) {
        self.tableView.scrollViewDidScroll(scrollView);
    }
}

/**返回是否可以编辑*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    QQTableViewSection *section = self.sections[indexPath.section];
    QQTableViewItem * item = section.items[indexPath.row];
    return item.allowSlide;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
/**使用editActionsForRowAtIndexPath自定义后。下面的方法就失效了*/
///**UITableViewRowAction的点击事件 ios系统d8.1 8.2 版本不实现此方法 不能侧滑*/
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

///**默认的单个按钮 返回文字*/
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    id item = self.items[indexPath.row];
//    QQTableViewItem *actionItem = (QQTableViewItem *)item;
//    return actionItem.slideText ? actionItem.slideText: @"删除";
//}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
API_AVAILABLE(ios(11.0)){
    QQTableViewSection *section = self.sections[indexPath.section];
    QQTableViewItem * item = section.items[indexPath.row];
    return  [self configAction:item.trailingTArray colorArray:item.trailingCArray item:item trailing:YES];
}
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)){
    QQTableViewSection *section = self.sections[indexPath.section];
    QQTableViewItem * item = section.items[indexPath.row];
    return  [self configAction:item.leadingTArray colorArray:item.leadingCArray item:item trailing:NO];
}
- (UISwipeActionsConfiguration *)configAction:(NSArray *)textArray colorArray:(NSArray *)colorArray item:(QQTableViewItem *)item trailing:(BOOL)trailing
API_AVAILABLE(ios(11.0)){
    __block NSMutableArray *actions = [NSMutableArray array];
    [textArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIContextualAction *act = [UIContextualAction contextualActionWithStyle:(UIContextualActionStyleNormal) title:obj handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            if (trailing) {
                if (item.trailingSwipeHandler) {
                    item.trailingSwipeHandler(item, idx);
                }
            }else{
                if (item.leadingSwipeHandler) {
                    item.leadingSwipeHandler(item, idx);
                }
            }
            completionHandler(YES);
        }];
        if (colorArray.count > idx) {
            act.backgroundColor = colorArray[idx];
        }else{
            act.backgroundColor = [UIColor redColor];
        }
        [actions addObject:act];
    }];

    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:actions];
    return config;
}

/**自定义侧滑按钮个数 不久之后将会被代替 iOS11 出来了新的API*/
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block NSMutableArray  *btnArray = [NSMutableArray array];
    QQTableViewSection *section = self.sections[indexPath.section];
    QQTableViewItem * item = section.items[indexPath.row];
    if (item.trailingTArray && item.trailingCArray.count >0) {
        [item.trailingTArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 添加一个按钮
            UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:obj handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                if (item.trailingSwipeHandler)
                    item.trailingSwipeHandler(item,[item.trailingTArray indexOfObject:action.title]);
            }];
            // 设置背景颜色
            action.backgroundColor = item.trailingCArray[idx]?item.trailingCArray[idx]:[UIColor redColor];
            [btnArray addObject:action];
        }];
    }
    return btnArray;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.sections.count <= section) {
        return 0;
    }
    QQTableViewSection *sec  = self.sections[section];

    if (sec.secItem.secHeight >0) {
        return sec.secItem.secHeight;
    }
    if (sec.sectionHeight >0) {
        return sec.sectionHeight;
    }

    if (sec.sectionTitle.length>0) {
        return 30;
    }
    return 0;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QQTableViewSection *sec = self.sections[section];

    if (!sec.secItem) {
        return nil;
    }
    NSString *identifier = NSStringFromClass(sec.secItem.class);
    NSString *secViewS = [NSString stringWithFormat:@"%@%@",[identifier substringToIndex:identifier.length - 4],@"View"];
    Class cellClass = NSClassFromString(secViewS);
    QQTableViewSecView *secView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(cellClass)];
    if (!secView) {
        secView = [[cellClass alloc]initWithReuseIdentifier:NSStringFromClass(cellClass)];
        [secView secViewDidLoad];
    }
    secView.secItem = sec.secItem;
    return secView;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view isKindOfClass:[QQTableViewSecView class]]) {
        QQTableViewSecView *secView = (QQTableViewSecView *) view;
        [secView secViewWillAppear];
    }
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view isKindOfClass:[QQTableViewSecView class]]) {
        QQTableViewSecView *secView = (QQTableViewSecView *) view;
        [secView secViewDidDisappear];
    }
    
}

#pragma mark---tableView索引相关设置----
//添加TableView头视图标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.sections.count <= section) {
        return nil;
    }
    QQTableViewSection *sec = self.sections[section];
    return sec.sectionTitle;
}

//添加索引栏标题数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *titles = [NSMutableArray array];
    for (QQTableViewSection *section in self.sections) {
        if (section.indexTitle) {
            [titles addObject:section.indexTitle ];
        }
    }
    return titles;
}
// tableView 移动排序的代理方法
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    QQTableViewSection *section = self.sections[indexPath.section];
    QQTableViewItem * item = section.items[indexPath.row];
    return item.canMove;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if ([self.delegate respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.delegate tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

//点击索引栏标题时执行
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
//    if ([title isEqualToString:UITableViewIndexSearch])
//    {
//        [tableView setContentOffset:CGPointZero animated:NO];//tabview移至顶部
//        return NSNotFound;
//    }
//    else
//    {
//        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] - 1; // -1 添加了搜索标识
//    }
//}
- (void)replaceWithSectionsFromArray:(NSMutableArray*)sectionArray
{
    [self.sections removeAllObjects];
    for (QQTableViewSection *section in sectionArray)
        section.tableViewManager = self;
    [self.sections addObjectsFromArray:sectionArray];
    [self.tableView reloadData];
}
- (void)replaceSectionsWithSectionsFromArray:(NSMutableArray *)itemArray
{
    [self.sections removeAllObjects];
    
    QQTableViewSection *section  = [QQTableViewSection section];
    section.tableViewManager = self;
    for (QQTableViewItem *item in itemArray) {
        item.section = section;
        [section addItem:item];
    }
    [self.sections addObject:section];
    [self.tableView reloadData];
}
- (void)replaceSectionWithSection:(QQTableViewSection *)section
{
    section.tableViewManager = self;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section.index] withRowAnimation:(UITableViewRowAnimationNone)];
    if (section.items.count>0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section.index] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
    }
}
- (void)addSection:(NSMutableArray<QQTableViewSection *> *)sections;
{
    for (QQTableViewSection *section in sections)
        section.tableViewManager = self;
    [self.sections addObjectsFromArray:sections];
}

- (void)insertSection:(QQTableViewSection *)section index:(NSInteger)index;
{
    section.tableViewManager = self;
    [self.sections insertObject:section atIndex:index];
}
- (void)reloadData
{
    [self.tableView reloadData];
}
@end
