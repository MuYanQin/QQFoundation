//
//  QQTableViewManager.h
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class QQTableViewItem;
@protocol RETableViewManagerDelegate <UITableViewDelegate>

@end
@interface QQTableViewManager : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *TableView;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredClasses;


/**
 实例化方法  目前仅支持创建一个Section

 @param tableView 被管理的视图
 @return QQTableViewManager
 */
- (id)initWithTableView:(UITableView *)tableView ;


/**
 刷新视图

 @param otherArray 数据源
 */
- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray;


/**
 添加数据

 @param objects 数据源
 */
- (void)addItems:(NSArray *)objects;


/**
 插入一条数据

 @param Item 数据
 @param index 插入的位置
 */
- (void)insertItem:(QQTableViewItem *)Item Index:(NSInteger)index;

/**
 根据Item删除一条数据。推荐使用

 @param item 要删除的数据
 */
- (void)deleteItemWithItem:(QQTableViewItem *)item;


/**
 根据下标删除一个Item 注意：一旦数据源变动下标对应就会变动 一定要保证下标的准确性 推荐使用 deleteItemWithItem：
 如果需要和deleteItemWithItem配合使用的话 一定要放在 deleteItemWithItem前调用
 @param index 下标
 */
- (void)deleteItemWithIndex:(NSInteger )index;


/**
 主动刷新视图
 */
- (void)reloadData;

//MARK:以下方法重写字典方法
- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
@end
