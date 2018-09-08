//
//  MCDetect.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/4.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCDetect.h"
#import "MCDetectionView.h"
@implementation MCDetect
+ (void)setupWithDomains:(NSArray *)Domains
{
    MCDetectionView *Detection = [[MCDetectionView alloc]initWithFrame:CGRectMake(15, 20, 90, 40)];
    Detection.Domains = Domains;
    [[UIApplication sharedApplication].delegate.window addSubview:Detection];
}
@end
