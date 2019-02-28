//
//  MCLableCell.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCLableCell.h"
#import "UILabel+MCChained.h"
@implementation MCLableItem
- (instancetype)init
{
    if (self = [super init]) {
        self.CellHeight = 50;
    }
    return self;
}

@end

@implementation MCLableCell
@synthesize item = _item;

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.leftLb = [UILabel getLabel]
    .Qfont(15)
    .QtextColor(getColorWithHex(@"2c2c2c"))
    .Qalignment(Qleft);
    [self.leftLb sizeToFit];
    [self.contentView addSubview:self.leftLb];
    
    self.rightLb = [UILabel getLabel]
    .Qfont(15)
    .QtextColor(getColorWithHex(@"2c2c2c"))
    .Qalignment(Qleft);
    [self.rightLb sizeToFit];
    [self.contentView addSubview:self.rightLb];
    
    UIView *line = getView(getColorWithHex(@"f8f8f8"));
    [self.contentView addSubview:line];
    
    [self.leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-35);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.left.equalTo(self).offset(5);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self);
    }];
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    self.leftLb.text = self.item.leftText;
    self.rightLb.text = self.item.rightText;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
