//
//  QQCollectionViewManager.h
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQCollectionViewManager : NSObject<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView *collectionView;

/**
 实例化方法 需要将 QQCollectionViewManager设置为全局变量 不然delegetez  = nil

 @param collectionView 被管理的视图
 @return QQCollectionViewManager
 */
- (id)initWithCollectionView:(UICollectionView *)collectionView ;


- (void)reloadCollectionViewWithItems:(NSMutableArray *)itemArray;


//MARK:以下方法重写字典方法
- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;


@end

NS_ASSUME_NONNULL_END
