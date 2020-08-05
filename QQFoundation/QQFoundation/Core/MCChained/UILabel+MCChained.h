//
//  UILabel+MCChained.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/25.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCChainedEnums.h"
@interface UILabel (MCChained)


/**
 字体 默认regular
 */
@property (nonatomic, readonly) UILabel *(^Qfont)(NSInteger size);

/**
 字体 可设置weight
 */
@property (nonatomic, readonly) UILabel *(^QfontWeight)(NSInteger size,QFont font);
/**
 字体颜色
 */
@property (nonatomic, readonly) UILabel *(^QtextColor)(UIColor *color);

/**
 背景颜色
 */
@property (nonatomic, readonly) UILabel *(^QbgColor)(UIColor *color);

/**
 文字
 */
@property (nonatomic, readonly) UILabel *(^Qtext)(NSString *text);

/**
 labelframe
 */
@property (nonatomic , strong ,readonly) UILabel *(^Qframe)(CGRect frame);

/**
 富文本text
 */
@property (nonatomic, readonly) UILabel *(^QattributedText)(NSMutableAttributedString *text);

/**
 行数
 */
@property (nonatomic, readonly) UILabel *(^QnumberOfLines)(NSInteger num);

/**
 标签
 */
@property (nonatomic, readonly) UILabel *(^Qtag)(NSInteger tag);

/**
 文字的位置
 */
@property (nonatomic, readonly) UILabel *(^Qalignment)(QtextAlignment Alignment);

/**
 是否隐藏
 */
@property (nonatomic, readonly) UILabel *(^Qhidden)(BOOL hidden);


/**
 label的点击事件
 */
@property (nonatomic, readonly) UILabel *(^Qclick)(id target,NSString *SelString);



@property (nonatomic , strong) NSArray * actionArray;

@property (nonatomic , copy) void (^tapClick) (NSString *string , NSRange range , NSInteger index);

+ (UILabel *)getLabel;

@end
