//
//  QQTwoItem.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/5/25.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQTwoItem.h"

@implementation QQTwoItem

@end

@implementation QQTwoCell
- (void)cellDidLoad
{
    [super cellDidLoad];
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(40, 40, [UIScreen mainScreen].bounds.size.width, 20)];
    NSLog(@"%.2f",[UIScreen mainScreen].bounds.size.width);
    vv.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:vv];
}
@end
