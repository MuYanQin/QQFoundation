//
//  QQButton.h
//  QQButtonManer
//
//  Created by 秦慕乔 on 16/3/13.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef enum{
    // 正常
    FLAlignmentStatusNormal,
    // 图标和文本位置变化
    FLAlignmentStatusLeft,// 左对齐
    FLAlignmentStatusCenter,// 居中对齐
    FLAlignmentStatusRight,// 右对齐
    FLAlignmentStatusTop,// 图标在上，文本在下(居中)
    FLAlignmentStatusBottom, // 图标在下，文本在上(居中)
    FLAlignmentStatusMy,
}FLAlignmentStatus;

typedef void(^myButtonBlock)(UIButton *myButton);
typedef void(^RegisterBlock)(UIButton *myButton);

@interface QQButton : UIButton
@property (nonatomic,assign)FLAlignmentStatus status;
@property (assign, nonatomic) CGFloat buttonTopRadio;
@property (nonatomic, copy) id userInfo;//携带信息

/**
 快捷设置点击事件  只有文字

 @param frame frame
 @param title 文字
 @param block 点击事件
 @return buttob
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(myButtonBlock)block;

/**
 快捷设置点击事件 可单独设置status分配文字图片的位置

 @param frame frame
 @param title 文字
 @param image 图片名称
 @param block 点击事件
 @return button
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image andBlock:(myButtonBlock)block;
/**
 快捷设置点击事件 直接设置status 分配文字图片的位置
 
 @param frame frame
 @param title 文字
 @param image 图片名称
 @param block 点击事件
 @return button
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image status:(FLAlignmentStatus)status andBlock:(myButtonBlock)block;

/**
 注册用Button

 @param frame frame
 @param color 颜色
 @param block 返回block
 @return button
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame color:(UIColor *)color andBlock:(RegisterBlock)block;

+ (instancetype)fl_shareButton;
@end
