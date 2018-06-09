//
//  MCContent.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/9.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCContent.h"
#import "UIView+QQFrame.h"
#import "QQButton.h"
#define kwidth          [UIScreen mainScreen].bounds.size.width
#define kheight        [UIScreen mainScreen].bounds.size.height
@interface MCContent ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic , strong) UIScrollView * titleScroll;
@property (nonatomic , strong) UICollectionView * contentCollection;
@property (nonatomic , strong) NSMutableArray * itemArray;
@property (nonatomic , strong) QQButton * lastItem;
@end

static const CGFloat titleScrollHeight = 60;
static const NSInteger itemTag = 100;

@implementation MCContent
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles controllers:(NSArray *)controllers
{
    if (self = [super initWithFrame:frame]) {
        self.contentTitles = [NSArray arrayWithArray:titles];
        _contentCtrollers = [NSArray arrayWithArray:controllers];
        self.itemArray = [NSMutableArray array];
        [self addSubview:self.titleScroll];
        [self addSubview:self.contentCollection];
    }
    return self;

}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contentCtrollers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCContent" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    UIViewController *childVC = self.contentCtrollers[indexPath.item];
    childVC.view.frame = cell.contentView.bounds;
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (![cell.contentView.subviews containsObject:childVC.view]) {
        [cell.contentView addSubview:childVC.view];
    }
    return cell;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.contentCollection) {
        NSInteger index = scrollView.contentOffset.x/kwidth;
        [self changeItemStatus:index];
    }
}

- (void)selectItem:(QQButton *)btn
{
    [self selectIndex:btn.tag - itemTag];
}
- (void)selectIndex:(NSInteger)index
{
    if (index <0 || index >self.contentTitles.count) {
        NSLog(@"滚动的位置大于条目数");
        return;
    }
    [self.contentCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:labs(index) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//    [self changeItemStatus:index];
    QQButton * Item = self.itemArray[index];
    if (self.lastItem) {
        self.lastItem.titleLabel.font = self.defaultTitleFont ?self.defaultTitleFont:[UIFont systemFontOfSize:14];
        [self.lastItem setTitleColor:self.defaultTitleColor ?self.defaultTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    }
    self.lastItem = Item;
    Item.titleLabel.font = self.selectTitleFont ?self.selectTitleFont:[UIFont systemFontOfSize:14];
    [Item setTitleColor:self.selectTitleColor ?self.selectTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (void)changeItemStatus:(NSInteger)index
{
    QQButton * Item = self.itemArray[index];
    if (self.lastItem) {
        self.lastItem.titleLabel.font = self.defaultTitleFont ?self.defaultTitleFont:[UIFont systemFontOfSize:14];
        [self.lastItem setTitleColor:self.defaultTitleColor ?self.defaultTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    }
    self.lastItem = Item;
    Item.titleLabel.font = self.selectTitleFont ?self.selectTitleFont:[UIFont systemFontOfSize:14];
    [Item setTitleColor:self.selectTitleColor ?self.selectTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}
- (NSArray *)contentTitles
{
    if (!_contentTitles) {
        _contentTitles = [NSArray array];
    }
    return  _contentTitles;
}
- (UICollectionView *)contentCollection
{
    if (!_contentCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(kwidth, self.height -self.titleScroll.bottom);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _contentCollection= [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.titleScroll.bottom, kwidth, self.height - self.titleScroll.bottom) collectionViewLayout:flowLayout];
        _contentCollection.showsHorizontalScrollIndicator = NO;
        _contentCollection.backgroundColor = [UIColor yellowColor];
        _contentCollection.pagingEnabled = YES;
        _contentCollection.bounces = NO;
        _contentCollection.delegate = self;
        _contentCollection.dataSource = self;
        [_contentCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MCContent"];
    }
    return _contentCollection;
}
- (UIScrollView *)titleScroll
{
    if (!_titleScroll) {
        _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kwidth, titleScrollHeight)];
        _titleScroll.delegate = self;
        
        if ((self.titleButtonWidth *_contentTitles.count) >kwidth) {
            self.titleScroll.contentSize = CGSizeMake((self.titleButtonWidth *_contentTitles.count), titleScrollHeight);
        }else{
            self.titleScroll.contentSize = CGSizeMake(kwidth, titleScrollHeight);
        }
        CGFloat btnWidth = kwidth/_contentTitles.count;
        if (self.titleButtonWidth >0) {
            btnWidth = self.titleButtonWidth;
        }
        __weak __typeof(&*self)weakSelf = self;
        [_contentTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool{
                QQButton *item = [[QQButton alloc]initWithFrame:CGRectMake(idx *btnWidth, 0, btnWidth, titleScrollHeight)];
                item.tag = idx + itemTag;
                [item setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                item.titleLabel.textColor = [UIColor redColor];
                [item setTitle:obj forState:UIControlStateNormal];
                [item.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
                item.titleLabel.textAlignment = NSTextAlignmentCenter;
                if (idx ==0) {
                    weakSelf.lastItem = item;
                    [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    item.backgroundColor = [UIColor cyanColor];
                }
                [weakSelf.itemArray addObject:item];
                [weakSelf.titleScroll addSubview:item];
            }
        }];
    }
    return _titleScroll;
}
@end
