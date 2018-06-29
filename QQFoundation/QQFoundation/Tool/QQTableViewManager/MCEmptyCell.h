//
//  MCEmptyCell.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/25.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "QQTableViewCell.h"

@interface MCEmptyItem : QQTableViewItem
- (instancetype)initWithHeight:(CGFloat)height;
@property (nonatomic , assign) BOOL  hasLine;
@property (nonatomic , assign) CGFloat  leftMargin;
@property (nonatomic , assign) CGFloat  rightMargin;
@property (nonatomic , strong) UIColor * lineColor;
@end
@interface MCEmptyCell : QQTableViewCell
@property (nonatomic , strong) MCEmptyItem * item;
@end