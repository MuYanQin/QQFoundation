//
//  QQPlusImageView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/7.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQPlusImageView.h"

@implementation QQPlusImageView

// 在view中重写以下方法，其中self.button就是那个希望被触发点击事件的按钮
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        // 转换坐标系
        return self;
    }
    return view;
}

@end
