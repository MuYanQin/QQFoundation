//
//  MCSearchCleanCell.m
//  handRent
//
//  Created by qinmuqiao on 2019/1/2.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "MCSearchCleanCell.h"
@implementation MCSearchCleanItem
- (instancetype)init
{
    if (self = [super init]) {
        self.text = @"清空搜索历史";
    }
    return self;
}

@end

@implementation MCSearchCleanCell

@synthesize item = _item;

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.del = [QQButton buttonWithType:UIButtonTypeCustom];
    self.del.Qtarget(self, @selector(closeC))
    .QtextClolor(getColorWithHex(@"999999"))
    .QfontWeight(13, QM);
    [self addSubview:self.del];
    
    [self.del mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    self.del.Qtext(self.item.text);

}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)closeC
{
    if (self.item.clean) {
        self.item.clean();
    }
}
@end
