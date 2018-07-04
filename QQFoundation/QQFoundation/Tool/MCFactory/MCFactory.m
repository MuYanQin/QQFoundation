//
//  MCFactory.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/4.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCFactory.h"

@implementation MCFactory
UIView * getView(UIColor *Bgcolor,CGRect frame){
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = Bgcolor;
    return view;
}

CALayer * getLayer(UIColor *bgcolor,UIImage *image,CGRect frame){
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = frame;
    layer.backgroundColor = bgcolor.CGColor;
    layer.contents = (id)image.CGImage;;
    return layer;
}

UILabel * getLabel(UIFont *font,NSString *text,UIColor *textColor,textAlignment alignment,CGRect frame){
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = font;
    label.text = text;
    label.textAlignment =(int)alignment;
    label.textColor = textColor;
    return label;
}

@end
