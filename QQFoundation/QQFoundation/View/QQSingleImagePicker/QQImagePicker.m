//
//  QQImagePicker.m
//  take Photo
//
//  Created by ZhangQun on 2017/7/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "QQImagePicker.h"
#import <AVFoundation/AVFoundation.h>
#import "QQCropperViewController.h"
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

@interface QQImagePicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,QQCropperViewControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *ImagePickerController;
@property (nonatomic,assign) CGRect CropRect;
@property (nonatomic,strong) QQCropperViewController *imageCropperController;
@end

@implementation QQImagePicker
+ (instancetype)ShareInstance
{
    static dispatch_once_t onceToken;
    static QQImagePicker *imagepicker = nil;
    dispatch_once(&onceToken, ^{
        imagepicker = [[QQImagePicker alloc]init];
    });
    return imagepicker;
}
- (void)initwithCropRect:(CGRect)CropRect ChoosePicType:(QQChoosePicType)ChoosePicType
{    if (ChoosePicType == QQChoosePicCamera) {
        if (SIMULATOR) {
            NSLog(@"模拟器无法打开相机");
            return;
        }else{            
            self.ImagePickerController.sourceType =UIImagePickerControllerSourceTypeCamera;
        }
    }else{
        self.ImagePickerController.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.ImagePickerController.modalPresentationStyle =  UIModalPresentationFullScreen;
    self.CropRect = CropRect;
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:self.ImagePickerController animated:YES completion:nil];
}
- (UIImagePickerController *)ImagePickerController
{
    if (! _ImagePickerController) {
        _ImagePickerController = [[UIImagePickerController alloc]init];
        _ImagePickerController.delegate = self;
        _ImagePickerController.allowsEditing = NO;
    }
    return _ImagePickerController;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //能获取照片的详细信息
    //    NSDictionary *dict = [info objectForKey:UIImagePickerControllerMediaMetadata];
    
    UIImageOrientation imageOrientation=image.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    self.imageCropperController = [[QQCropperViewController alloc] init];
    self.imageCropperController.delegate = self;
    self.imageCropperController.originalImage = image;
    self.imageCropperController.cropFrame = self.CropRect;
    [picker pushViewController:self.imageCropperController animated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)QQCropperDidCancel:(QQCropperViewController *)QQCropperViewController
{
      UIImagePickerController *picker = (UIImagePickerController *)QQCropperViewController.navigationController;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [QQCropperViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        //popToRootViewControllerAnimated原因是 如果选择的是gif会经过系统的裁剪框 返回上一个界面系统的裁剪框取消点击不了
//        [QQCropperViewController.navigationController popViewControllerAnimated:YES];
        [QQCropperViewController.navigationController popToRootViewControllerAnimated:YES];
    }
    [self.ImagePickerController setNavigationBarHidden:YES];
    [self.ImagePickerController setNavigationBarHidden:YES animated:NO];
}
- (void)QQCropperViewController:(QQCropperViewController *)QQCropperViewController didFinishedImage:(UIImage *)CropImage
{
      [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(QQImagePicker:didFinishPic:)]) {
        [self.delegate QQImagePicker:self didFinishPic:CropImage];
    }
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([UIDevice currentDevice].systemVersion.floatValue < 11)
    {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")])
    {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             // iOS 11之后，图片编辑界面最上层会出现一个宽度<42的view，会遮盖住左下方的cancel按钮，使cancel按钮很难被点击到，故改变该view的层级结构
             if (obj.frame.size.width < 42)
             {
                 [viewController.view sendSubviewToBack:obj];
                 *stop = YES;
             }
         }];
    }
}

@end
