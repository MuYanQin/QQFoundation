//
//  QYEmptyCell.m
//  QQFoundation
//
//  Created by leaduMac on 2020/8/5.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "QYEmptyCell.h"
@implementation QYEmptyItem
- (instancetype)initWithHeight:(CGFloat)height{
    if (self = [super init]) {
        self.cellHeight = height;
    }
    return self;
}
- (instancetype)initWithHeight:(CGFloat)height bgColor:(nonnull UIColor *)color{
    if (self = [super init]) {
        self.cellHeight = height;
        self.bgColor = color;
    }
    return self;
}
@end
@implementation QYEmptyCell

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
