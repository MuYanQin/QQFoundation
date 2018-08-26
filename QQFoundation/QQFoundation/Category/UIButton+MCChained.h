//
//  UIButton+MCChained.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/26.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MCChained)
@property (nonatomic , strong ,readonly) UIButton *(^QtitleText)(NSString *titleText,UIControlState);
@property (nonatomic , strong ,readonly) UIButton *(^QtitleFont)(UIFont *font);
@property (nonatomic , strong ,readonly) UIButton *(^QtitleClolor)(UIColor *color,UIControlState);
@property (nonatomic , strong ,readonly) UIButton *(^QbackgroudClolor)(UIColor *color);
@property (nonatomic , strong ,readonly) UIButton *(^Qimage)(UIImage *image,UIControlState);
@property (nonatomic , strong ,readonly) UIButton *(^QbackgroudImage)(UIImage *image,UIControlState);
@property (nonatomic , strong ,readonly) UIButton *(^Qframe)(CGRect frame);
@property (nonatomic , strong ,readonly) UIButton *(^QcornerRadius)(CGFloat Radius);
@property (nonatomic , strong ,readonly) UIButton *(^QborderWidth)(CGFloat Width);
@property (nonatomic , strong ,readonly) UIButton *(^QborderColor)(UIColor *color);
@property (nonatomic , strong ,readonly) UIButton *(^QmasksToBounds)(BOOL);
/**
 m默认都touchUpinside
 */
@property (nonatomic , strong ,readonly) UIButton *(^Qtarget)(id target,SEL action);

@end
