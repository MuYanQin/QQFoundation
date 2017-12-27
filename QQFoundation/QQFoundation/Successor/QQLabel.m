//
//  QQLabel.m
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "QQLabel.h"
#import "QQTool.h"
@implementation QQLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
    }
    return  self;
}

+ (instancetype)new
{
    return [[self alloc]initWithFrame:CGRectZero];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_action) {
        return;
    }
    [_target  performSelector:_action withObject:nil afterDelay:0];
}
- (void)addtarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}
@end
