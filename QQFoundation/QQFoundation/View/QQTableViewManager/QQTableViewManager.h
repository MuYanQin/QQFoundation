//
//  QQTableViewManager.h
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QQtableView.h"
#define Deprecated(instead) NS_DEPRECATED_IOS(2_0, 9_0, instead)

@class QQTableViewItem,QQTableViewSection;

@interface QQTableViewManager : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) QQtableView *tableView;

@property (strong, readonly ,nonatomic) NSMutableArray *allItems;
@property (nonatomic , strong) NSMutableArray *sections;
@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredClasses;


/**
 实例化方法  目前仅支持创建一个Section

 @param tableView 被管理的视图
 @return QQTableViewManager
 */
- (id)initWithTableView:(UITableView *)tableView ;


/**
 刷新视图

 @param sectionArray 数据源
 */
- (void)replaceWithSectionsFromArray:(NSMutableArray*)sectionArray;


- (void)replaceSectionsWithSectionsFromArray:(NSMutableArray *)itemArray Deprecated("兼容旧框架的方法 推荐使用`replaceWithSectionsFromArray` 使用更灵活");


/**
 刷新某个section

 @param section section
 */
- (void)replaceSectionWithSection:(QQTableViewSection *)section;
/**
 添加数据

 @param sections 数据源
 */
- (void)addSection:(NSMutableArray<QQTableViewSection *> *)sections;


/**
 插入一条数据

 @param section 数据
 @param index 插入的位置
 */
- (void)insertSection:(QQTableViewSection *)section index:(NSInteger)index;

/**
 主动刷新视图
 */
- (void)reloadData;

//MARK:以下方法重写字典方法
- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
@end
