//
//  QQSqlHelper.m
//  QQFoundation
//
//  Created by Maybe on 2017/12/28.
//  Copyright © 2017年 MuYanQin. All rights reserved.
//

#import "QQSqlHelper.h"
#define BDNAME @"QQSqlHelper.db"
#define TABLENAME @"QQTable"
@interface QQSqlHelper ()
@property (nonatomic,strong) FMDatabaseQueue *DBQ;
@end
@implementation QQSqlHelper
- (instancetype)init
{
    if (self = [super init]) {
        NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString * sqlPath = [path2 stringByAppendingPathComponent:BDNAME];
        self.DBQ = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
        //取出数据库，这里的db就是数据库，在数据库中创建表
        [self.DBQ inDatabase:^(FMDatabase *db) {
            //创建表
            //可以用unique 约束某个字段表示唯一性  例如： name text not null unique
            BOOL createTableResult=[db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT,name text not null unique,age integer)",TABLENAME]];
            if (createTableResult) {
                NSLog(@"创建表成功");
            }else{
                NSLog(@"创建表失败");
            }
        }];
    }
    return self;
}
- (NSMutableArray *)selectAllInfo
{
    __block NSMutableArray *users = [[NSMutableArray alloc] init];
    NSString *sql = [NSString stringWithFormat:@"select count(*) from %@",TABLENAME];
    [self.DBQ inDatabase:^(FMDatabase *db)   {//代码实际上是同步
        [db open];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            @autoreleasepool{
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                for (int i = 0; i<[rs columnCount]; i++)
                {
                    @autoreleasepool{
                        NSString *colName = [rs columnNameForIndex:i];
                        NSObject *obj = [rs objectForColumn:colName];
                        if (![obj isKindOfClass:[NSNull class]])
                        {
                            [dic setObject:obj forKey:colName];
                        }
                    }
                }
                [users addObject:dic];
            }
        }
        [db close];
    }];
    return users;
}

- (int)getTableCount
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"select count(*) from %@",TABLENAME];
    NSMutableDictionary *dic = [self selectOneInfo:sql];
    if ([dic count]>0) {
        count = [[dic objectForKey:@"count(*)"] intValue];
    }
    return count;
}
- (NSMutableDictionary *)selectOneInfo:(NSString *)sql
{
    __block NSMutableDictionary *users = [[NSMutableDictionary alloc] init];
    [self.DBQ inDatabase:^(FMDatabase *db)   {
        [db open];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            for (int i = 0; i<[rs columnCount]; i++)
            {
                @autoreleasepool{
                    NSString *colName = [rs columnNameForIndex:i];
                    NSObject *obj = [rs objectForColumn:colName];
                    if (![obj isKindOfClass:[NSNull class]])
                    {
                        [users setObject:obj forKey:colName];
                    }
                }
            }
        }
        [db close];
    }];
    return users;
}
- (BOOL)exeSqls:(NSString *)sql
{
    __block BOOL ret = YES;
    [self.DBQ inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db beginDeferredTransaction];
        BOOL t = [db executeUpdate:sql];
        //当最后*rollback的值为YES的时候，事务回退，如果最后*rollback为NO，事务提交
        if (!t) {
            *rollback = YES;
        }else{
            *rollback = NO;
        }
    }];
    return ret;
}
@end
