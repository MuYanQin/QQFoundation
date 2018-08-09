//
//  MCTextFeildCell.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "QQTableViewCell.h"
#import "MCTextFieldCell.h"
@interface MCTextFieldItem : QQTableViewItem
@property (nonatomic , copy) NSString * leftText;
@property (nonatomic , copy) NSString * rightText;
@property (nonatomic , copy) NSString * placeholderText;
@property (nonatomic , strong) QQTextField * TextF;
@end
@interface MCTextFieldCell : QQTableViewCell
@property (nonatomic , strong) MCTextFieldItem * item;
@property (nonatomic , strong) QQTextField * TextField;
@property (nonatomic , strong) UILabel * LeftLb;
@end
