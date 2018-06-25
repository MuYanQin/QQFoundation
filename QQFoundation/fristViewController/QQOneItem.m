//
//  QQOneItem.m
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQOneItem.h"
#import "QQTool.h"
@implementation QQOneItem
- (instancetype)init
{
    if (self = [super init]) {
        self.CellHeight = 70;//这里是默认赋值高度 一般就是写死 当外面赋值高度的时候这里会被覆盖
    }
    return self;
}
@end
@implementation QQOneCell

@synthesize item = _item;

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.IconImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.IconImageView];
    self.leftLb = [[UILabel alloc]init];
    self.leftLb.textAlignment = NSTextAlignmentLeft;
    self.leftLb.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [self.contentView addSubview:self.leftLb];
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    //在这里写赋值 切记不能再cellDidLoad赋值
    self.leftLb.text = [QQTool strRelay:self.item.leftString];
    self.IconImageView.image = [UIImage imageNamed:self.item.imageString];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //这里布局。在cellDidLoad也可以做布局  用自动布局好点 我这是手撸了
    self.IconImageView.frame = CGRectMake(10, 15, 40, 40);
    self.leftLb.frame = CGRectMake(60, 25, 70, 20);
    
}
@end
