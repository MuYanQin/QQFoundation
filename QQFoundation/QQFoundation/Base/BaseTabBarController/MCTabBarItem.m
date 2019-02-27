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
#define btnWidth self.bounds.size.width
static const CGFloat imageHeight = 24;
static const CGFloat imageWidth = imageHeight*1.14;
@interface MCTabBarItem()
@property (nonatomic,strong) UILabel *BadgeLb;

@end
@implementation MCTabBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        
    }
    return self;
}

/**
 重绘图片 文字的大小距离
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    CGFloat imageX = (btnWidth - imageWidth) * 0.5;
    self.imageView.frame = CGRectMake(imageX, 6, imageWidth, imageHeight);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, self.imageView.bottom +8, btnWidth, 14);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}
- (void)setBadge:(NSInteger)Badge
{
    _Badge = Badge;
    if(Badge < 0){
        self.BadgeLb.hidden = YES;
        return;
    }
    NSString *badge = [NSString string];
    if (Badge > 999) {
        badge = @"999+";
    }else{
        badge = [NSString stringWithFormat:@"%lu",(long)Badge];
    }
    self.BadgeLb.text = badge;
    [self.BadgeLb sizeToFit];
    if (Badge == 0) {
        self.BadgeLb.text = @"";
        self.BadgeLb.frame = CGRectMake(self.imageView.frame.origin.x + 24, 5, 10, 10);
    }else{
        self.BadgeLb.frame = CGRectMake(self.imageView.frame.origin.x + 24, 5, self.BadgeLb.frame.size.width + 5, 15);
    }
    
    self.BadgeLb.layer.cornerRadius = self.BadgeLb.frame.size.height/2;
    self.BadgeLb.layer.masksToBounds = YES;
    [self addSubview:self.BadgeLb];
    
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

- (void)setBadgeBackColor:(UIColor *)BadgeBackColor
{
    _BadgeBackColor = BadgeBackColor;
    self.BadgeLb.backgroundColor = BadgeBackColor;
}
- (void)setBadgeTextColor:(UIColor *)BadgeTextColor
{
    _BadgeTextColor = BadgeTextColor;
    self.BadgeLb.textColor = BadgeTextColor;
}
- (UILabel *)BadgeLb
{
    if (!_BadgeLb) {
        _BadgeLb = [[UILabel alloc]init];
        _BadgeLb.textColor = [UIColor whiteColor];
        _BadgeLb.backgroundColor = [UIColor redColor];
        _BadgeLb.font = [UIFont systemFontOfSize:10];
        _BadgeLb.textAlignment = NSTextAlignmentCenter;
    }
    return _BadgeLb;
}
@end
