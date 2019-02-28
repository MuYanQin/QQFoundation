//
//  MCDownloadItem.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/12.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCDownloadItem.h"
#import <objc/runtime.h>
@implementation MCDownloadItem
#pragma mark - NSCoding
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:@(self.loadStatus) forKey:NSStringFromSelector(@selector(loadStatus))];
//    [aCoder encodeObject:self.downloadString forKey:NSStringFromSelector(@selector(downloadString))];
//    [aCoder encodeObject:self.savePath forKey:NSStringFromSelector(@selector(savePath))];
//    [aCoder encodeObject:self.resumeData forKey:NSStringFromSelector(@selector(resumeData))];
//
//
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    if (self) {
//        self.downloadString = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(downloadString))];
//        self.savePath = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(savePath))];
//        self.loadStatus = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(loadStatus))] unsignedIntegerValue];
//        self.resumeData = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(resumeData))];
//    }
//    return self;
//}
///  解档
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (NSInteger i=0; i<count; i++) {
            
            Ivar ivar = ivars[i];
            NSString *name = [[NSString alloc] initWithUTF8String:ivar_getName(ivar)];
            if ([name isEqualToString:@"_downloadTask"] || [name isEqualToString:@"_delegate"] || [name isEqualToString:@"_timer"]) continue;
            id value = [coder decodeObjectForKey:name];
            if(value) [self setValue:value forKey:name];
        }
        
        free(ivars);
    }
    return self;
}

///  归档
- (void)encodeWithCoder:(NSCoder *)coder
{
    
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (NSInteger i=0; i<count; i++) {
        
        Ivar ivar = ivars[i];
        NSString *name = [[NSString alloc] initWithUTF8String:ivar_getName(ivar)];
        if ([name isEqualToString:@"_downloadTask"] || [name isEqualToString:@"_delegate"] || [name isEqualToString:@"_timer"]) continue;
        id value = [self valueForKey:name];
        if(value) [coder encodeObject:value forKey:name];
    }
    
    free(ivars);
}
@end
