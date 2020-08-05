//
//  QYEmptyCell.h
//  QQFoundation
//
//  Created by leaduMac on 2020/8/5.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import "QQTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface QYEmptyItem : QQTableViewItem
- (instancetype)initWithHeight:(CGFloat)height;
- (instancetype)initWithHeight:(CGFloat)height bgColor:(UIColor *)color;
@end
@interface QYEmptyCell : QQTableViewCell
@property (nonatomic , strong) QYEmptyItem *item;
@end

NS_ASSUME_NONNULL_END
