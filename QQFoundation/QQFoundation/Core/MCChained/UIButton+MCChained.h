//
//  UIButton+MCChained.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/26.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCChainedEnums.h"

@interface UIButton (MCChained)
/**
    下属性是给子类QQButton使用。用来做图片位置 否则使用无效。设置图片的大小
 */
@property (nonatomic , assign , readonly) UIButton *(^QimageSize)(CGSize imageSize);
/**
    下属性是给子类QQButton使用。用来做图片位置 否则使用无效。 设置文字的文字
 */
@property (nonatomic , assign , readonly) UIButton *(^QtextPosition)(QTextPosition position);

/**
    下属性是给子类QQButton使用。用来携带信息 否则使用无效
 */
@property (nonatomic , strong , readonly) UIButton *(^QInfo)(id Info);//携带信息

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^Qtext)(NSString *titleText);

/**
 设置title 设置类型
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtextState)(NSString *titleText,UIControlState);

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtextClolor)(UIColor *color);

/**
 设置titleColor 设置类型
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtextClolorState)(UIColor *color,UIControlState);

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^Qimage)(UIImage *image);

/**
 设置image 设置类型
 */
@property (nonatomic , strong ,readonly) UIButton *(^QimageState)(UIImage *image,UIControlState);

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^QbgImage)(UIImage *image);

/**
 设置backgroudImage 设置类型
 */
@property (nonatomic , strong ,readonly) UIButton *(^QbgImageState)(UIImage *image,UIControlState);


/**
 设置背景颜色
 */
@property (nonatomic , strong ,readonly) UIButton *(^QbgClolor)(UIColor *color);

/**
 设置title字体 可选weight
 */
@property (nonatomic , strong ,readonly) UIButton *(^QfontWeight)(NSInteger size,QFont font);

/**
 设置title字体 默认 regular
 */
@property (nonatomic , strong ,readonly) UIButton *(^Qfont)(NSInteger size);


/**
 button的Frame
 */
@property (nonatomic , strong ,readonly) UIButton *(^Qframe)(CGRect frame);

/**
 button 的圆角
 */
@property (nonatomic , strong ,readonly) UIButton *(^QcornerRadius)(CGFloat Radius);

/**
 描边宽度
 */
@property (nonatomic , strong ,readonly) UIButton *(^QborderWidth)(CGFloat Width);

/**
 描边的颜色
 */
@property (nonatomic , strong ,readonly) UIButton *(^QborderColor)(UIColor *color);

/**
 是否剪切
 */
@property (nonatomic , strong ,readonly) UIButton *(^QmasksToBounds)(BOOL);

/**
 默认touchUpinside
 */
@property (nonatomic , strong ,readonly) UIButton *(^Qtarget)(id target,SEL action);


/**
 设置按钮触发事件
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtargetEvent)(id target,SEL action,UIControlEvents Event);

/**
 设置tag
 */
@property (nonatomic, readonly) UIButton *(^Qtag)(NSInteger tag);


/**
 设置显示隐藏
 */
@property (nonatomic, readonly) UIButton *(^Qhidden)(BOOL hidden);

+ (UIButton *)getButton;

@end
