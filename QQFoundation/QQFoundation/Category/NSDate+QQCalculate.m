//
//  NSDate+QQCalculate.m
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/14.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "NSDate+QQCalculate.h"
#import "QQDateFormatter.h"
@implementation NSDate (QQCalculate)

+ (NSInteger)numberOfDaysInYear:(NSInteger)year month:(NSInteger)imonth{

    if((imonth == 0)||(imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
        return 28;
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}
+ (NSString *)TodayIsTheWeekday{
    //3.获取当前日期星期几
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSArray *weekdays = [NSArray arrayWithObjects:@"星期日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSDate *date = [NSDate date];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    return [weekdays objectAtIndex:theComponents.weekday - 1];
}

/*计算这个月有多少天*/
+ (NSUInteger)numberOfDaysInCurrentMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self date]].length;
}
//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date Formate:(NSString *)formate
{
    NSDateFormatter *dateFormatter = [[QQDateFormatter ShareIntance] getDateFormatter:formate];
    [dateFormatter setDateFormat:formate];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)GetNowDate:(NSString *)Formatter;
{
    NSDateFormatter  *dateformatter = [[QQDateFormatter ShareIntance] getDateFormatter:Formatter];
    NSDate *datenow = [NSDate date];
    NSString *  locationString=[dateformatter stringFromDate:datenow];
    return locationString;
}

/*
 转换时间戳
 */
+ (NSString *)ConvertTimestampWith:(NSString *)Timestamp Formate:(NSString *)formate;
{
    NSTimeInterval interval=[Timestamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat =  [[QQDateFormatter ShareIntance] getDateFormatter:formate];
    NSString *timestr =  [objDateformat stringFromDate: date];
    return timestr;
}

+ (NSString *)GetTimeInterval:(NSInteger)space from:(NSDate *)date Formate:(NSString *)formate Calendar:(QQCalendarType)Calendar

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    switch (Calendar) {
        case QQCalendarday:
        {
            [comps setDay:space];
            
            break;
        }
        case QQCalendarMonth:
        {
            [comps setMonth:space];
            
            break;
        }
        case QQCalendarYear:
        {
            [comps setYear:space];
            break;
        }
        default:
            break;
    }
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    NSDateFormatter *dateFormatter= [[QQDateFormatter ShareIntance] getDateFormatter:formate];//创建一个日期格式化器
    return [dateFormatter stringFromDate:mDate];
}
+ (NSString *)getHowSecondsAgo:(NSString *)time
{
    CGFloat temp = 0;
    NSString *result;
    NSString *CH_NUM = @"^[0-9]{1,}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CH_NUM];
    BOOL bret = [pre evaluateWithObject:time];
    NSTimeInterval timeInterval;
    NSDate *data3;
    if (bret) {
        NSDate* date11 = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/ 1000.0];
        NSDate *currentDate = [NSDate date];
        timeInterval= [currentDate timeIntervalSinceDate:date11];

    }else{
        NSDateFormatter *formatter = [[QQDateFormatter ShareIntance] getDateFormatter:@"yyyy-MM-dd HH:mm:ss"];//;
        data3 = [formatter dateFromString:time];
        NSDate *currentDate = [NSDate date];
        timeInterval = [currentDate timeIntervalSinceDate:data3];
    };

    if (timeInterval/60 < 5) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%.0f分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%.0f小时前",temp];
    }
    else if((temp = temp/24) <=5){
        result = [NSString stringWithFormat:@"%.0f天前",temp];
    }
    else{
        temp = temp/12;
        if (bret) {
            result = [NSDate ConvertTimestampWith:time Formate:@"MM/dd  HH:mm"];
        }else{
            NSDateFormatter *formatter = [[QQDateFormatter ShareIntance] getDateFormatter:@"MM/dd HH:mm"];//;
            result = [formatter stringFromDate:data3];
        }
    }
    return result;
}
@end
