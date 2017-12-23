//
//  TabarItem.m
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/20.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "TabarItem.h"
#import "NSString+QQCalculate.h"
#define btnWidth self.bounds.size.width

@interface TabarItem()
@property (nonatomic,strong) UILabel *BadgeLb;

@end

@implementation TabarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    CGFloat imageX = (btnWidth - 24) * 0.5;
    self.imageView.frame = CGRectMake(imageX, 6, 24, 24);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, 30, 50, 14);
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