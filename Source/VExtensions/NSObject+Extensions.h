//
//  NSObject+Extensions.h
//  VExtensions
//
//  Created by Yuan on 14-6-16.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface NSObject(NSObject_PropertyExtension)

- (NSArray *)getPropertyList;

- (NSArray *)getPropertyList: (Class)clazz;

- (NSString *)tableSql:(NSString *)tablename;

- (NSString *)tableSql;

- (NSDictionary *)convertDictionary;

- (id)initWithDictionary:(NSDictionary *)dict;

- (NSString *)className;

//object转为json字符串
- (NSString *)toJsonString;

@end
