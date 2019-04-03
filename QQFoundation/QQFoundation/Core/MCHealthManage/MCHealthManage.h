//
//  MCHealthManage.h
//  Doctor
//
//  Created by qinmuqiao on 2018/8/12.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MCHealthManage : NSObject
- (void)getStepAuthor:(void (^)(BOOL available))available;
- (void)getDistanceAuthor:(void (^)(BOOL available))available;
/**
 获取今天行走步数
 */
- (void)getTodayStep:(void(^)(NSInteger step))step;

/**
 获取今天行走和跑步的距离

 */
- (void)getTodayDictance:(void(^)(CGFloat distance))distance;

/**
 获取昨天行走的距离
 */
- (void)getYesterdayStep:(void(^)(NSInteger step))step;

/**
 获取昨天行走和跑步的距离
 */
- (void)getYesterdayDictance:(void(^)(CGFloat distance))distance;
@end
