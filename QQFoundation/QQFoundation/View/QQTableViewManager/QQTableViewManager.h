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

@protocol QQTableViewManagerDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end

@class QQTableViewItem,QQTableViewSection;

@interface QQTableViewManager : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) QQtableView *tableView;

@property (nonatomic , assign) id<QQTableViewManagerDelegate>  delegate;
@property (nonatomic , assign) BOOL  allowEditing;
@property (strong, readonly ,nonatomic) NSMutableArray *allItems;
@property (nonatomic , strong) NSMutableArray *sections;
@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredClasses;


/**
实例化方法   不可将QQTableViewManager作为局部变量 不然delegate指向nil
QQTableViewManager 作用是帮助viewContorller管理视图 实现代理方法。界面只要关心数据源即可
UITableView的代理由 QQTableViewManager 实现 所以必须将QQTableViewManager作为成员变量
@param tableView 被管理的视图
@return QQTableViewManager
*/
- (instancetype)initWithTableView:(UITableView *)tableView ;


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
