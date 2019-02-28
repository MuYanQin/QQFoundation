//
//  MCSearchCleanCell.h
//  handRent
//
//  Created by qinmuqiao on 2019/1/2.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "QQTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCSearchCleanItem : QQTableViewItem
@property (nonatomic , copy) NSString * text;
@property (nonatomic , copy) void(^clean)(void);
@end

@interface MCSearchCleanCell : QQTableViewCell
@property (nonatomic , strong) MCSearchCleanItem * item;
@property (nonatomic , strong) QQButton * del;
@end

NS_ASSUME_NONNULL_END
