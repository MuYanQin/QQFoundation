//
//  HRSelectImageCell.m
//  handRent
//
//  Created by qinmuqiao on 2019/1/2.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "HRSelectImageCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+QQFrame.h"
@interface HRSelectImageItem ()
@property (nonatomic , strong) NSMutableArray * selectedAssets;

@end
@implementation HRSelectImageItem
- (instancetype)init
{
    if (self = [super init]) {
        self.CellHeight = 100;
        self.selectedAssets = [NSMutableArray array];
        self.selectedPhotos = [NSMutableArray array];
        self.defaultPhotos = [NSMutableArray array];
        self.detail = NO;
    }
    return self;
}
- (void)setDefaultPhotos:(NSMutableArray *)defaultPhotos
{
    _defaultPhotos = defaultPhotos;
    [self.selectedPhotos addObjectsFromArray:self.defaultPhotos];
}
- (NSMutableArray *)selectedimages
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (id object in self.selectedPhotos) {
        if ([object isKindOfClass:[UIImage class]]) {
            [tempArray addObject:object];
        }
    }
    return tempArray;
}
- (NSMutableArray *)surplusURL
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (id object in self.selectedPhotos) {
        if (![object isKindOfClass:[UIImage class]]) {
            [tempArray addObject:object];
        }
    }
    return tempArray;
}
@end

@implementation HRSelectImageCell

@synthesize item = _item;

- (void)cellDidLoad
{
    [super cellDidLoad];
    [self configCollectionView];
    self.line = getView(getColorWithHex(@"eeeeee"));
    [self.contentView addSubview:self.line];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.item.maxImage == self.item.selectedPhotos.count || self.item.detail) {
        return self.item.selectedPhotos.count;
    }else{
        return self.item.selectedPhotos.count + 1;
    }
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArtileImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArtileImageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (self.item.maxImage == self.item.selectedPhotos.count) {
        [self showImgInCell:cell indexPath:indexPath];
    }else{
        if (indexPath.row == self.item.selectedPhotos.count) {
            cell.imageView.image = [UIImage imageNamed:@"selectImage"];
            cell.button.hidden = YES;
        }else{
            [self showImgInCell:cell indexPath:indexPath];
        }
    }
    cell.button.QInfo(@(indexPath.row));
    QQWeakSelf
    cell.deleteImage = ^(NSInteger tag) {
        [weakSelf deleteImage:tag];
    };
    return cell;
}
- (void)showImgInCell:(ArtileImageCell *)cell indexPath:(NSIndexPath *)indexPath{
    id value = self.item.selectedPhotos[indexPath.row];
    if ([value isKindOfClass:[UIImage class]]) {
        cell.imageView.image = self.item.selectedPhotos[indexPath.row];
    }else if ([value isKindOfClass:[NSString class]]){
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:value] placeholderImage:nil];
    }
    cell.button.hidden = NO;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.item.maxImage != self.item.selectedPhotos.count && indexPath.row == self.item.selectedPhotos.count ) {
        QQWeakSelf
        self.imgPikerTool = [[CCTZImgPickerTool alloc]init];
        self.imgPikerTool.selectedAssets = weakSelf.item.selectedAssets;
        self.imgPikerTool.maxCount = self.item.maxImage;
        self.imgPikerTool.selectImges = ^(NSArray * _Nonnull images, NSArray * _Nonnull assets) {
            weakSelf.item.selectedPhotos = [NSMutableArray arrayWithArray:weakSelf.item.defaultPhotos];
            [weakSelf.item.selectedPhotos addObjectsFromArray:images];
            weakSelf.item.selectedAssets = [NSMutableArray arrayWithArray:assets];
            [weakSelf imgCountChange];
        };
        [self.imgPikerTool showSelectStyle];
    }else{
        //预览图片
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth - 50)/4, 80);
}
// 设置cell的水平间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (void)deleteImage:(NSInteger )index
{
    id value = self.item.selectedPhotos[index];
    if ([self.item.defaultPhotos containsObject:value]) {
        [self.item.defaultPhotos removeObject:value];
    }else{//不存在就是从图册中选择的
        NSInteger row = index - self.item.defaultPhotos.count;
        [self.item.selectedAssets removeObjectAtIndex:row];
    }
    [self.item.selectedPhotos removeObjectAtIndex:index];
    [self imgCountChange];
}
- (void)imgCountChange{
    if (self.item.selectImage) {
        self.item.selectImage(self.item,self.item.selectedPhotos);
    }
    self.item.CellHeight = ((int)self.item.selectedPhotos.count/4)*90 + 100;
    [self.item reloadRowWithAnimation:(UITableViewRowAnimationNone)];
}
- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    self.layout = [[UICollectionViewFlowLayout alloc]init];
    self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    _collectionView.dataSource = self;
    _collectionView .delegate = self;
    _collectionView.scrollEnabled = NO;

    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ArtileImageCell class] forCellWithReuseIdentifier:@"ArtileImageCell"];
    [self.contentView addSubview:self.collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

@end


@implementation ArtileImageCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        [self setUpAllChildView];
    }
    return self;
}
- (void)setUpAllChildView
{
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    self.button = [QQButton buttonWithType:UIButtonTypeCustom];
    self.button.QimageSize(CGSizeMake(15, 15)).QtextPosition(Tright);
    [self.button setImage:[UIImage imageNamed:@"deleteImg"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}
- (void)buttonClick:(QQButton *)button
{
    if (self.deleteImage) {
        self.deleteImage([button.info integerValue]);
    }
}

@end
