//
//  QQDateFormatter.m
//  QQFoundation
//
//  Created by Maybe on 2018/3/27.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQDateFormatter.h"

@implementation QQDateFormatter
+ (instancetype)ShareIntance
{
    static dispatch_once_t onceToken;
    static QQDateFormatter *DateFormatter = nil;
    dispatch_once(&onceToken, ^{
        DateFormatter = [[QQDateFormatter alloc]init];
    });
    return DateFormatter;
}
- (instancetype)init
{
    if (self = [super init]) {
        self.DateCache = [[NSCache alloc]init];
        self.DateCache.countLimit = 5;
    }
    return self;
}
- (void)setCacheLimit:(NSUInteger)cacheLimit
{
    self.DateCache.countLimit = cacheLimit;
}
- (NSDateFormatter *)getDateFormatter:(NSString *)format
{
    NSDateFormatter *DateFormatter = [self.DateCache objectForKey:format];
    if (!DateFormatter) {
        DateFormatter = [[NSDateFormatter alloc]init];
        DateFormatter.dateFormat = format;
        [self.DateCache setObject:DateFormatter forKey:format];
    }
    return DateFormatter;
}
@end
