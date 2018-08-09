//
//  QQTextField.h
//  sound
//
//  Created by tlt on 16/10/10.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQTextField : UITextField <UITextFieldDelegate>

/**
 最大限制文本长度, 默认为无穷大(即不限制).
 */
@property (nonatomic, assign)  NSUInteger maxLength;

/**
 是否开启价格输入的检查 默认不开启
 只能输入数字 且只有一个点(.)保留俩位小数
 */
@property (nonatomic , assign) BOOL  openPriceCheck;
@end
