//
//  CCTZImgPickerTool.h
//  crosscountry
//
//  Created by leaduMac on 2020/7/6.
//  Copyright © 2020 leaduadmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TZImageManager.h>
#import <TZImagePickerController.h>
#import <Photos/Photos.h>
#import <TZVideoPlayerController.h>
#import <TZPhotoPreviewController.h>
#import <TZGifPhotoPreviewController.h>
#import <MobileCoreServices/MobileCoreServices.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCTZImgPickerTool : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>
@property (nonatomic , assign) NSInteger  maxCount;///<最大可选择几张
@property (nonatomic , assign) BOOL  allowCrop;///<是否允许裁剪
@property (nonatomic , assign) CGRect  cropRect;///<裁剪框的尺寸


@property (nonatomic , strong) NSMutableArray * selectedAssets;

- (void)showSelectStyle;

@property (nonatomic , copy) NSArray* (^selectImges)(NSArray *images,NSArray *assets);
@end

NS_ASSUME_NONNULL_END
