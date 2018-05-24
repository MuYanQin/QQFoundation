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
    item.tableView = self.TableView;
    UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"RETableViewManager_%@", [item class]];
    
    Class cellClass = self.registeredClasses[item.class];
    
    QQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:cellStyle reuseIdentifier:cellIdentifier];
    }
//    cell.rowIndex = indexPath.row;
//    cell.sectionIndex = indexPath.section;
//    cell.parentTableView = tableView;
//    cell.section = section;
    cell.item = item;
    cell.detailTextLabel.text = nil;
    return cell;
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
- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray
{
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:otherArray];
    [self.TableView reloadData];
}
@end
