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
+(void)setup
{
    [[UIApplication sharedApplication].delegate.window addSubview:[[MCDetectionView alloc]initWithFrame:CGRectMake(15, 64, 90, 40)]];

}
@end
