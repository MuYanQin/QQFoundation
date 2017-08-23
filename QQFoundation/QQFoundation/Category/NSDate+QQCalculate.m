//
//  NSDate+QQCalculate.m
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/14.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "NSDate+QQCalculate.h"

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
    return [weekdays objectAtIndex:theComponents.weekday];
}

/*计算这个月有多少天*/
+ (NSUInteger)numberOfDaysInCurrentMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self date]].length;
}
//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date Formate:(NSString *)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:formate];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)GetNowDate:(NSString *)Formatter;
{
    NSDate *datenow = [NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:Formatter];
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
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formate];
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
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    
    dateFormatter.dateFormat=formate;//指定转date得日期格式化形式
    return [dateFormatter stringFromDate:mDate];
}
@end
