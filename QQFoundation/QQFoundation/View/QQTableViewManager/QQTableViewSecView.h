//
//  QQTableViewSecView.h
//  QQFoundation
//
//  Created by leaduMac on 2019/12/28.
//  Copyright © 2019 Yuan er. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQTableViewSecItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface QQTableViewSecView : UITableViewHeaderFooterView
@property (nonatomic , strong) QQTableViewSecItem *item;

- (void)secViewDidLoad;

- (void)secViewWillAppear;

- (void)secViewDidDisappear;
@end

NS_ASSUME_NONNULL_END
