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


+ (NSString *)GetAppHomePath
{
    NSString *dirHome=NSHomeDirectory();
    return dirHome;
}
+ (NSString *)GetDocumentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
+ (NSString *)GetCachesPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}
+ (NSArray *)GetContentUrlWith:(NSString *)path
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
+(void)CreateFolderWithPath:(NSString *)path FolderName:(NSString *)name Success:(void (^)(NSString*, NSError *))result{
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
