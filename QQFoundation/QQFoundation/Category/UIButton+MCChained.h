//
//  UIButton+MCChained.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/26.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,QTextPosition){
    Tright  = 0,// 文字文字在右
    Tleft   = 1,//文字在左
    Ttop    = 2,// 文字在上
    Tbottom = 3 // 文字在下
};
@interface UIButton (MCChained)
@property (nonatomic , assign , readonly) UIButton *(^QimageSize)(CGSize imageSize);
@property (nonatomic , assign , readonly) UIButton *(^QtextPosition)(QTextPosition position);
@property (nonatomic , strong , readonly) UIButton *(^QInfo)(id Info);//携带信息

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtitleText)(NSString *titleText);
@property (nonatomic , strong ,readonly) UIButton *(^QtitleTextState)(NSString *titleText,UIControlState);

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtitleClolor)(UIColor *color);
@property (nonatomic , strong ,readonly) UIButton *(^QtitleClolorState)(UIColor *color,UIControlState);

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^Qimage)(UIImage *image);
@property (nonatomic , strong ,readonly) UIButton *(^QimageState)(UIImage *image,UIControlState);

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^QbackgroudImage)(UIImage *image);
@property (nonatomic , strong ,readonly) UIButton *(^QbackgroudImageState)(UIImage *image,UIControlState);


@property (nonatomic , strong ,readonly) UIButton *(^QbackgroudClolor)(UIColor *color);
@property (nonatomic , strong ,readonly) UIButton *(^QtitleFont)(UIFont *font);
@property (nonatomic , strong ,readonly) UIButton *(^Qframe)(CGRect frame);
@property (nonatomic , strong ,readonly) UIButton *(^QcornerRadius)(CGFloat Radius);
@property (nonatomic , strong ,readonly) UIButton *(^QborderWidth)(CGFloat Width);
@property (nonatomic , strong ,readonly) UIButton *(^QborderColor)(UIColor *color);
@property (nonatomic , strong ,readonly) UIButton *(^QmasksToBounds)(BOOL);
/**
 m默认都touchUpinside
 */
@property (nonatomic , strong ,readonly) UIButton *(^Qtarget)(id target,SEL action);

@property (nonatomic, readonly) UIButton *(^Qtag)(NSInteger tag);
@property (nonatomic, readonly) UIButton *(^Qhidden)(BOOL hidden);
@end
