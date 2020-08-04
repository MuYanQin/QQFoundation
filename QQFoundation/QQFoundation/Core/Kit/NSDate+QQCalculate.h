//
//  NSDate+QQCalculate.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/14.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QQTool.h"
typedef NS_ENUM(NSInteger,QQCalendarType){
    QQCalendarday = 0,
    QQCalendarMonth = 1,
    QQCalendarYear = 2,
};
@interface NSDate (QQCalculate)

/**
 某年某月有多少天


 @param Year 年份
 @param month 月份
 @return 天数
 */
+ (NSInteger)numberOfDaysInYear:(NSInteger)Year month:(NSInteger)month;

/**
 今天是周几

 @return 周几
 */
+ (NSString *)todayIsTheWeekday;
/**
 计算这个月有多少天

 @return 天数
 */
+ (NSUInteger)numberOfDaysInCurrentMonth;

/**
 NSDate转NSString

 @param date date
 @param formate 时间格式
 @return 字符串
 */
+ (NSString *)relayDate:(NSDate *)date formate:(NSString *)formate;
/**
 NSDate转NSString

 @param dateStr s时间字符串
 @param formate 时间格式
 @return 字符串
 */
+ (NSString *)relayDateStr:(NSString *)dateStr formate:(NSString *)formate;
/**
 *  返回当前时间
 *
 *  @param Formatter 时间格式
 *
 *  @return 时间字符串
 */
+ (NSString *)nowDate:(NSString *)Formatter;

/**
 时间戳转换为时间字符串
 
 @param Timestamp 传入的时间戳
 @param formate   时间格式 YYYY-MM-dd  HH:mm:ss:sss
 @return 返回格式化后的时间
 */
+ (NSString *)relayTimestampWith:(NSString *)Timestamp formate:(NSString *)formate;

/**
 得到距离何时  多久之后或者多久之前   正：是之后   负：之前
 
 @param space   距离多久
 @param date    从何时起
 @param formate 时间格式
 @return 返回时间字符串
 */
+ (NSString *)timeInterval:(NSInteger)space from:(NSDate *)date formate:(NSString *)formate calendar:(QQCalendarType)calendar;


/**
 获取多久之前

 @param time 时间
 @return 格式化字符串
 */
+ (NSString *)howSecondsAgo:(NSString *)time;

@end

@interface QQDateFormatter : NSObject<NSCacheDelegate>
@property (nonatomic,strong) NSCache *DateCache;
@property (nonatomic, assign) NSUInteger cacheLimit;//default is 5

+ (instancetype)ShareIntance;
- (NSDateFormatter *)getDateFormatter:(NSString *)format;
@end

