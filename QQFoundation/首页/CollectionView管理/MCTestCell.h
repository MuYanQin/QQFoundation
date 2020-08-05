//
//  MCTestCell.h
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "QQCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface MCTestItem : QQCollectionViewItem

@end

@interface MCTestCell : QQCollectionViewCell
@property (nonatomic , strong) MCTestItem *item;
@end

NS_ASSUME_NONNULL_END
