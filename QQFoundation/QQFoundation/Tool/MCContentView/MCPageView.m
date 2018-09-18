//
//  MCPageView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/10.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPageView.h"
#import "UIView+QQFrame.h"
#import "QQButton.h"
#define kwidth          [UIScreen mainScreen].bounds.size.width
#define kheight        [UIScreen mainScreen].bounds.size.height
#define itemDefaultColor [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1]

@interface MCPageView ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic , strong) NSArray * contentCtrollers;
@property (nonatomic , strong) NSArray * contentTitles;
@property (nonatomic , strong) UIScrollView * titleScroll;
@property (nonatomic , strong) UICollectionView * contentCollection;
@property (nonatomic , strong) NSMutableArray * itemArray;
@property (nonatomic , strong) QQButton * lastItem;
@property (nonatomic , strong) UIView  * lineView;
@end

static const NSInteger itemTag = 100;
static const NSInteger  minTitleButtonWitdh = 60;
@implementation MCPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles controllers:(NSArray *)controllers
{
    if (self = [super initWithFrame:frame]) {
        self.contentTitles = [NSArray arrayWithArray:titles];
        _contentCtrollers = [NSArray arrayWithArray:controllers];
        self.itemArray = [NSMutableArray array];
        self.titleScrollHeight = 60;
        self.lineWitdhScale = 0.5;
        [self addSubview:self.titleScroll];
        [self.titleScroll addSubview:self.lineView];
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
    cell.highlighted = NO;
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
    if (index <0 || index >self.contentCtrollers.count) {
        NSLog(@"滚动的位置大于条目数");
        return;
    }
    [self.contentCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:labs(index) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [self changeItemStatus:index];
}
- (void)changeItemStatus:(NSInteger)index
{
    [self menuScrollToCenter:index];
    QQButton * Item = self.itemArray[index];
    if (self.lastItem) {
        self.lastItem.titleLabel.font = self.defaultTitleFont ?self.defaultTitleFont:[UIFont systemFontOfSize:14];
        [self.lastItem setTitleColor:self.defaultTitleColor ?self.defaultTitleColor:itemDefaultColor forState:UIControlStateNormal];
        
    }
    self.lastItem = Item;
    Item.titleLabel.font = self.selectTitleFont ?self.selectTitleFont:[UIFont systemFontOfSize:14];
    [Item setTitleColor:self.selectTitleColor ?self.selectTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self scrollToItemCenter:Item];

    if ([self.delegate respondsToSelector:@selector(MCPageView:didSelectIndex:)]) {
        [self.delegate MCPageView:self didSelectIndex:index];
    }
}
// 顶部菜单滚动
- (void)menuScrollToCenter:(NSInteger)index{
    
    CGFloat itemWidth = _titleButtonWidth?_titleButtonWidth : kwidth / self.contentTitles.count;
    QQButton *Button = self.itemArray[index];
    CGFloat left = Button.center.x - kwidth / 2.0;
    left = left <= 0 ? 0 : left;
    CGFloat maxLeft = itemWidth * self.contentTitles.count - kwidth;
    left = left >= maxLeft ? maxLeft : left;
    [self.titleScroll setContentOffset:CGPointMake(left, 0) animated:YES];
}
- (void)scrollToItemCenter:(QQButton *)item
{
    [UIView animateWithDuration:0.15 animations:^{
        self.lineView.center = item.center;
        self.lineView.bottom = item.bottom -1;
    }];
}
- (void)setSelectTitleFont:(UIFont *)selectTitleFont
{
    _selectTitleFont = selectTitleFont;
    self.lastItem.titleLabel.font = _selectTitleFont;
}
- (void)setSelectTitleColor:(UIColor *)selectTitleColor
{
    _selectTitleColor = selectTitleColor;
    [self.lastItem setTitleColor:_selectTitleColor forState:UIControlStateNormal];
    
    _lineColor = selectTitleColor;
    self.lineView.backgroundColor = selectTitleColor;
}
- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.lineView.backgroundColor = lineColor;
}
- (void)setLineWitdhScale:(CGFloat)lineWitdhScale
{
    _lineWitdhScale = lineWitdhScale;
    CGRect rect = self.lineView.frame;
    rect.size.width = self.titleButtonWidth*lineWitdhScale;
    self.lineView.frame = rect;
}
- (void)setCanSlide:(BOOL)canSlide
{
    _canSlide = canSlide;
    self.contentCollection.scrollEnabled = canSlide;
}
- (void)setTitleButtonWidth:(CGFloat)titleButtonWidth
{
    _titleButtonWidth = titleButtonWidth;
    CGFloat titleBtnWitdh  = 0;
    //如果给的宽度和个数乘积还是小于屏幕宽度的话 则无效 还是平分屏幕
    if ((_titleButtonWidth *_contentTitles.count) >kwidth) {
        self.titleScroll.contentSize = CGSizeMake((_titleButtonWidth *_contentTitles.count), self.titleScrollHeight);
        titleBtnWitdh = _titleButtonWidth;
    }else{
        self.titleScroll.contentSize = CGSizeMake(kwidth, self.titleScrollHeight);
        titleBtnWitdh = kwidth/(self.itemArray.count);
    }
    __weak __typeof(&*self)weakSelf = self;
    [self.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QQButton *item =  weakSelf.itemArray[idx];
        item.frame = CGRectMake(idx *titleBtnWitdh, 0, titleBtnWitdh, self.titleScrollHeight);
    }];
}

