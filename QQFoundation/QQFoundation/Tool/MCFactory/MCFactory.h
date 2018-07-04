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

UIView * getView(UIColor *Bgcolor,CGRect frame);

CALayer * getLayer(UIColor *bgcolor,UIImage *image,CGRect frame);

UILabel * getLabel(UIFont *font,NSString *text,UIColor *textColor,textAlignment alignment,CGRect frame);

@end
