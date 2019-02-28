//
//  UIView+MCPopView.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/21.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>
//显示动画
typedef NS_ENUM(NSInteger,viewShowType) {
    viewShowTypeFadeIn = 0,//浅入
    viewShowTypeGrowIn,//放大进入
    viewShowTypeShrinkIn,//缩小进入
    viewShowTypeSlideInFromTop,
    viewShowTypeSlideInFromBottom,
    viewShowTypeBounceIn,//类似放大进入 后面有弹黄效果
    viewShowTypeBounceInFromTop,
    viewShowTypeBounceInFromBottom,
};
//隐藏动画
typedef NS_ENUM(NSInteger,viewDissType) {
    viewDissTypeFadeOut = 0,//浅出
    viewDissTypeGrowOut,//放大出
    viewDissTypeShrinkOut,//缩小出
    viewDissTypeSlideOutFromTop,
    viewDissTypeSlideOutFromBottom,
    viewDissTypeBounceOut,//类似缩小出 开始有放大效果
    viewDissTypeBounceOutFromTop,
    viewDissTypeBounceOutFromBottom,
};
//显示位置
typedef NS_ENUM(NSInteger,viewPositionType) {
    viewPositionTypeCenter = 0,
    viewPositionTypeBottom    ,
};
@interface UIView (MCPopView)

/**
 快捷弹出图层。依赖于KLCPopUp

 @param containView 需要弹出的图层
 @param showType 显示的类型
 @param dissType 隐藏的类型
 @param positionType 显示的位置
 @param shouldDismissOnBackgroundTouch 是否允许点击背景隐藏
 */
- (void)         showType:(viewShowType)showType
                 dissType:(viewDissType)dissType
             positionType:(viewPositionType)positionType
 dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;

- (void)dismissView;
@end
