//
//  MCPageView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/10.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPageView.h"
#import "UIView+QQFrame.h"
#define kwidth          [UIScreen mainScreen].bounds.size.width
#define kheight        [UIScreen mainScreen].bounds.size.height
#define itemDefaultColor [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1]

@interface MCPageView ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic , strong) NSArray * contentCtrollers;
@property (nonatomic , strong) NSArray * contentTitles;
@property (nonatomic , strong) UIScrollView * titleScroll;
@property (nonatomic , strong) UICollectionView * contentCollection;
@property (nonatomic , strong) NSMutableArray * itemArray;
@property (nonatomic , strong) MCItem * lastItem;
@property (nonatomic , strong) UIView  * lineView;
@end

static const NSInteger itemTag = 100;
/**titleButton的最小宽度*/
static const NSInteger  minTitleButtonWitdh = 60;
@implementation MCPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles controllers:(NSArray *)controllers
{
    if (self = [super initWithFrame:frame]) {
        self.contentTitles = [NSArray arrayWithArray:titles];
        _contentCtrollers = [NSArray arrayWithArray:controllers];
        self.itemArray = [NSMutableArray array];
        //titleView 的初始化高度
        _titleScrollHeight = 50;
        //初始化横线的宽度是title的一半
        _lineWitdhScale = 0.5;
        
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
        NSInteger index = (int)scrollView.contentOffset.x/kwidth;
        [self changeItemStatus:index];
    }
}
- (void)selectItem:(MCItem *)btn
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
- (void)setBadgeWithIndex:(NSInteger)index badge:(NSInteger)badge
{
    if (index <0 || index >= self.itemArray.count) {
        NSLog(@"设置下标错误");
        return;
    }
    MCItem *item =  self.itemArray[index];
    item.badge = badge;
}
- (void)setItemBadgeWithArray:(NSArray *)badgeArray
{
    if (badgeArray.count > self.itemArray.count || badgeArray.count ==0) {
        NSLog(@"设置下标错误");
        return;
    }
    __weak __typeof(&*self)weakSelf = self;
    [badgeArray enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MCItem *item =  weakSelf.itemArray[idx];
        item.badge = obj.integerValue;
    }];
}
- (void)changeItemStatus:(NSInteger)index
{
    [self menuScrollToCenter:index];
    MCItem * Item = self.itemArray[index];
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

/**
 顶部菜单滑动到中间

 @param index 第几个item
 */
- (void)menuScrollToCenter:(NSInteger)index{

    MCItem *Button = self.itemArray[index];
    CGFloat left = Button.center.x - kwidth / 2.0;
    left = left <= 0 ? 0 : left;
    CGFloat maxLeft = _titleButtonWidth * self.contentTitles.count - kwidth;
    if (maxLeft <=0) {
        maxLeft = 0;
    }
    left = left >= maxLeft ? maxLeft : left;
    [self.titleScroll setContentOffset:CGPointMake(left, 0) animated:YES];
    
}

/**
 title底部横线滑动

 @param item 滑动到那个item下
 */
- (void)scrollToItemCenter:(MCItem *)item
{
    if (!item) {
        return;
    }
    [UIView animateWithDuration:0.15 animations:^{
        self.lineView.center = item.center;
        self.lineView.bottom = item.bottom -1;
    }];
}

/**设置选中title字体*/
- (void)setSelectTitleFont:(UIFont *)selectTitleFont
{
    _selectTitleFont = selectTitleFont;
    self.lastItem.titleLabel.font = _selectTitleFont;
}
/**设置选中title颜色*/
- (void)setSelectTitleColor:(UIColor *)selectTitleColor
{
    _selectTitleColor = selectTitleColor;
    [self.lastItem setTitleColor:_selectTitleColor forState:UIControlStateNormal];
    
    _lineColor = selectTitleColor;
    self.lineView.backgroundColor = selectTitleColor;
}
- (void)setDefaultTitleFont:(UIFont *)defaultTitleFont
{
    _defaultTitleFont = defaultTitleFont;
    __weak __typeof(&*self)weakSelf = self;
    [self.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MCItem *item =  weakSelf.itemArray[idx];
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
        MCItem *item =  weakSelf.itemArray[idx];
        if (![item isEqual:weakSelf.lastItem]) {
            [item setTitleColor:_defaultTitleColor forState:UIControlStateNormal];
        }
    }];
}
/**设置横线颜色*/
- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.lineView.backgroundColor = lineColor;
}
/**设置横下相对于titleBtn款低的比例*/
- (void)setLineWitdhScale:(CGFloat)lineWitdhScale
{
    _lineWitdhScale = lineWitdhScale;
    CGRect rect = self.lineView.frame;
    rect.size.width = _titleButtonWidth*lineWitdhScale;
    self.lineView.frame = rect;
}
/**是否允许页面滑动*/
- (void)setCanSlide:(BOOL)canSlide
{
    _canSlide = canSlide;
    self.contentCollection.scrollEnabled = canSlide;
}
/**设置选中titlebtn的宽度*/
- (void)setTitleButtonWidth:(CGFloat)titleButtonWidth
{
    _titleButtonWidth = titleButtonWidth;
    //取最小值minTitleButtonWitdh
    if (_titleButtonWidth < minTitleButtonWitdh) {
        _titleButtonWidth = minTitleButtonWitdh;
    }
    //如果给的宽度与title个数乘积小于屏幕宽度   则无效  。取平分屏幕
    if ((_titleButtonWidth *_contentTitles.count) >kwidth) {
        self.titleScroll.contentSize = CGSizeMake((_titleButtonWidth *_contentTitles.count), self.titleScrollHeight);
    }else{
        _titleButtonWidth = kwidth/(self.itemArray.count);
        self.titleScroll.contentSize = CGSizeMake(kwidth, self.titleScrollHeight);
    }
    __weak __typeof(&*self)weakSelf = self;
    [self.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MCItem *item =  weakSelf.itemArray[idx];
        item.frame = CGRectMake(idx *_titleButtonWidth, 0, _titleButtonWidth, self.titleScrollHeight);
    }];
    
    CGRect lineRect = self.lineView.frame;
    lineRect.size.width = _titleButtonWidth*_lineWitdhScale;
    self.lineView.frame = lineRect;
    [self scrollToItemCenter:self.lastItem];
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(_titleButtonWidth/4, self.titleScrollHeight - 1, _titleButtonWidth/2, 1)];
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

        _titleButtonWidth = kwidth/_contentTitles.count;
        //最小值与个数乘积还大与屏幕的话 就按60宽度算
        if (_contentTitles.count * minTitleButtonWitdh > kwidth) {
            _titleButtonWidth = minTitleButtonWitdh;
            self.titleScroll.contentSize = CGSizeMake((minTitleButtonWitdh *_contentTitles.count), self.titleScrollHeight);
        }else{
            self.titleScroll.contentSize = CGSizeMake(kwidth, self.titleScrollHeight);
        }
        __weak __typeof(&*self)weakSelf = self;
        [_contentTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool{
                MCItem *item = [[MCItem alloc]initWithFrame:CGRectMake(idx *_titleButtonWidth, 0, self.titleButtonWidth, self.titleScrollHeight)];
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

@interface MCItem()
@property (nonatomic,strong) UILabel *badgeLb;

@end
@implementation MCItem
{
    CGRect originRect;
}
- (void)setBadge:(NSInteger)badge
{
    _badge = badge;
    NSString *badgeText = [NSString string];
    if (badge > 99) {
        badgeText = @"99+";
    }else if(badge >0){
        badgeText = [NSString stringWithFormat:@"%lu",(long)badge];
    }else{
        self.badgeLb.text = @"";
    }
    self.badgeLb.text = badgeText;
    [self.badgeLb sizeToFit];
    originRect = self.badgeLb.frame;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = originRect;
    if (_badge < 0) {
        rect.size.width = 10;
        rect.size.height = 10;
    }else if(_badge == 0){
        rect.size.width = 0;
    }else{
      rect.size.width =  originRect.size.width + 5;
    }
    self.badgeLb.frame  = rect;
    
    CGPoint point = self.badgeLb.center;
    point.x = self.frame.size.width/2 + (self.titleLabel.frame.size.width/2);
    point.y = self.frame.size.height/2 - self.titleLabel.frame.size.height/2 - 5;
    self.badgeLb.center = point;
    self.badgeLb.layer.cornerRadius = self.badgeLb.frame.size.height/2;
    
}
- (UILabel *)badgeLb
{
    if (!_badgeLb) {
        _badgeLb = [[UILabel alloc]init];
        _badgeLb.textColor = [UIColor whiteColor];
        _badgeLb.backgroundColor = [UIColor redColor];
        _badgeLb.font = [UIFont systemFontOfSize:10];
        _badgeLb.textAlignment = NSTextAlignmentCenter;
        _badgeLb.layer.masksToBounds = YES;
//        [_badgeLb setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_badgeLb];
    }
    return _badgeLb;
}

@end
