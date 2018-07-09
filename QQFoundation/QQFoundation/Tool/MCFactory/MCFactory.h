//
//  MCFactory.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/4.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,textAlignment){
    left = 0,
    center,
    right
};
@interface MCFactory : NSObject

UIColor * getColor(CGFloat red,CGFloat gree, CGFloat blue);

UIColor * getColorWithAlpha(CGFloat red,CGFloat gree, CGFloat blue,CGFloat alpha);

UIColor * getColorWithHex(NSString *hex);

UIImage * getColorImage(UIColor *color);

//获取字体
UIFont *getThin(NSInteger font);

UIFont *getLight(NSInteger font);

UIFont * getRegular(NSInteger font);

UIFont *getMedium(NSInteger font);

UIFont *getBold(NSInteger font);

//获取UI控件
UIView * getView(UIColor *Bgcolor,CGRect frame);

CALayer * getLayer(UIColor *bgcolor,UIImage *image,CGRect frame);

UILabel * getLabel(UIFont *font,NSString *text,UIColor *textColor,textAlignment alignment,CGRect frame);

@end
