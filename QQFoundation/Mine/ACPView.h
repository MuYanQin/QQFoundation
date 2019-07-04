//
//  ACPView.h
//  QQFoundation
//
//  Created by leaduMac on 2019/5/28.
//  Copyright © 2019 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACPView : UIView
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , assign) CGFloat  shuzhi;
@property (nonatomic , copy) NSString * proText;
@property (nonatomic , copy) NSString * rightText;
@end

NS_ASSUME_NONNULL_END
