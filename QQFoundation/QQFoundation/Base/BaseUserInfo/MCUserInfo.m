//
//  MCUserInfo.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/9.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCUserInfo.h"
#import "QQTool.h"
#import <objc/runtime.h>
static MCUserInfo *info = nil;
static dispatch_once_t onceToken;

@implementation MCUserInfo

+ (instancetype)instance
{
    dispatch_once(&onceToken, ^{
        info = self.cacheInfo;
    });
    return info;
}

+ (NSDictionary *)getUserDic
{
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getUserInfoFile]];
    if (dic == nil || dic == NULL) {
        return @{};
    }else{
        return dic;
    }
}
+ (void)writeUserInfo:(NSDictionary *)dic
{
    if (dic == nil || dic == NULL) {
        NSLog(@"用户信息不能为空");
        return;
    }
    //每次写的时候移除文件 保证数据实时写入新的
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:[self getUserInfoFile]]) {
        NSError *error;
        [filemanager removeItemAtPath:[self getUserInfoFile] error:&error];
    }
    [NSKeyedArchiver archiveRootObject:dic toFile:[self getUserInfoFile]];
    [self setCacheInfo];

}
+ (void)updateValue:(NSString *)value  key:(NSString *)key
{
    if (key.length <=0 || key == nil) {
        NSLog(@"don't be nil");
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self getUserDic]];
    [dic setObject:[QQTool strRelay:value] forKey:[QQTool strRelay:key]];
    [self writeUserInfo:dic];
    [self setCacheInfo];
}
+ (void)updateInfoWith:(NSDictionary *)dic
{
    if (dic.allKeys.count == 0) {
        NSLog(@"don't be nil");
        return;
    }
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[self getUserDic]];
    [userDic setValuesForKeysWithDictionary:dic];
    [self writeUserInfo:userDic];
    [self setCacheInfo];
}
+ (void)setCacheInfo
{
    MCUserInfo *UserInfo = [self instance];
    [UserInfo setValuesForKeysWithDictionary:[self getUserDic]];
}
+ (MCUserInfo *)cacheInfo{
    MCUserInfo *UserInfo = [[self alloc]init];
    [UserInfo setValuesForKeysWithDictionary:[self getUserDic]];
    return UserInfo;
}
+ (MCUserInfo *)getLoginInfo
{
    return info;
}

+ (void)cleanUpInfo
{
    NSError *error;
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL bret = [filemanager removeItemAtPath:[self getUserInfoFile] error:&error];//删除本地文件
    if (bret) {
        NSLog(@"清除信息成功！");
    }else{
        NSLog(@"清除信息失败！:%@",error);
    }
    //清除单例的属性值
    info = nil;
    onceToken = 0;
}
+ (NSString *)getUserInfoFile {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:@"user.txt"];
    return path;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"])
    {
        self.pid= value;
    }
}
@end
