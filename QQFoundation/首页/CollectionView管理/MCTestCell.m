//
//  MCTestCell.m
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "MCTestCell.h"
@implementation MCTestItem

@end

@implementation MCTestCell
@synthesize item = _item;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
@end
