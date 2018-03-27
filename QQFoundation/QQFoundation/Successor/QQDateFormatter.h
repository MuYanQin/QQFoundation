//
//  QQDateFormatter.h
//  QQFoundation
//
//  Created by Maybe on 2018/3/27.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQDateFormatter : NSObject<NSCacheDelegate>
@property (nonatomic,strong) NSCache *DateCache;
@property (nonatomic, assign) NSUInteger cacheLimit;//default is 5

+ (instancetype)ShareIntance;
- (NSDateFormatter *)getDateFormatter:(NSString *)format;
@end
