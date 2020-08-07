//
//  QYArticleAccessoryView.h
//  QQFoundation
//
//  Created by leaduMac on 2020/8/7.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYArticleAccessoryView : UIView
@property (nonatomic , copy) void(^clickIndex)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
