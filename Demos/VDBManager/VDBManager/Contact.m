//
//  Contacts.m
//  Financial
//
//  Created by Yuan on 14-3-1.
//  Copyright (c) 2014年 suihuan. All rights reserved.
//

#import "Contact.h"
#import "DBManager.h"

@implementation Contact
@synthesize name;
@synthesize userid;
@synthesize tel;
@synthesize type;

+ (void) insert:(NSDictionary *) contact
{
    [[DBManager sharedDBManager]executeBlock:^{
        NSString *sql = [NSString stringWithFormat:@"select count(name) from %@ where name='%@'",NSStringFromClass([Contact class]),contact[@"name"]];
        NSUInteger count = [DBManager.db intForQuery:sql];
        //判断记录是否存在
        if(count>0){
            sql = @"update Contact set tel = ? where name = ?";
            HYLog(@"通讯录更新记录");
        }else{
            sql = @"insert into Contact (tel, name) values (?, ?)";
            HYLog(@"通讯录插入记录");
        }
        if (![DBManager.db executeUpdate:sql,contact[@"tel"],contact[@"name"]]) {
            HYLog(@"更新通讯录记录失败");
        }
    }];
}

+ (NSMutableArray *) allRecords
{
    NSMutableArray *records = [[DBManager sharedDBManager] executeCallBlockBlock:^id(id value) {
        NSString *sqlString = [NSString stringWithFormat:@"select rowid,name,tel,userid from %@ order by rowid desc",NSStringFromClass([Contact class])];
        FMResultSet *fetchRequest = [DBManager.db executeQuery:sqlString];
        NSMutableArray *results = [[NSMutableArray alloc]init];
        while ([fetchRequest next]){
            Contact *contacts = [[Contact alloc]init];
            contacts.name = FormatString([fetchRequest stringForColumn:@"name"], @"");
            contacts.userid = FormatString([fetchRequest stringForColumn:@"userid"], @"");
            contacts.tel = FormatString([fetchRequest stringForColumn:@"tel"], @"");
            contacts.type = [NSString stringWithFormat:@"%d",ContactTypeInvite]; //没有注册
            [results addObject:contacts];
        }
        return results;
    }];
    return  records;
}

+ (NSMutableArray *)searchCantacts:(NSString *)keywords
{
    return [[DBManager sharedDBManager]executeCallBlockBlock:^id(id value) {
        NSString *sql = [NSString stringWithFormat:@"select rowid,tel,name,userid from %@ where name like '%%%@%%' order by rowid desc",NSStringFromClass([Contact class]),keywords];
        FMResultSet *fetchRequest = [DBManager.db executeQuery:sql];
        NSMutableArray *results = [[NSMutableArray alloc]init];
        while ([fetchRequest next]){
            Contact *contacts = [[Contact alloc]init];
            contacts.name = FormatString([fetchRequest stringForColumn:@"name"], @"");
            contacts.userid = FormatString([fetchRequest stringForColumn:@"userid"], @"");
            contacts.tel = FormatString([fetchRequest stringForColumn:@"tel"], @"");
            contacts.type = [NSString stringWithFormat:@"%d",ContactTypeInvite]; //没有注册
            [results addObject:contacts];
        }
        return results;
    }];
}

@end
