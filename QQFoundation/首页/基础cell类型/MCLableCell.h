//
//  MCLableCell.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "QQTableViewCell.h"
@interface MCLableItem : QQTableViewItem
@property (nonatomic , copy) NSString * leftText;
@property (nonatomic , copy) NSString * rightText;
@end

@interface MCLableCell : QQTableViewCell
@property (nonatomic , strong) MCLableItem * item;
@property (nonatomic , strong) UILabel * leftLb;
@property (nonatomic , strong) UILabel * rightLb;
@end
