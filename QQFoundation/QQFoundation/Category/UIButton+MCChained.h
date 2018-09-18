//
//  UIButton+MCChained.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/26.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,QTextPosition){
    Tnone   = 0,//
    Tright  = 1,// 文字文字在右
    Tleft   = 2,//文字在左
    Ttop    = 3,// 文字在上
    Tbottom = 4 // 文字在下
};
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
    下属性是给子类QQButton使用。用来携带信息 懒得用运行时了 否则使用无效
 */
@property (nonatomic , strong , readonly) UIButton *(^QInfo)(id Info);//携带信息

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtitleText)(NSString *titleText);

/**
 设置title 设置类型
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtitleTextState)(NSString *titleText,UIControlState);

/**
 默认 Normal
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtitleClolor)(UIColor *color);

/**
 设置titleColor 设置类型
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtitleClolorState)(UIColor *color,UIControlState);

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
@property (nonatomic , strong ,readonly) UIButton *(^QbackgroudImage)(UIImage *image);

/**
 设置backgroudImage 设置类型
 */
@property (nonatomic , strong ,readonly) UIButton *(^QbackgroudImageState)(UIImage *image,UIControlState);


/**
 设置背景颜色
 */
@property (nonatomic , strong ,readonly) UIButton *(^QbackgroudClolor)(UIColor *color);

/**
 设置title字体
 */
@property (nonatomic , strong ,readonly) UIButton *(^QtitleFont)(UIFont *font);

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
@end
