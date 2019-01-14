//
//  MCSearchCell.h
//  handRent
//
//  Created by qinmuqiao on 2019/1/2.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "QQTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCSearchItem : QQTableViewItem
@property (nonatomic , copy) NSString * text;
@property (nonatomic , copy) void(^del)(MCSearchItem *tt);

@end

@interface MCSearchCell : QQTableViewCell
@property (nonatomic , strong) MCSearchItem * item;
@property (nonatomic , strong) UIImageView * searchI;
@property (nonatomic , strong) QQButton * del;
@property (nonatomic , strong) UILabel * contLb;
@property (nonatomic , strong) UIView * line;
@end

NS_ASSUME_NONNULL_END
