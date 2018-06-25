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
@property (nonatomic , copy) NSString * imageString;
@property (nonatomic , copy) NSString * leftString;
@end

@interface QQOneCell : QQTableViewCell
@property (nonatomic, strong) QQOneItem *item;
@property (nonatomic , strong) UIImageView *IconImageView;
@property (nonatomic , strong) UILabel * leftLb;
@end
