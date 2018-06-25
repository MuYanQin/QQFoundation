//
//  QQTwoItem.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/5/25.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQTwoItem.h"
#import "QQTool.h"
@implementation QQTwoItem
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
@end

@implementation QQTwoCell
@synthesize item = _item;

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.leftLb = [[UILabel alloc]init];
    
    self.leftLb.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.leftLb.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.leftLb];
    
    self.rightLb = [[UILabel alloc]init];
    self.rightLb.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.rightLb.textAlignment = NSTextAlignmentRight;
    self.rightLb.textColor = [UIColor lightTextColor];
    [self.contentView addSubview:self.rightLb];
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    self.leftLb.text = [QQTool strRelay:self.item.leftSting];
    self.rightLb.text = [QQTool strRelay:self.item.rightSting];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftLb.frame = CGRectMake(10, (self.item.CellHeight - 20)/2, 70, 20);
    self.rightLb.frame = CGRectMake(self.frame.size.width -  100, (self.item.CellHeight - 20)/2, 70, 20);

}
@end
