//
//  MCDetectionView.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/3.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <UIKit/UIKit.h>
//与QQBaseURL文件下获取NSUserDefaults的key保持一致
static NSString *const urlKey = @"urlKey";
@interface MCDetectionView : UIView
@property (nonatomic , strong) NSArray * Domains;
@end
