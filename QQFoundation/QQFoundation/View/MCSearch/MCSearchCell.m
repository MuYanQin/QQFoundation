//
//  MCSearchCell.m
//  handRent
//
//  Created by qinmuqiao on 2019/1/2.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "MCSearchCell.h"
#import "UILabel+MCChained.h"
@implementation MCSearchItem
- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}

@end

@implementation MCSearchCell

@synthesize item = _item;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.searchI = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HR_search_lay"]];
        [self.contentView addSubview:self.searchI];
        
        self.del = [QQButton buttonWithType:UIButtonTypeCustom];
        self.del.Qimage([UIImage imageNamed:@"MCClose"])
        .QimageSize(CGSizeMake(15, 15))
        .Qtarget(self, @selector(closeC));
        [self addSubview:self.del];
        
        self.contLb = [UILabel getLabel].QfontWeight(13,QM).QtextColor(getColorWithHex(@"2C2C2C"));
        [self.contentView addSubview:self.contLb];
        
        self.line = getView(getColorWithHex(@"EEEEEE"));
        [self.contentView addSubview:self.line];
        
        [self.searchI mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(13, 14));
        }];
        [self.del mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-16);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(13, 13));
        }];
        
        [self.contLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.searchI.mas_right).offset(10);
            make.centerY.equalTo(self);
            make.right.equalTo(self.del.mas_left).offset(-10);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}
- (void)closeC
{
    if (self.item.del) {
        self.item.del(self.item);
        
    }
    
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    self.contLb.text = self.item.text;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
