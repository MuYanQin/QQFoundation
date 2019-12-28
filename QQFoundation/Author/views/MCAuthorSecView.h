//
//  MCAuthorSecView.h
//  QQFoundation
//
//  Created by leaduMac on 2019/12/28.
//  Copyright © 2019 慕纯. All rights reserved.
//

#import "QQTableViewSecView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MCAuthorSecItem : QQTableViewSecItem
@property (nonatomic , copy) NSString * text;
@end

@interface MCAuthorSecView : QQTableViewSecView
@property (nonatomic , strong) MCAuthorSecItem *item;
@property (nonatomic , strong) UILabel *contLabel;
@end

NS_ASSUME_NONNULL_END
