//
//  NSString+encrypt.m
//  QQFoundation
//
//  Created by leaduMac on 2019/9/8.
//  Copyright © 2019 慕纯. All rights reserved.
//

#import "NSString+encrypt.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString(encrypt)
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
@end
