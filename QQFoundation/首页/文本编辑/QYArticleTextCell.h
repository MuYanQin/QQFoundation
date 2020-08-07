//
//  QYArticleTextCell.h
//  QQFoundation
//
//  Created by leaduMac on 2020/8/7.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "QQTableViewCell.h"
#import "QQTextView.h"
#import "QYArticleAccessoryView.h"
#import "QYEmptyCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYArticleTextItem : QQTableViewItem
@property (nonatomic , copy) NSString * text;
@property (nonatomic , copy) void(^selectImgBlock)(void);
@property (nonatomic , copy) void(^addTextItemBlock)(void);

@end

@interface QYArticleTextCell : QQTableViewCell<UITextViewDelegate>
@property (nonatomic , strong) QYArticleTextItem *item;
@property (nonatomic , strong) QQTextView *textView;
@property (nonatomic , strong) QYArticleAccessoryView *accessorV;
@end

NS_ASSUME_NONNULL_END
