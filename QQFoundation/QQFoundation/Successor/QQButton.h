//
//  QQButton.h
//  QQButtonManer
//
//  Created by 秦慕乔 on 16/3/13.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ButtonTextAlignment){
    // 图标和文本位置变化
    ButtonTextAlignmentRight  = 8,// 文字文字在左
    ButtonTextAlignmentLeft   = 1,//文字在右
    ButtonTextAlignmentTop    = 2,// 文字在上(居中)
    ButtonTextAlignmentBottom = 3, // 文字在下(居中)
};

@class QQButton;
typedef void(^myButtonBlock)(QQButton *myButton);
typedef void(^RegisterBlock)(QQButton *myButton);
@interface QQButton : UIButton
@property (nonatomic,assign)ButtonTextAlignment TextAlignment;//默认文字在右 ButtonTextAlignmentRight
@property (nonatomic,assign) CGRect imageRect;//图片相对于button的位置

@property (nonatomic, copy) id Info;//携带信息
/**
 快捷设置点击事件  只有文字

 @param frame frame
 @param title 文字
 @param Click 点击事件
 @return buttob
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title ClickBlock:(myButtonBlock)Click;

/**
 快捷设置点击事件 可单独设置status分配文字图片的位置
 @param frame frame
 @param title 文字
 @param image 图片名称
 @param Click 点击事件
 @return button
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image ClickBlock:(myButtonBlock)Click;

/**
 快捷设置点击事件 直接设置status 分配文字图片的位置
 
 @param frame frame
 @param title 文字
 @param image 图片名称
 @param Click 点击事件
 @return button
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image TextAlignment:(ButtonTextAlignment)TextAlignment ClickBlock:(myButtonBlock)Click;

/**
 注册用Button

 @param frame frame
 @param color 颜色
 @param Click 返回block
 @return button
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame color:(UIColor *)color ClickBlock:(RegisterBlock)Click;

@end
