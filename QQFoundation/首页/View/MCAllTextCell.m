//
//  MCAllTextCell.m
//  QQFoundation
//
//  Created by leaduadmin on 2019/4/15.
//  Copyright © 2019 慕纯. All rights reserved.
//

#import "MCAllTextCell.h"
#import <Masonry.h>
@implementation MCAllTextItem
- (instancetype)init
{
    if (self =[super init]) {

    }
    return self;
}
@end
@implementation MCAllTextCell
@synthesize item = _item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.textLb = [[UILabel alloc]init];
    self.textLb.numberOfLines = 0;
    [self.contentView addSubview:self.textLb];
    
    [self.textLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.bottom.right.equalTo(self).offset(-10);
    }];
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    self.textLb.font = self.item.font;
    self.textLb.text = self.item.text;
}

/**
 重写父类的方法 返回cell的高度

 @return 高度
 */
- (CGFloat)autoCellHeight
{
    CGFloat height = 0;
    height = height + [self.textLb sizeThatFits:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-20, 0)].height;
    height +=20;
    return  height;
}
@end
