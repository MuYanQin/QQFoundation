//
//  QYArticleImgCell.h
//  QQFoundation
//
//  Created by leaduMac on 2020/8/7.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import "QQTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYArticleImgItem : QQTableViewItem
@property (nonatomic , strong) UIImage *image;
@end

@interface QYArticleImgCell : QQTableViewCell
@property (nonatomic , strong) QYArticleImgItem *item;
@property (nonatomic , strong) UIImageView *imgView;
@end

NS_ASSUME_NONNULL_END
