//
//  QQCollectionViewManager.h
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QQCollectionView.h"
NS_ASSUME_NONNULL_BEGIN

@interface QQCollectionViewManager : NSObject<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) QQCollectionView *collectionView;

/**
 实例化方法   不可将QQCollectionViewManager作为局部变量 不然delegate指向nil
 QQCollectionViewManager 作用是帮助viewContorller管理视图 实现代理方法。界面只要关心数据源即可
 collectionView的代理由 QQCollectionViewManager 实现 所以必须将QQCollectionViewManager作为成员变量
 @param collectionView 被管理的视图
 @return QQCollectionViewManager
 */
- (id)initWithCollectionView:(QQCollectionView *)collectionView ;


/// 刷新视图的方法 同 [collectionView reload]
/// @param itemArray QQCollectionViewItem类型的数组
- (void)reloadCollectionViewWithItems:(NSMutableArray *)itemArray;


//MARK:以下方法重写字典方法
- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;


@end

NS_ASSUME_NONNULL_END
