//
//  MCEmptyCell.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/25.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "QQTableViewCell.h"

@interface MCEmptyItem : QQTableViewItem
- (instancetype)initWithHeight:(CGFloat)height;
@end
@interface MCEmptyCell : QQTableViewCell
@property (nonatomic , strong) MCEmptyItem * item;
@end
