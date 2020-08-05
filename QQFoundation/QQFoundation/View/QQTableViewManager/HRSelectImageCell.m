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
@property (nonatomic , strong) NSMutableArray * selectedPhotos;

@end
@implementation HRSelectImageItem
- (instancetype)init
{
    if (self = [super init]) {
        self.CellHeight = 100;
        self.selectedAssets = [NSMutableArray array];
        self.selectedPhotos = [NSMutableArray array];
        self.defaultPhotos = [NSMutableArray array];
    }
    return self;
}
- (void)setDefaultPhotos:(NSMutableArray *)defaultPhotos
{
    _defaultPhotos = defaultPhotos;
    [self.selectedPhotos addObjectsFromArray:self.defaultPhotos];
}
- (NSMutableArray *)selectedImages
{
    return self.selectedPhotos;
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
    if (self.item.maxImage == self.item.selectedPhotos.count) {
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
        id value = self.item.selectedPhotos[indexPath.row];
        if ([value isKindOfClass:[UIImage class]]) {
            cell.imageView.image = self.item.selectedPhotos[indexPath.row];
        }else if ([value isKindOfClass:[NSString class]]){
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:value] placeholderImage:nil];
        }
        
        cell.button.hidden = NO;
    }else{
        if (indexPath.row == self.item.selectedPhotos.count) {
            cell.imageView.image = [UIImage imageNamed:@"SelectImage"];
            cell.button.hidden = YES;
        }else{
            id value = self.item.selectedPhotos[indexPath.row];
            if ([value isKindOfClass:[UIImage class]]) {
                cell.imageView.image = self.item.selectedPhotos[indexPath.row];
            }else if ([value isKindOfClass:[NSString class]]){
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:value] placeholderImage:nil];
            }
    
            cell.button.hidden = NO;
        }
    }
    cell.button.QInfo(@(indexPath.row));
    QQWeakSelf
    cell.deleteImage = ^(NSInteger tag) {
        [weakSelf deleteImage:tag];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.item.maxImage == self.item.selectedPhotos.count) {
        
    }else{
        if (indexPath.row == self.item.selectedPhotos.count) {//添加图片
            QQWeakSelf
            self.imgPikerTool = [[CCTZImgPickerTool alloc]init];
            self.imgPikerTool.selectedAssets = weakSelf.item.selectedAssets;
            self.imgPikerTool.selectImges = ^(NSArray * _Nonnull images, NSArray * _Nonnull assets) {
                weakSelf.item.selectedPhotos = [NSMutableArray arrayWithArray:weakSelf.item.defaultPhotos];
                [weakSelf.item.selectedPhotos addObjectsFromArray:images];
                weakSelf.item.selectedAssets = [NSMutableArray arrayWithArray:assets];
                if (weakSelf.item.selectImage) {
                    weakSelf.item.selectImage(weakSelf.item,weakSelf.item.selectedPhotos);
                }
                [weakSelf.collectionView reloadData];
                
                return weakSelf.item.selectedAssets;
            };
            [self.imgPikerTool showSelectStyle];
        }else{//预览图片
            
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [tzImagePickerVc showProgressHUD];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // save photo and get asset / 保存图片，获取到asset
    [[TZImageManager manager] savePhotoWithImage:image location:nil completion:^(PHAsset *asset, NSError *error){
        [tzImagePickerVc hideProgressHUD];
        if (error) {
            NSLog(@"图片保存失败 %@",error);
        } else {
            [self refreshCollectionViewWithAddedAsset:asset image:image];
        }
    }];
    
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    self.item.selectedPhotos = [NSMutableArray arrayWithArray:self.item.defaultPhotos];
    [self.item.selectedPhotos addObjectsFromArray:photos];
    self.item.selectedAssets = [NSMutableArray arrayWithArray:assets];
    
    
    if (self.item.selectImage) {
        self.item.selectImage(self.item,self.item.selectedPhotos);
    }
    [_collectionView reloadData];
}
- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [self.item.selectedAssets addObject:asset];
    [self.item.selectedPhotos addObject:image];
    
    
    if (self.item.selectImage) {
        self.item.selectImage(self.item,self.item.selectedPhotos);
    }
    [_collectionView reloadData];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
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
    if (self.item.selectImage) {
        self.item.selectImage(self.item,self.item.selectedPhotos);
    }
    [_collectionView reloadData];
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
