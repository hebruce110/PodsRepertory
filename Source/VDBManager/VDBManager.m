//
//  VDBManager.m
//  VDBManager
//
//  Created by yuan on 14-6-17.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "VDBManager.h"

@implementation VDBManager

//需在子类实现
+ (void) initDB
{
    //override
}

//快速获取FMDatabase,需在子类实现
+ (FMDatabase *)db
{
    //override
    return nil;
}

//初始化数据库
- (void) setupDB
{
    if (!_dataBase) {
        //判断数据库是否存在，如果不存在，创建数据库
        NSString *dbpath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:kDBName];
        if (!_dataBase) {
            _dataBase = [[FMDatabase alloc]initWithPath:dbpath];
        }
        [_dataBase setLogsErrors:YES];
        [_dataBase setShouldCacheStatements:YES]; //为数据库设置缓存，提高查询效率
        [_dataBase open];
        _dbQueue =   [[FMDatabaseQueue alloc] initWithPath:dbpath];
        [self executeBlock:^{
            [self createTables]; //新建表
        }];
    }
}

//执行块
- (void)executeBlock:(DBBlock)block
{
    if ([_dataBase open]) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            block();
        }];
    }else{
        HYLog(@"打开数据库失败!");
    }
}

- (id)executeCallBlockBlock:(DBCallBackBlock)block
{
    if ([_dataBase open]) {
        id reuslt = block(nil);
        return reuslt;
    }else{
        HYLog(@"打开数据库失败!");
    }
    return nil;
}

+ (NSString *)generateCreateTableSql:(Class)class
                         integerkeys:(NSArray *)integerkeys
                          primaryKey:(NSString *)primaryKey
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSArray *propertys = [self getPropertyList:class];
    [sql appendFormat:@"create table %@ (",NSStringFromClass(class)] ;
    NSInteger i = 0;
    for (NSString *key in propertys) {
        if (i>0)[sql appendString:@","];
        
        //判断类型
        if (isValidArray(integerkeys) && [integerkeys containsObject:key]) {
            [sql appendFormat:@"%@ integer",key];
        }else{
            [sql appendFormat:@"%@ text",key];
        }
        i++;
    }
    
    //添加索引键
    if (isValidString(primaryKey) && [propertys containsObject:primaryKey]) {
        [sql appendFormat:@", PRIMARY KEY (`%@`)",primaryKey];
    }
    [sql appendString:@")"];
    
    return sql;
}

+ (NSString *)generateCreateTableSql:(Class)class
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSArray *propertys = [self getPropertyList:class];
    [sql appendFormat:@"create table %@ (",NSStringFromClass(class)] ;
    NSInteger i = 0;
    for (NSString *key in propertys) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@"%@ text",key];
        i++;
    }
    [sql appendString:@")"];
    return sql;
}

+ (NSString *)generateInsertSql:(NSString *)tablename
                           info:(NSDictionary *)infos
                         values:(NSMutableArray *)array
{
    NSArray *keys = [infos allKeys];
    NSMutableArray *values = [NSMutableArray array];
    for (int i = 0 ; i < keys.count; i++) {
        [values addObject:@"?"];
        [array addObject:infos[keys[i]]];
    }
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)",tablename,[keys componentsJoinedByString:@","],[values componentsJoinedByString:@","]];
    //返回的格式如下 sql =  @"insert into User values (:mobile,:userName,:logoUrl,:sex,:cityName,:cityId,:sign,:memberPoints,:userId)";
    return sql;
}

+ (NSString *)generateUpdateSql:(NSString *)tablename
                   conditionKey:(NSString *)conditionKey
                           info:(NSDictionary *)infos
                         values:(NSMutableArray *)values
{
    NSArray *keys = [infos allKeys];
    NSMutableString *valueString = [NSMutableString stringWithString:@""];
    for (NSString *key in keys) {
        if ([key isEqualToString:conditionKey]) {
            continue;
        }
        NSString *string = [NSString stringWithFormat:@"%@ = ?",key];
        if (valueString.length<1) {
            [valueString appendString:string];
        }else{
            [valueString appendFormat:@" , %@",string];
        }
        [values addObject:infos[key]];
    }
    [values addObject:infos[conditionKey]];
    
    NSString *conditionString = [NSString stringWithFormat:@"%@ = ?",conditionKey];
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ where %@",tablename,valueString,conditionString];
    return sql;
}

//创建数据库表,需要在subclass中实现
- (void)createTables
{

}

@end










