//
//  UILabel+MCChained.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/25.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "UILabel+MCChained.h"
typedef UILabel * (^Label)(id input);

@implementation UILabel (MCChained)
@dynamic Qtext,QtextColor,Qfont;

+ (UILabel *)getLabel
{
    return [[UILabel alloc]init];
}
- (UILabel *(^)(UIColor *))QtextColor
{
    return ^UILabel *(id input){
        self.textColor = input;
        return self;
    };
}
- (UILabel *(^)(UIFont *font))Qfont
{
    return ^UILabel *(id input){
        self.font = input;
        return self;
    };
}
- (UILabel *(^)(NSString *))Qtext
{
    return ^UILabel *(id input){
        self.text = input;
        return self;
    };
}
- (UILabel *(^)(CGRect frame))Qframe
{
    return ^UILabel *(CGRect input){
        self.frame = input;
        return self;
    };
}
- (UILabel *(^)(NSMutableAttributedString *QattributedText))QattributedText
{
    return ^UILabel *(id input){
        self.attributedText = input;
        return self;
    };
}
- (UILabel *(^)(NSInteger QnumberOfLines))QnumberOfLines
{
    return ^UILabel *(NSInteger input){
        self.numberOfLines = input;
        return self;
    };
}
- (UILabel *(^)(NSInteger))Qtag
{
    return ^UILabel *(NSInteger tag){
        self.tag = tag;
        return self;
    };
}
- (UILabel *(^)(QtextAlignment))Qalignment
{
    return ^UILabel *(QtextAlignment Alignment){
        self.textAlignment  = (int)Alignment;
        return self;
    };
}
-(UILabel *(^)(BOOL))Qhidden
{
    return ^UILabel *(BOOL hidden){
        self.hidden  = hidden;
        return self;
    };
}
@end
