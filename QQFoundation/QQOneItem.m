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
    if (self.item.mark ==1) {
        self.contentView.backgroundColor = [UIColor yellowColor];
    }else{
        self.contentView.backgroundColor = [UIColor yellowColor];

    }

}
@end