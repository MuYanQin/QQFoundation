//
//  UILabel+MCChained.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/25.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MCChained)
@property (nonatomic, readonly) UILabel *(^Qfont)(UIFont *font);
@property (nonatomic, readonly) UILabel *(^QtextColor)(UIColor *color);
@property (nonatomic, readonly) UILabel *(^Qtext)(NSString *text);
@property (nonatomic , strong ,readonly) UILabel *(^Qframe)(CGRect frame);
@property (nonatomic, readonly) UILabel *(^QattributedText)(NSMutableAttributedString *text);
@property (nonatomic, readonly) UILabel *(^QnumberOfLines)(NSInteger num);

+ (UILabel *)getLabel;
@end
