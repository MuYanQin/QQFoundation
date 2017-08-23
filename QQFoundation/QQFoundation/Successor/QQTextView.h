//
//  QQTextView.h
//  Teacher
//
//  Created by tlt on 16/11/4.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQTextView : UITextView
/// 最大限制文本长度, 默认为无穷大(即不限制).

@property (nonatomic, assign)  NSUInteger maxLength;

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
