//
//  QQCropperViewController.h
//  take Photo
//
//  Created by ZhangQun on 2017/7/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQCropperViewController;
@protocol QQCropperViewControllerDelegate <NSObject>
- (void)QQCropperViewController:(QQCropperViewController *)QQCropperViewController  didFinishedImage:(UIImage *)CropImage;

- (void)QQCropperDidCancel:(QQCropperViewController *)QQCropperViewController;

@end

@interface QQCropperViewController : UIViewController
@property (nonatomic,assign) CGRect cropFrame;
@property (nonatomic,strong) UIImage *originalImage;
@property (nonatomic,assign) id<QQCropperViewControllerDelegate> delegate;
@end
