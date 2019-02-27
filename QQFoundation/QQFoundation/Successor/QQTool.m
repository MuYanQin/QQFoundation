//
//  QQTool.m
//  YYCacheTest
//
//  Created by tlt on 16/12/27.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import "QQTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <objc/runtime.h>

@implementation QQTool
/**
 是不是空
 */
+ (BOOL)isBlank:(NSString *)string
{
    return string == nil
    || string == NULL
    || [string isKindOfClass:[NSNull class]]
    ||([string respondsToSelector:@selector(length)]
       && [(NSData *)string length] == 0)
    || ([string respondsToSelector:@selector(count)]
        && [(NSArray *)self count] == 0);
}

/**
 字符串的转换
 */
+ (NSString *)strRelay:(id)str{
    
    if([self isBlank:str]){
        return @"";
    }
    else if([str isKindOfClass:[NSString class]]){
        return str;
    }
    else if([str isKindOfClass:[NSNumber class]]){
        return [str stringValue];
    }
    return [str TrimStringHAT];
}

+ (NSString *)strRelayPrice:(id)str
{
    if([self isBlank:str]){
        return @"";
    }
    else if([str isKindOfClass:[NSString class]]){
        return str;
    }
    else if([str isKindOfClass:[NSNumber class]]){
        return [NSString stringWithFormat:@"%0.2f",[str doubleValue]];
    }
    return [str TrimStringHAT];
}
/**
 * 是否为手机号码
 */
+ (BOOL)isAvaluebleMobile:(NSString *)mobile
{
    /*
     {n}    重复n次
     {n,}   重复n次或更多次
     {n,m}  重复n到m次
     @"([#][^#]+[#])";话题的正则
    */
    if(mobile.length ==0)return NO;
    NSString *CH_NUM = @"^[1]{1}[3-9]{1}[0-9]{9}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CH_NUM];
    BOOL bret = [pre evaluateWithObject:mobile];
    return bret;
}

+ (BOOL)isNumbers:(NSString *)string
{
    if(string.length ==0)return NO;
    NSString *CH_NUM = @"^[0-9]+.?[0-9]{1,}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CH_NUM];
    BOOL bret = [pre evaluateWithObject:string];
    return bret;
}
void QQ_methodSwizzle(Class cls, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(cls,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
/**
 系统级别的复制
 
 @param content 需要复制的内容
 */
+ (void)SystemPaste:(NSString *)content{
    if ([self isBlank:content]) {
        NSLog(@"粘贴内容不能为空！");
        return;
    }
    //系统级别
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = content;
    NSLog(@"\r\n====>输入框内容为:%@\r\n====>剪切板内容为:%@",content,pasteboard.string);
}
/*
 返回100k以内大小的图片
 */
+(NSData *)imageData:(UIImage *)myimage
{
        // Compress by quality
    NSInteger maxLength = 150*1024;
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(myimage, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}

@end

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

@implementation NSString (QQCalculate)

/*
 去除字符串首位的空格
 */
- (NSString *)TrimStringHAT{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
/*
 计算字符串高度
 */
- (CGFloat)GetTextHeight:(CGFloat)width font:(CGFloat)font{
    CGFloat autoheight;
    
    autoheight =[self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font] } context:nil].size.height;
    return autoheight;
}
/*
 计算字符串宽度
 */
- (CGFloat)GetTextWidth:(CGFloat)height font:(CGFloat)font{
    CGFloat autowidth;
    
    autowidth =[self boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font] } context:nil].size.width;
    return autowidth;
}

@end


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
