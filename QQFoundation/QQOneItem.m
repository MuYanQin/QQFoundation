//
//  QQOneItem.m
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQOneItem.h"

@implementation QQOneItem
- (id)init
{
    if (self = [super init]) {
        self.CellHeight = 100;
    }
    return self;
}
@end
@implementation QQOneCell
- (void)cellDidLoad
{
    [super cellDidLoad];
//    self.contentView.backgroundColor = [UIColor redColor];

}
@end
