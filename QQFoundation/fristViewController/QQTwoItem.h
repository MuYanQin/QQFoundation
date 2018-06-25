//
//  QQTwoItem.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/5/25.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQTableViewItem.h"
#import "QQTableViewCell.h"

@interface QQTwoItem : QQTableViewItem
@property (nonatomic , copy) NSString * leftSting;
@property (nonatomic , copy) NSString * rightSting;
@end

@interface QQTwoCell : QQTableViewCell
@property (nonatomic , strong) QQTwoItem * item;
@property (nonatomic , strong) UILabel * leftLb;
@property (nonatomic , strong) UILabel * rightLb;

@end
