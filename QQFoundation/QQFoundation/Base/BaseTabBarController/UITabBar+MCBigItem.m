//
//  UITabBar+MCBigItem.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/24.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "UITabBar+MCBigItem.h"
#import <objc/runtime.h>
static char const BIG;
@implementation UITabBar (MCBigItem)
- (void)setBigButton:(UIButton *)BigButton
{
    objc_setAssociatedObject(self, &BIG, BigButton, OBJC_ASSOCIATION_RETAIN);
}
- (UIButton *)BigButton
{
    return  objc_getAssociatedObject(self, &BIG);
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    
    //tabbar隐藏的时候 不走此方法
    if (view == nil && !self.hidden) {
        CGPoint newPoint = [self.BigButton convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(self.BigButton.bounds, newPoint)) {
            view = self.BigButton;
        }
    }
    return view;
}
@end
