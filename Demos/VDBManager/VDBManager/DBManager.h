//
//  DBManager.h
//  VDBManager
//
//  Created by yuan on 14-6-17.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "VDBManager.h"
#import "Contact.h"

@interface DBManager : VDBManager

+ (DBManager *)sharedDBManager;

+ (FMDatabase *)db;

@end
