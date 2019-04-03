//
//  MCHealthManage.m
//  Doctor
//
//  Created by qinmuqiao on 2018/8/12.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import "MCHealthManage.h"
#import <HealthKit/HealthKit.h>
@interface MCHealthManage ()
@property (nonatomic, strong) HKHealthStore *healthStore;
@end
@implementation MCHealthManage

- (void)getStepAuthor:(void (^)(BOOL))available
{
    //查看healthKit在设备上是否可用，ipad不支持HealthKit
    if(![HKHealthStore isHealthDataAvailable])
    {
        NSLog(@"设备不支持healthKit");
    }
    //创建healthStore实例对象
    self.healthStore = [[HKHealthStore alloc] init];
    //设置需要获取的权限这里仅设置了步数
    HKObjectType *stepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *healthSet = [NSSet setWithObjects:stepCount, nil];
    
    //从健康应用中获取权限
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        available(success);
    }];
}
- (void)getDistanceAuthor:(void (^)(BOOL))available
{
    //查看healthKit在设备上是否可用，ipad不支持HealthKit
    if(![HKHealthStore isHealthDataAvailable])
    {
        NSLog(@"设备不支持healthKit");
    }
    //创建healthStore实例对象
    self.healthStore = [[HKHealthStore alloc] init];
    HKQuantityType *distance = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    NSSet *healthSet = [NSSet setWithObjects:distance, nil];
    //从健康应用中获取权限
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        available(success);
    }];
}
- (void)getTodayStep:(void (^)(NSInteger))step
{
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:[self getToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
        }
        else
        {
            NSInteger totalStep = 0;
            for(HKQuantitySample *quantitySample in results)
            {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *heightUnit = [HKUnit countUnit];
                double usersHeight = [quantity doubleValueForUnit:heightUnit];
                totalStep += usersHeight;
            }
            NSLog(@"当天行走步数 = %ld",(long)totalStep);
            dispatch_async(dispatch_get_main_queue(), ^{
                step(totalStep);
            });
        }
    }];
    [self.healthStore executeQuery:query];
}
- (void)getYesterdayStep:(void(^)(NSInteger step))step
{
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:[self getYesterday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(error)
        {
        }
        else
        {
            NSInteger totalStep = 0;
            for(HKQuantitySample *quantitySample in results)
            {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *heightUnit = [HKUnit countUnit];
                double usersHeight = [quantity doubleValueForUnit:heightUnit];
                totalStep += usersHeight;
            }
            NSLog(@"昨天行走步数 = %ld",(long)totalStep);
            dispatch_async(dispatch_get_main_queue(), ^{
                 step(totalStep);
            });
        }
    }];
    [self.healthStore executeQuery:query];
}
- (void)getTodayDictance:(void (^)(CGFloat))distance
{

    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:distanceType predicate:[self getToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        if(error)
        {
            NSLog(@"error==%@",error);
        }
        else
        {
            CGFloat totalDiatance = 0;
            for(HKQuantitySample *quantitySample in results)
            {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *distanceUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
                double usersHeight = [quantity doubleValueForUnit:distanceUnit];
                totalDiatance += usersHeight;
            }
            NSLog(@"当天行走距离 = %.2f",totalDiatance);
            dispatch_async(dispatch_get_main_queue(), ^{
                distance(totalDiatance);
            });
        }
    }];
    [self.healthStore executeQuery:query];
}
- (void)getYesterdayDictance:(void (^)(CGFloat))distance
{
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:distanceType predicate:[self getYesterday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        if(error)
        {
            NSLog(@"error==%@",error);
        }
        else
        {
             CGFloat totalDiatance = 0;
            for(HKQuantitySample *quantitySample in results)
            {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *distanceUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
                double usersHeight = [quantity doubleValueForUnit:distanceUnit];
                totalDiatance += usersHeight;
            }
            NSLog(@"当天行走距离 = %.2f",totalDiatance);
            dispatch_async(dispatch_get_main_queue(), ^{
                distance(totalDiatance);
            });
        }
    }];
    [self.healthStore executeQuery:query];
}

- (NSPredicate *)getToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}
- (NSPredicate *)getYesterday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:startDate options:0];//1 就是当前时间到未来的零点。 -1 就是昨天的凌晨零点到 今天的凌晨零点
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:endDate endDate:startDate options:HKQueryOptionNone];
    return predicate;
}
@end
