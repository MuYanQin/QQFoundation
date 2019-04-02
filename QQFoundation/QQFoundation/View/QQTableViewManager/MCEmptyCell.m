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
    }
    return self;
}
@end
@implementation MCEmptyCell

@synthesize item = _item;
- (void)cellDidLoad
{
    [super cellDidLoad];
}
- (void)cellWillAppear
{
    [super cellWillAppear];
}
@end
