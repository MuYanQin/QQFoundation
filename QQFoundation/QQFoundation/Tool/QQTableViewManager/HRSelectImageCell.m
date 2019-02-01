//
//  HRSelectImageCell.m
//  handRent
//
//  Created by qinmuqiao on 2019/1/2.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "HRSelectImageCell.h"
#import "ArtileImageCell.h"
#import "UIView+SuperViewController.h"
#import "UIImageView+WebCache.h"
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
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self takePhoto];
            }];
            [alertVc addAction:takePhotoAction];
            UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self pushTZImagePickerController];
            }];
            [alertVc addAction:imagePickerAction];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertVc addAction:cancelAction];
            UIPopoverPresentationController *popover = alertVc.popoverPresentationController;
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
            if (popover) {
                popover.sourceView = cell;
                popover.sourceRect = cell.bounds;
                popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.viewController presentViewController:alertVc animated:YES completion:nil];
            });
        }else{//预览图片
            
        }
    }
}
- (void)pushTZImagePickerController {
    if (self.item.maxImage <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.item.maxImage columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = self.item.selectedAssets; // 目前已经选中的图片数组
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    imagePickerVc.showSelectedIndex = YES;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        
    }];
    
    [self.viewController presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    //    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
    //        __strong typeof(weakSelf) strongSelf = weakSelf;
    //        strongSelf.location = [locations firstObject];
    //    } failureBlock:^(NSError *error) {
    //        __strong typeof(weakSelf) strongSelf = weakSelf;
    //        strongSelf.location = nil;
    //    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.viewController presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [tzImagePickerVc showProgressHUD];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // save photo and get asset / 保存图片，获取到asset
    [[TZImageManager manager] savePhotoWithImage:image location:nil completion:^(PHAsset *asset, NSError *error){
        [tzImagePickerVc hideProgressHUD];
        if (error) {
            NSLog(@"图片保存失败 %@",error);
        } else {
            //            TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
            //            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
            [self refreshCollectionViewWithAddedAsset:asset image:image];
            //            }];
            //            imagePicker.cropRect = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
            //            [self.viewController presentViewController:imagePicker animated:YES completion:nil];
            
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
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
    }
    return _imagePickerVc;
}
@end
