//
//  MCFactory.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/4.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QQTextField.h"

@interface MCFactory : NSObject

UIColor * getColor(CGFloat red,CGFloat gree, CGFloat blue);

UIColor * getColorWithAlpha(CGFloat red,CGFloat gree, CGFloat blue,CGFloat alpha);

UIColor * getColorWithHex(NSString *hex);

UIImage * getColorImage(UIColor *color);

//获取字体
UIFont *getFontThin(NSInteger font);

UIFont *getFontLight(NSInteger font);

UIFont * getFontRegular(NSInteger font);

UIFont *getFontMedium(NSInteger font);

UIFont *getFontBold(NSInteger font);

//获取UI控件
UIView * getView(UIColor *Bgcolor);

@end
