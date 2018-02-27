//
//  QQAlertController.h
//  QQFoundation
//
//  Created by Maybe on 2018/1/23.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQAlertController : UIViewController
+ (instancetype)alertControllerWithTitle:(NSString *)title description:(NSString *)description cancel:(NSString *)cancel button:(NSString *)button action:(void (^)(NSInteger index))buttonAction;
@property (nonatomic,strong) UIView  *AlertView;
@property (nonatomic,assign) BOOL isTouchHidden;//默认NO
@end
