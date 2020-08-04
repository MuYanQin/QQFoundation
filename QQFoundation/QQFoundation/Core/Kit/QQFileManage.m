//
//  QQFileManage.m
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/18.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "QQFileManage.h"
#import "QQTool.h"
@implementation QQFileManage


+ (NSString *)appHomePath
{
    NSString *dirHome=NSHomeDirectory();
    return dirHome;
}
+ (NSString *)documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
+ (NSString *)cachesPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}
+ (NSArray *)contentUrlWith:(NSString *)path
{
    if ([QQTool isBlank:path]) {
        NSLog(@"%s--路径不能为空 ",__FUNCTION__);
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *folderContents = [fileManager
                               contentsOfDirectoryAtURL:[NSURL URLWithString:path]
                               includingPropertiesForKeys:nil
                               options:0
                               error:&error];
    if (error) {
        NSLog(@"%s %@",__FUNCTION__,error);
    }
    return folderContents;
}
+ (BOOL)isContainAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:path];
    return isExist;
}
+ (BOOL)removeItematPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL bret = [fileManager removeItemAtPath:path error:&error];
    if (error) {
        NSLog(@"%@==删除失败%@",path,error);
    }
    return bret;
}
+ (void)createFolderWithPath:(NSString *)path folderName:(NSString *)name  success:(void(^)(NSString * Path,NSError *error))result{
    if ([QQTool isBlank:path] | [QQTool isBlank:name]) {
        NSLog(@"%s--路径不能为空 ",__FUNCTION__);
        return;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [path stringByAppendingPathComponent:name];
    NSError *error = nil;
    BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    if (res) {
        result(testDirectory,error);
    }else{
        result(nil,error);
    }
}

@end
