
//  QQTool.h
//
//  Created by tlt on 16/12/27.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**小工具*/
@interface QQTool : NSObject
/**
 判断字符串是否为空
 */
+ (BOOL)isBlank:(NSString *)string;

/**
 字符串的空、对象、等处理方式
 @param str 传入对象
 @return 字符串
 */
+ (NSString *)strRelay:(id)str;

/**
 转换成价格格式  保留俩位小数
 
 @param str 传入的对象
 @return 字符串
 */
+ (NSString *)strRelayPrice:(id)str;

/**
 是否为手机号
 
 @param mobile 字符串
 @return 布尔值
 */
+ (BOOL)isAvaluebleMobile:(NSString *)mobile;

/**
 是否是数字

 @param string 字符串
 @return 布尔值
 */
+ (BOOL)isNumbers:(NSString *)string;

/**
 运行时交换方法

 @param cls              哪个类
 @param originalSelector 系统方法
 @param swizzledSelector 要交换的方法
 */
void QQ_methodSwizzle(Class cls, SEL originalSelector, SEL swizzledSelector);


/**
 json格式字符串转字典
 
 @param jsonString 传入
 
 @return 返回
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 字典转字符串

 @param dic 传入的字典

 @return 返回的字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 系统级别的复制

 @param content 需要复制的内容
 */
+ (void)SystemPaste:(NSString *)content;

/*
 返回100k以内大小的图片
 */
+(NSData *)imageData:(UIImage *)myimage;


@end


/**DateFormatter的缓存*/
@interface QQDateFormatter : NSObject<NSCacheDelegate>

@property (nonatomic,strong) NSCache *DateCache;
@property (nonatomic, assign) NSUInteger cacheLimit;//default is 5

+ (instancetype)ShareIntance;
- (NSDateFormatter *)getDateFormatter:(NSString *)format;

@end

@interface NSString (QQCalculate)

/**
 去除字符串首位的空格
 
 @return 去除空格口德字符串
 */
- (NSString *)TrimStringHAT;
/**
 计算字符串高度
 
 @param width 控件的宽度
 @param font 字体大小
 @return 高度
 */
- (CGFloat)GetTextHeight:(CGFloat)width font:(CGFloat)font;
/**
 计算字符串宽度
 
 @param height 控件的高度
 @param font 字体大小
 @return 宽度
 */
- (CGFloat)GetTextWidth:(CGFloat)height font:(CGFloat)font;

@end


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
+ (NSString *)TodayIsTheWeekday;
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
+ (NSString *)stringFromDate:(NSDate *)date Formate:(NSString *)formate;
/**
 *  返回当前时间
 *
 *  @param Formatter 时间格式
 *
 *  @return 时间字符串
 */
+ (NSString *)GetNowDate:(NSString *)Formatter;

/**
 时间戳转换为时间字符串
 
 @param Timestamp 传入的时间戳
 @param formate   时间格式 YYYY-MM-dd  HH:mm:ss:sss
 @return 返回格式化后的时间
 */
+ (NSString *)ConvertTimestampWith:(NSString *)Timestamp Formate:(NSString *)formate;

/**
 得到距离何时  多久之后或者多久之前   正：是之后   负：之前
 
 @param space   距离多久
 @param date    从何时起
 @param formate 时间格式
 @return 返回时间字符串
 */
+ (NSString *)GetTimeInterval:(NSInteger)space from:(NSDate *)date Formate:(NSString *)formate Calendar:(QQCalendarType)Calendar;


/**
 获取多久之前
 
 @param time 时间
 @return 格式化字符串
 */
+ (NSString *)getHowSecondsAgo:(NSString *)time;

@end
