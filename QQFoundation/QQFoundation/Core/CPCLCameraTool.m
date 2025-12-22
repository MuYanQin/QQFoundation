//
//  CPSLCameraTool.m
//  SPCLSdk
//
//  Created by peanut on 2024/11/20.
//

#import "CPCLCameraTool.h"
#import <UIKit/UIKit.h>
@interface CPCLCameraTool ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,copy) void (^callBack)(NSDictionary<NSString*,NSObject*>*);
@end
@implementation CPCLCameraTool
- (void)getCameraImageWithHandler:(void (^)(NSDictionary<NSString*,NSObject*>*))handler{
    [CPCLCameraTool getCameraAuthWithHandler:^(AVAuthorizationStatus status) {
        if (status != AVAuthorizationStatusAuthorized) {
            //如果拒绝，给出提示，跳转到应用设置页面
            [CPCLCameraTool reopenAuthorityWithMessage:@"相机访问权限已关闭，是否前往应用设置开启？"];
            return;
        }
        self.callBack = handler;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = NO;
            imagePickerController.sourceType =UIImagePickerControllerSourceTypeCamera;
            imagePickerController.modalPresentationStyle =  UIModalPresentationFullScreen;
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
        });

    }];
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
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0); // 1.0 表示最高质量
    if (!imageData) {
        return ;
    }
    // 将 NSData 转换为 Base64 字符串
    NSString *base64String = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    self.callBack(@{});
    [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
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
+ (void)getCameraAuthWithHandler:(void (^)(AVAuthorizationStatus))handler{
    AVAuthorizationStatus cameraStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (cameraStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                // 用户授权了相机权限
                handler(AVAuthorizationStatusAuthorized);
            } else {
                // 用户拒绝了相机权限
                handler(AVAuthorizationStatusDenied);
            }
        }];
    } else {
        handler(cameraStatus);
    }
}
+(void)reopenAuthorityWithMessage:(NSString*)message{
    //如果拒绝，给出提示，跳转到应用设置页面
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction * determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:^(BOOL success) {
            }];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:determineAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];

    });
}
@end
