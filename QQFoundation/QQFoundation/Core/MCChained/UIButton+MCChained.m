//
//  UIButton+MCChained.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/26.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "UIButton+MCChained.h"


@implementation UIButton (MCChained)

-(UIButton *(^)(id))QInfo
{
    return ^UIButton *(id info){
        return self;
    };
}
- (UIButton *(^)(CGSize))QimageSize
{
    return ^UIButton *(CGSize size){
        return self;
    };
}
- (UIButton *(^)(QTextPosition))QtextPosition
{
    return ^UIButton *(QTextPosition Position){
        return self;
    };
}
- (UIButton *(^)(NSString *))Qtext
{
    return ^UIButton *(NSString * input){
        [self setTitle:input forState:UIControlStateNormal];
        return self;
    };
    
}
- (UIButton *(^)(NSString *, UIControlState))QtextState
{
    return ^UIButton *(NSString * input,UIControlState state){
        [self setTitle:input forState:state];
        return self;
    };
}

- (UIButton *(^)(UIColor *))QtextClolor
{
    return ^UIButton *(UIColor *color){
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(UIColor *, UIControlState))QtextClolorState
{
    return ^UIButton *(UIColor *color,UIControlState state){
        [self setTitleColor:color forState:state];
        return self;
    };
}
- (UIButton *(^)(UIColor *))QbgClolor
{
    return ^UIButton *(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}
- (UIButton *(^)(NSInteger, QFont))QfontWeight
{
    return ^UIButton *(NSInteger size,QFont font){
        UIFontWeight weight = UIFontWeightRegular;
        switch (font) {
            case QR:
            {
                weight = UIFontWeightRegular;
                break;
            }
            case QL:
            {
                weight = UIFontWeightLight;
                break;
            }
            case QM:
            {
                weight = UIFontWeightMedium;
                break;
            }
            case QB:
            {
                weight = UIFontWeightBold;
                break;
            }
            case QH:
            {
                weight = UIFontWeightHeavy;
                break;
            }
            default:
                break;
        }
    
        self.titleLabel.font = [UIFont systemFontOfSize:size weight:weight];
        return self;
    };
}
- (UIButton *(^)(NSInteger))Qfont
{
    return ^UIButton *(NSInteger size){
        self.titleLabel.font = [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
        return self;
    };
}

- (UIButton *(^)(UIImage *, UIControlState))QimageState
{
     return ^UIButton *(UIImage *image,UIControlState state){
         [self setImage:image forState:state];
         return self;
     };
}
- (UIButton *(^)(UIImage *))Qimage
{
    return ^UIButton *(UIImage *image){
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(UIImage *, UIControlState))QbgImageState

{
    return ^UIButton *(UIImage *image,UIControlState state){
        [self setBackgroundImage:image forState:state];
        return self;
    };
}
- (UIButton *(^)(UIImage *))QbgImage
{
    return ^UIButton *(UIImage *image){
        [self setBackgroundImage:image forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(CGRect))Qframe
{
    return ^UIButton *(CGRect frame){
        self.frame = frame;
        return self;
    };
}
- (UIButton *(^)(CGFloat))QcornerRadius
{
    return ^UIButton *(CGFloat Radius){
        self.layer.cornerRadius = Radius;
        return self;
    };
}
- (UIButton *(^)(UIColor *))QborderColor
{
    return ^UIButton *(UIColor *Color){
        self.layer.borderColor = Color.CGColor;
        return self;
    };
}
- (UIButton *(^)(CGFloat))QborderWidth
{
    return ^UIButton *(CGFloat Width){
        self.layer.borderWidth = Width;
        return self;
    };
}
- (UIButton *(^)(BOOL))QmasksToBounds
{
    return ^UIButton *(BOOL isMasks){
        self.layer.masksToBounds = isMasks;
        return self;
    };
}
- (UIButton *(^)(id, SEL))Qtarget
{
    return ^UIButton *(id target,SEL action){
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}
- (UIButton *(^)(id, SEL, UIControlEvents))QtargetEvent
{
    return ^UIButton *(id target,SEL action,UIControlEvents event){
        [self addTarget:target action:action forControlEvents:event];
        return self;
    };
}

- (UIButton *(^)(NSInteger))Qtag
{
    return ^UIButton *(NSInteger tag){
        self.tag = tag;
        return self;
    };
}
- (UIButton *(^)(BOOL))Qhidden
{
    return ^UIButton *(BOOL hidden){
        self.hidden = hidden;
        return self;
    };
    
}

+ (UIButton *)getButton
{
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}
@end
