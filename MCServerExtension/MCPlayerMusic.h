//
//  MCPlayerMusic.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/7.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCPlayerMusic : NSObject
+ (instancetype)shareManager;
- (void)startPlayer;
- (void)stopPlayer;
@end
