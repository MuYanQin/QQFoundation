//
//  MCPickerHeaderView.m
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/6.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import "MCPickerHeaderView.h"
#import "MyCollectionViewCell.h"
@interface MCPickerHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView * collectionView;
@property (nonatomic , strong) UIView * animationline;
@property (nonatomic , assign) BOOL  isRealodData;
@end
@implementation MCPickerHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        [self initAnimationLine];
    }
    return self;
}
- (void)initAnimationLine
{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.7;
    [self addSubview:line];
    
    self.animationline = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.frame.size.height - 1, 0, 1)];
    self.animationline.backgroundColor = [UIColor redColor];
    [self.collectionView addSubview:self.animationline];
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout= [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView .delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    
    cell.tLb.text = self.dataArray[indexPath.row];
    if (self.isLastRed && (indexPath.row ==  self.dataArray.count -1)) {
        cell.tLb.textColor = [UIColor redColor];
    }else{
        cell.tLb.textColor = [UIColor blackColor];
    }
    if (self.isRealodData) {
        CGRect tt = cell.frame;
        tt.origin.y = tt.size.height - 1;
        tt.size.height = 1;
        [UIView animateWithDuration:0.5 animations:^{
            self.animationline.frame = tt;
        }];
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dalegate respondsToSelector:@selector(MCPickerHeaderView:didSelcetIndex:)]) {
        [self.dalegate MCPickerHeaderView:self didSelcetIndex:indexPath.row];
    }
    [self setAnimationLineAnimation:indexPath];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = self.dataArray[indexPath.row];
    CGFloat witdh =[string boundingRectWithSize:CGSizeMake(0, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14] } context:nil].size.width;
    return CGSizeMake(witdh + 10, self.frame.size.height);
}
// 设置cell的水平间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (void)setindex:(NSInteger )index
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];
    [self setAnimationLineAnimation:indexpath];
}
- (void)setAnimationLineAnimation:(NSIndexPath *)indexpath
{
    self.isRealodData = NO;
    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpath];
    CGRect tt = cell.frame;
    tt.origin.y = tt.size.height - 1;
    tt.size.height = 1;
    [UIView animateWithDuration:0.5 animations:^{
        self.animationline.frame = tt;
    }];
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    self.isRealodData = YES;
    [self.collectionView reloadData];
}
@end
