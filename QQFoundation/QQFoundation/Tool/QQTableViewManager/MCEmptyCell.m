//
//  MCEmptyCell.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/25.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCEmptyCell.h"
@implementation MCEmptyItem
- (instancetype)initWithHeight:(CGFloat)height{
    if (self = [super init]) {
        self.CellHeight = height;
        self.hasLine = NO;
    }
    return self;
}
@end
@implementation MCEmptyCell
{
    UIView *_line;
}
@synthesize item = _item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    _line = [[UIView alloc]init];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_line];
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    _line.frame =CGRectMake(self.item.leftMargin, self.item.CellHeight - 1, [UIScreen mainScreen].bounds.size.width -  self.item.leftMargin - self.item.rightMargin, 0.5);
    _line.hidden = !self.item.hasLine;
    _line.backgroundColor = self.item.lineColor;
}
@end
