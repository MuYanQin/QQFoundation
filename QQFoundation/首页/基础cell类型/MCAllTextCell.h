//
//  MCAllTextCell.h
//  QQFoundation
//
//  Created by leaduadmin on 2019/4/15.
//  Copyright © 2019 Yuan er. All rights reserved.
//

#import "QQTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface MCAllTextItem : QQTableViewItem
@property (nonatomic , copy) NSString * text;
@property (nonatomic , strong) UIFont *font;
@end

@interface MCAllTextCell : QQTableViewCell
@property (nonatomic , strong) MCAllTextItem *item;
@property (nonatomic , strong) UILabel *textLb;

@end

NS_ASSUME_NONNULL_END
