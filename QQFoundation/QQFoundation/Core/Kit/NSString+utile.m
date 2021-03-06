//
//  NSString+utile.m
//  QQFoundation
//
//  Created by leaduMac on 2020/8/9.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import "NSString+utile.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (utile)
/**
 * 是否为数字
 */
-(BOOL)isNumbers{
    NSString *carRegex = @"^[0-9]*$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}
/**
  去除所有空格
 */
- (NSString *)deleteAllSpace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
/*
 去除字符串首位的空格
 */
- (NSString *)trimStringHAT{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSString *)base64
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
- (NSString *)md5{
    const char *cStr = [self UTF8String];// 先转为UTF_8编码的字符串
    unsigned char digest[CC_MD5_DIGEST_LENGTH];//设置一个接受字符数组
    CC_MD5( cStr, (int)strlen(cStr), digest );// 把str字符串转换成为32位的16进制数列，存到了result这个空间中
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [result appendFormat:@"%02x", digest[i]];//将16字节的16进制转成32字节的16进制字符串
    }
    return result;
}

/*
 计算字符串高度
 */
- (CGFloat)textHeight:(CGFloat)width font:(CGFloat)font{
    CGFloat autoheight;
    
    autoheight =[self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font] } context:nil].size.height;
    return autoheight;
}
/*
 计算字符串宽度
 */
- (CGFloat)textWidth:(CGFloat)height font:(CGFloat)font{
    CGFloat autowidth;
    
    autowidth =[self boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font] } context:nil].size.width;
    return autowidth;
}
@end
