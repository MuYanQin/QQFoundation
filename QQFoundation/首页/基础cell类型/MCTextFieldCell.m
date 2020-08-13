//
//  MCTextFeildCell.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "MCTextFieldCell.h"
#import "UILabel+MCChained.h"
#import "QQTextField.h"
@implementation MCTextFieldItem
- (instancetype)init
{
    if (self = [super init]) {
        self.cellHeight = 50;
    }
    return self;
}
@end
@implementation MCTextFieldCell
@synthesize item = _item;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.LeftLb = [UILabel new];
        self.LeftLb.Qfont(15).Qtext(@"").QtextColor(getColorWithHex(@"2c2c2c")).Qalignment(Qleft);
        [self.LeftLb sizeToFit];
        [self.contentView addSubview:self.LeftLb];
        
        self.TextField = [[QQTextField alloc]init];
        self.TextField.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightRegular)];
        self.TextField.textColor = getColorWithHex(@"2c2c2c");
        self.TextField.textAlignment  = NSTextAlignmentRight;
        self.TextField.keyboardType = UIKeyboardTypeDecimalPad;
        self.TextField.maxLength = 8;
        self.TextField.openPriceCheck = YES;
        [self.contentView addSubview:self.TextField];
        
        UIView *line = getView(getColorWithHex(@"f8f8f8"));
        [self.contentView addSubview:line];
        
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
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.left.equalTo(self).offset(5);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self);
        }];
    }
    return self;
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
