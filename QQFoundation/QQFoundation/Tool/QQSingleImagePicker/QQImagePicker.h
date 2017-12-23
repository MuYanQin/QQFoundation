//
//  QQImagePicker.h
//  take Photo
//
//  Created by ZhangQun on 2017/7/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class QQImagePicker;
@protocol QQImagePickerDelegate <NSObject>

- (void)QQImagePicker:(QQImagePicker *)QQImagePicker didFinishPic:(UIImage *)Pic;
@optional

- (void)QQImagePickerDidCancel:(QQImagePicker *)QQImagePicker;

@end
typedef NS_ENUM(NSUInteger, QQChoosePicType){
    QQChoosePicCamera,
    QQChoosePicLibray
};
@interface QQImagePicker : NSObject
@property (nonatomic,weak) id<QQImagePickerDelegate> delegate;

+ (instancetype)ShareInstance;
- (void)initwithCropRect:(CGRect)CropRect ChoosePicType:(QQChoosePicType)ChoosePicType;


@end
