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
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>4*1024*1024) {
            data=UIImageJPEGRepresentation(myimage, 0.02);
        }else  if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }
        else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}
@end
