//
//  MCSearchViewController.h
//  handRent
//
//  Created by qinmuqiao on 2019/1/7.
//  Copyright © 2019年 MuYaQin. All rights reserved.
//

#import "QQBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@class MCSearchViewController;

@protocol MCSearchViewDelegate <NSObject>

- (void)MCSearchView:(MCSearchViewController *)MCSearchView searchText:(NSString *)text;

@end

@interface MCSearchViewController : QQBaseViewController
@property (nonatomic , assign) id  <MCSearchViewDelegate> deletegate;
@end

NS_ASSUME_NONNULL_END
