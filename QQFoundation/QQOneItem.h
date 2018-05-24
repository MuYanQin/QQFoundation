//
//  QQOneItem.h
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQTableViewItem.h"
#import "QQTableViewCell.h"

@interface QQOneItem : QQTableViewItem
@property (nonatomic, assign)NSInteger mark;
@end

@interface QQOneCell : QQTableViewCell
@property (nonatomic, strong) QQOneItem *item;
@end
