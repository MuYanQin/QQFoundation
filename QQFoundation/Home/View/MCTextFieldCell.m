//
//  MCTextFeildCell.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCTextFieldCell.h"
@implementation MCTextFieldItem
- (instancetype)init
{
    if (self = [super init]) {
        self.CellHeight = 50;
    }
    return self;
}
@end
@implementation MCTextFieldCell
@synthesize item = _item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.LeftLb = getLabel(getFontRegular(15), @"", getColorWithHex(@"2c2c2c"), left);
    [self.LeftLb sizeToFit];
    [self.contentView addSubview:self.LeftLb];
    
    self.TextField = getTextField(getFontRegular(15), getColorWithHex(@"2c2c2c"), right);
    self.TextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.TextField.maxLength = 8;
    self.TextField.openPriceCheck = YES;
    [self.contentView addSubview:self.TextField];
    
    [self.LeftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];

    [self.TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.left.equalTo(self.LeftLb.mas_right).offset(5);
        make.centerY.equalTo(self.mas_centerY);
        make.top.bottom.equalTo(self);
    }];
    
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    self.LeftLb.text = self.item.leftText;
    self.TextField.text = self.item.rightText;
    self.TextField.placeholder = self.item.placeholderText;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
