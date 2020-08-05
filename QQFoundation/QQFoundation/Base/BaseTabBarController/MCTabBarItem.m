//
//  MCTabBarItem.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/8.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "MCTabBarItem.h"
#import "UIView+QQFrame.h"
#import "QQTool.h"
#import "QYBadgeLabel.h"
#define btnWidth self.bounds.size.width

static const CGFloat imageHeight = 24;
static const CGFloat imageWidth = imageHeight*1.14;
@interface MCTabBarItem()
@property (nonatomic,strong) QYBadgeLabel *badgeLb;

@end
@implementation MCTabBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        _badge = -1;
    }
    return self;
}

/**
 重绘图片 文字的大小距离
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageX = (btnWidth - imageWidth) * 0.5;
    if (self.imgSize.width>0) {
        self.imageView.frame = CGRectMake(imageX, 5, self.imgSize.width, self.imgSize.height);
    }else{
        self.imageView.frame = CGRectMake(imageX, 5, imageWidth, imageHeight);
    }
    CGFloat margin = 0;
    if (self.margin>0) {
        margin = self.margin;
    }else{
        margin = 3;
    }
    self.titleLabel.frame = CGRectMake(0, self.imageView.bottom + margin, btnWidth, self.titleLabel.frame.size.height);
    [self caculate:_badge];
}
- (void)setBadge:(NSInteger)badge
{
    _badge = badge;
}
- (void)caculate:(NSInteger)count
{
    self.badgeLb.text = @(count).stringValue;

    CGFloat badgeLbx = self.imageView.frame.origin.x +  self.imageView.frame.size.width - self.badgeLb.frame.size.width/2;
    CGFloat badgeLby = self.imageView.frame.origin.y ;
    self.badgeLb.origin = CGPointMake(badgeLbx, badgeLby);
    [self addSubview:self.badgeLb];
    
}
/**
 CABasicAnimation * animation = [CABasicAnimation animation];
 animation.keyPath = @"transform.scale";//KVC的方式来访问属性
 animation.fromValue = @0.0;
 animation.toValue = @1.0;
 animation.duration = 0.15;//持续时间
 animation.repeatCount = 1;//无限循环
 animation.speed = 1;//速度
 //    animation.repeatDuration = 10;//在多久哪动画有效
 animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//结束函数
 animation.autoreverses= NO;//回归是否是动画形式
 [self.BackGroudImageview.layer addAnimation:animation forKey:@"frame"];//添加动画
 */

- (void)setBadgeBackColor:(UIColor *)badgeBackColor
{
    _badgeBackColor = badgeBackColor;
    self.badgeLb.backgroundColor = badgeBackColor;
}
- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    _badgeTextColor = badgeTextColor;
    self.badgeLb.textColor = badgeTextColor;
}
- (QYBadgeLabel *)badgeLb
{
    if (!_badgeLb) {
        _badgeLb = [[QYBadgeLabel alloc]init];
        _badgeLb.textColor = [UIColor whiteColor];
        _badgeLb.backgroundColor = [UIColor redColor];
        _badgeLb.font = [UIFont systemFontOfSize:10];
        _badgeLb.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLb;
}
@end