- (void)setDefaultTitleFont:(UIFont *)defaultTitleFont
{
    _defaultTitleFont = defaultTitleFont;
    __weak __typeof(&*self)weakSelf = self;
    [self.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QQButton *item =  weakSelf.itemArray[idx];
        if (![item isEqual:weakSelf.lastItem]) {
            item.titleLabel.font = _defaultTitleFont;
        }
    }];
}
- (void)setDefaultTitleColor:(UIColor *)defaultTitleColor
{
    _defaultTitleColor = defaultTitleColor;
    __weak __typeof(&*self)weakSelf = self;
    [self.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QQButton *item =  weakSelf.itemArray[idx];
        if (![item isEqual:weakSelf.lastItem]) {
            [item setTitleColor:_defaultTitleColor forState:UIControlStateNormal];
        }
    }];
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.titleButtonWidth/4, self.titleScrollHeight - 1, self.titleButtonWidth/2, 1)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
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
        _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kwidth, self.titleScrollHeight)];
        _titleScroll.delegate = self;
        _titleScroll.showsVerticalScrollIndicator = NO;
        _titleScroll.showsHorizontalScrollIndicator = NO;

        self.titleButtonWidth = kwidth/_contentTitles.count;
        //最小值与个数乘积还大与屏幕的话 就按60宽度算
        if (_contentTitles.count * minTitleButtonWitdh > kwidth) {
            self.titleButtonWidth = minTitleButtonWitdh;
            self.titleScroll.contentSize = CGSizeMake((minTitleButtonWitdh *_contentTitles.count), self.titleScrollHeight);
        }else{
            self.titleScroll.contentSize = CGSizeMake(kwidth, self.titleScrollHeight);
        }
        __weak __typeof(&*self)weakSelf = self;
        [_contentTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool{
                QQButton *item = [[QQButton alloc]initWithFrame:CGRectMake(idx *self.titleButtonWidth, 0, self.titleButtonWidth, self.titleScrollHeight)];
                item.tag = idx + itemTag;
                [item setTitleColor:itemDefaultColor forState:UIControlStateNormal];
                [item setTitle:obj forState:UIControlStateNormal];
                [item.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
                item.titleLabel.textAlignment = NSTextAlignmentCenter;
                if (idx ==0) {
                    weakSelf.lastItem = item;
                    [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                [weakSelf.itemArray addObject:item];
                [weakSelf.titleScroll addSubview:item];
            }
        }];
    }
    return _titleScroll;
}

@end
