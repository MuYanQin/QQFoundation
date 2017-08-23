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
@implementation QQItemManager

+ (NSString *)AppName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];    //获取App名称
}
+ (NSString *)APPBundleID
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
+ (NSString *)APPBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
+ (NSString *)APPVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
@end

@implementation QQTool

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
    if (![QQTool IsNull:dic]) {
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
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
/**
 * 是否为空
 */
+ (BOOL)IsNull:(id)data
{
    BOOL bret = NO;
    if (data == nil) {
        bret = YES;
    }else if (data ==NULL){
        bret = YES;
    }else if ([data isEqual:[NSNull null]]){
        bret = YES;
        
    }else if ([data isKindOfClass:[NSNull class]]){
        bret = YES;
    }
    return bret;
}
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
/*
 身份证号验证
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
/*
 判断是否为银行卡号
 */
+ (BOOL) checkCardNo:(NSString*) cardNo{
    if (cardNo.length <10) {
        return NO;
    }
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
    
}
/**
 * 是否为IP
 */
+(BOOL) isIPAdress :(NSString *)ip{
    
    NSArray *array = [ip componentsSeparatedByString:@"."];
    //    NSLog(@"number of array %ld",[array count]);
    //    for (NSString *sIP in array) {
    //        NSLog(@"%@",sIP);
    //    }
    BOOL flag = YES;
    if ([array count] == 4) {//判断是否为四段
        for (int i = 0; i<4; i++) {
            //判断是否由数字组成
            const char *str = [array[i] cStringUsingEncoding:NSUTF8StringEncoding];
            int j = 0;
            while (str[j] != '\0' ) {
                if (str[j] >= '0' && str[j] <= '9') {
                    j++;
                }else{
                    flag = NO;
                    break;
                }
            }
            //判断ip是否在0-255范围中
            if (flag) {
                NSInteger temp = [array[i] integerValue];
                if (temp < 0 || temp > 255) {
                    flag = NO;
                    break;
                }
            }
        }
    }else{
        flag = NO;
    }
    return flag;
}

/**
 * 是否为网址
 */
+(BOOL)isValidateUrl:(NSString *)url
{
    NSString *urlRegex = @"[a-zA-z]+://[^s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}
/**
 * 是否为邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 * 是否为手机号码
 */
+ (BOOL)valiMobile:(NSString *)mobilePhone {
    
    //移动号段正则表达式
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    //联通号段正则表达式
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    //电信号段正则表达式
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:mobilePhone];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:mobilePhone];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:mobilePhone];
    
    if (isMatch1 || isMatch2 || isMatch3){
        return YES;
    }
    return NO;
}

/**
 * 是否为车牌
 */
+(BOOL) isValidateCarNo:(NSString*)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}
/**
 * sha1
 */
+(NSString*) sha1:(NSString*)str
{
    const char *ptr = [str UTF8String];
    
    NSInteger i =0;
    NSInteger len = strlen(ptr);
    Byte byteArray[len];
    while (i!=len)
    {
        unsigned eachChar = *(ptr + i);
        unsigned low8Bits = eachChar & 0xFF;
        
        byteArray[i] = low8Bits;
        i++;
    }
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(byteArray, (int)len, digest);
    
    NSMutableString *hex = [NSMutableString string];
    for (int i=0; i<20; i++)
        [hex appendFormat:@"%02x", digest[i]];
    
    NSString *immutableHex = [NSString stringWithString:hex];
    
    return immutableHex;
}


/**
 * Encode Chinese to ISO8859-1 in URL
 */
+ (NSString *) utf8StringWithChinese:(NSString *)chinese
{
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    NSString *preprocessedString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)chinese, CFSTR(""), kCFStringEncodingUTF8));
    
    
    NSString *newStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingUTF8));
    return newStr;
    
}


/**
 * Encode Chinese to GB2312 in URL
 */
+ (NSString *) gb2312StringWithChinese:(NSString *)chinese
{
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    NSString *preprocessedString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)chinese, CFSTR(""), kCFStringEncodingGB_18030_2000));
    NSString *newStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingGB_18030_2000));
    return newStr;
}


/**
 * URL encode
 */
+ (NSString*)urlEncodeWithString:(NSString *)string
{
    
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, nil, (CFStringRef)@"!*'&=();:@+$,/?%#[]", kCFStringEncodingUTF8));
    
    return newString;
}
@end
