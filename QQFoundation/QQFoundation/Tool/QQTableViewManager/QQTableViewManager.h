//
//  QQTableViewManager.h
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RETableViewManagerDelegate <UITableViewDelegate>

@end
@interface QQTableViewManager : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *TableView;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredClasses;


/**
 实例化方法

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

//MARK:以下方法重写字典方法
- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
@end
