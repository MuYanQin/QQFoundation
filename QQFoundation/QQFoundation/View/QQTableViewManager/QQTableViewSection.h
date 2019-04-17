//
//  QQTableViewSection.h
//  QQFoundation
//
//  Created by leaduadmin on 2019/4/17.
//  Copyright © 2019 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class QQTableViewManager;
@class QQTableViewItem;
@interface QQTableViewSection : NSObject
/**
 The table view manager of this section.
 */
@property (weak, readwrite, nonatomic) QQTableViewManager *tableViewManager;
/**
 Section index in UITableView.
 */
@property (assign, readonly, nonatomic) NSUInteger index;

/**
 An array of section items (rows).
 */
@property (strong, readonly, nonatomic) NSMutableArray *items;

@property (nonatomic , assign) CGFloat  sectionHeight;
@property (nonatomic , copy) NSString * sectionTitle;
@property (nonatomic , copy) NSString * indexTitle;

@property (nonatomic , strong) UIView *sectionView;


/**
 实例化

 @return 对象
 */
+ (instancetype)section;
/**
 添加item

 @param item item
 */
- (void)addItem:(QQTableViewItem *)item;

/**
 添加item数组

 @param items 数组
 */
- (void)addItemWithArray:(NSMutableArray<QQTableViewItem *> *)items;
/**
 按下标删除

 @param index 下标
 */
- (void)removeItemAtIndex:(NSInteger)index;

/**
 插入在某个下标
 
 @param index 下标
 */
- (void)insertItem:(QQTableViewItem *)item  atIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
