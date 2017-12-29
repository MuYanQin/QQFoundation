//
//  QQSqlHelper.h
//  QQFoundation
//
//  Created by Maybe on 2017/12/28.
//  Copyright © 2017年 MuYanQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface QQSqlHelper : NSObject

//初始化数据库
- (instancetype)init;

/**
 *    @brief    查询纪录集
 */
- (NSMutableArray *)selectAllInfo;

/**
 *    @brief    查询表中纪录的数量
 */
- (int)getTableCount;


/**
 查询指定的一条纪录

 @param sql sql 语句
 @return 字典
 */
- (NSMutableDictionary *)selectOneInfo:(NSString *)sql;

/**
 *    @brief    执行插入/删除/更新sql字符串
 *    插入语法  [_Fm executeUpdate:@"insert into UrlCache values(?,?,?)", dic[@"url"], dic[@"json"], [self getSystemTM]]
      更新语法  [_Fm executeUpdate:@"update  UrlCache  set url=?,json=?,time=? where url=?", dic[@"url"], dic[@"json"], [self getSystemTM],dic[@"url"]]
      删除语法  [_Fm executeUpdate:@"delete from UrlCache where url=?",url]  @"DELETE FROM tb_course WHERE sonClassId=%@",sonClassId
 *
 *    @param     sql     sql字符串
 */
- (BOOL)exeSqls:(NSString *)sql;
@end
