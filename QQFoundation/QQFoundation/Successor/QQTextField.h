//
//  QQTextField.h
//  sound
//
//  Created by tlt on 16/10/10.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQTextField : UITextField

@property (nonatomic, assign)  NSUInteger maxLength; /// 最大限制文本长度, 默认为无穷大(即不限制).

@end
