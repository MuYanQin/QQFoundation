//
//  MCAlertView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/25.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCAlertView.h"

@implementation MCAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    UIView *Contain = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    Contain.backgroundColor = [UIColor redColor];
    [self addSubview:Contain];
}
@end
