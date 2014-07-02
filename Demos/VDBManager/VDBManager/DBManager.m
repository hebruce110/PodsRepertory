//
//  DBManager.m
//  VDBManager
//
//  Created by yuan on 14-6-17.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

SINGLETON_GCD(DBManager);

+ (void) initDB
{
    [[DBManager sharedDBManager]setupDB];
}

+ (FMDatabase *)db
{
    return [DBManager sharedDBManager].dataBase;
}

- (void)createTables
{
    // 创建通讯录联系人
    if (![self.dataBase executeUpdate:[DBManager generateCreateTableSql:[Contact class]]]){
        HYLog(@"创建contact表失败");
    }
    HYLog(@"create tables");
}


@end
