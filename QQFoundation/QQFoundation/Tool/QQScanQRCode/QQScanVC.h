//
//  QQScanVC.h
//  QQFoundation
//
//  Created by ZhangQun on 2017/8/26.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "QQBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
@class QQScanVC;
@protocol QQScanVCDelegate <NSObject>

- (void)QQScanVC:(QQScanVC *)QQScanVC didScanResult:(id)info;
@end
@interface QQScanVC : QQBaseViewController<UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,assign) id <QQScanVCDelegate> delegate;
@end
