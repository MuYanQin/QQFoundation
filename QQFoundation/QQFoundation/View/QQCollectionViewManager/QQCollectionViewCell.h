//
//  QQCollectionViewCell.h
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQCollectionViewItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface QQCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) QQCollectionViewItem *item;

- (void)cellWillAppear;
@end

NS_ASSUME_NONNULL_END
