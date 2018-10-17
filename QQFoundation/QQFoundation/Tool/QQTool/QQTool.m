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
#import "NSString+QQCalculate.h"

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
