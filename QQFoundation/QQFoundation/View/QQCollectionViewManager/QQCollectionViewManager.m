//
//  QQCollectionViewManager.m
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "QQCollectionViewManager.h"
#import "QQCollectionViewItem.h"
#import "QQCollectionViewCell.h"
@interface QQCollectionViewManager ()
@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredClasses;
@property (nonatomic , strong) NSMutableArray *dataArray;
@end

@implementation QQCollectionViewManager

- (id)initWithCollectionView:(QQCollectionView *)collectionView
{
    if (self = [super init]) {
        self.collectionView = collectionView;
        self.dataArray = [NSMutableArray array];
        collectionView.dataSource = self;
        collectionView.delegate  = self;
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
    
    [self.collectionView registerClass:NSClassFromString(identifier) forCellWithReuseIdentifier:objectClass];

    if (!bundle)
        bundle = [NSBundle mainBundle];
    
    if ([bundle pathForResource:identifier ofType:@"nib"]) {
        [self.collectionView registerNib:[UINib nibWithNibName:identifier bundle:bundle] forCellWithReuseIdentifier:objectClass];
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
- (void)reloadCollectionViewWithItems:(NSMutableArray *)itemArray{
    [self.dataArray addObjectsFromArray:itemArray];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView reloadData];
    } completion:nil];
    
    
}
/**配合MCHovering的滑动处理*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.collectionView.scrollViewDidScroll) {
        self.collectionView.scrollViewDidScroll(scrollView);
    }
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QQCollectionViewItem *item = self.dataArray[indexPath.row];
    QQCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([item class]) forIndexPath:indexPath];
    cell.item = item;
    [cell cellWillAppear];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    QQCollectionViewItem *item = self.dataArray[indexPath.row];
    if (item.selcetCellHandler) {
        item.selcetCellHandler(item);
    }
}
@end
