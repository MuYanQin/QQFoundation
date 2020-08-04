
//  QQFileManage.h
//  QQUIKit
//
//  Created by ZhangQun on 2017/4/18.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQFileManage : NSObject
/**
 获取App文件的目录
 
 @return 返回app的位置
 */
+ (NSString *)appHomePath;

/**
 获取Document的路径
 
 @return 路径的字符串
 */
+ (NSString *)documentsPath;


/**
 获取Caches文件的目录
 
 @return Caches
 */
+ (NSString *)cachesPath;

/**
 获取路径下面所有文件的（包括文件夹）的url

 @param path 路径
 @return 内容
 */
+ (NSArray *)contentUrlWith:(NSString *)path;

/**
 是否存在文件
 @param path 路径
 @return 结果
 */
+ (BOOL)isContainAtPath:(NSString *)path;

+ (BOOL)removeItematPath:(NSString *)path;
/**
 创建文件夹
 
 @param path   文件路径
 @param name   文件夹的名称
 @param result 返回的结果
 */
+ (void)createFolderWithPath:(NSString *)path folderName:(NSString *)name  success:(void(^)(NSString * Path,NSError *error))result;
@end
