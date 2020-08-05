//
//  MCUserInfo.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/9.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCUserInfo : NSObject

@property (nonatomic , copy) NSString * pid;
/**
 实例化对象
 
 @return 对象
 */
+ (instancetype)instance;


/**
 获取用户的信息
 
 @return 字典
 */
+ (NSDictionary *)getUserDic;

/**
 将用户的信息写在本地
 
 @param dic 传入用户信息的字典
 */
+ (void)writeUserInfo:(NSDictionary *)dic;


/**
 清除用户信息(退出登录。修改密码等操作后需调用)
 */
+ (void)cleanUpInfo;


/**
 更新本地的某条数据
 
 @param value 数据值
 @param key 数据key
 */
+ (void)updateValue:(NSString *)value  key:(NSString *)key;

/**
 用字典更新用户信息
 
 @param dic dic description
 */
+ (void)updateInfoWith:(NSDictionary *)dic;
@end
