//
//  HRSelectImageCell.h
//  handRent
//
//  Created by qinmuqiao on 2019/1/2.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "QQTableViewCell.h"
#import <TZImageManager.h>
#import <TZImagePickerController.h>
#import <Photos/Photos.h>
#import <TZVideoPlayerController.h>
#import <TZPhotoPreviewController.h>
#import <TZGifPhotoPreviewController.h>
#import <MobileCoreServices/MobileCoreServices.h>
NS_ASSUME_NONNULL_BEGIN

@interface HRSelectImageItem : QQTableViewItem
@property (nonatomic , assign) NSInteger  maxImage;

/**以选择的的图片 包含默认显示的数组*/
@property (nonatomic , strong,readonly) NSMutableArray * selectedImages;

/**默认显示的数组 uiimage/nsstring*/
@property (nonatomic , strong) NSMutableArray * defaultPhotos;

/***selectedPhotos 发生变化就执行的Block*/
@property (nonatomic , copy) void(^selectImage)(HRSelectImageItem *ttitem,NSMutableArray * imageArray);
@end

@interface HRSelectImageCell : QQTableViewCell<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>
@property (nonatomic , strong) HRSelectImageItem * item;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout * layout ;
@property (nonatomic , strong) UIView * line;
@end

NS_ASSUME_NONNULL_END
