//
//  NSObject+Extensions.m
//  VExtensions
//
//  Created by Yuan on 14-6-16.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "NSObject+Extensions.h"

@implementation NSObject(NSObject_PropertyExtension)

- (NSArray *)getPropertyList{
    return [self getPropertyList:[self class]];
}

- (NSArray *)getPropertyList: (Class)clazz
{
    u_int count;
    objc_property_t *properties  = class_copyPropertyList(clazz, &count);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject: [NSString  stringWithUTF8String: propertyName]];
    }
    
    free(properties);
    
    return propertyArray;
}

- (NSString *)tableSql:(NSString *)tablename{
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSArray *array = [self getPropertyList];
    [sql appendFormat:@"create table %@ (",tablename] ;
    NSInteger i = 0;
    for (NSString *key in array) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@"%@ text",key];
        i++;
    }
    [sql appendString:@")"];
    return sql;
}
- (NSString *)tableSql{
    return [self tableSql:[self className]];
}


- (NSDictionary *)convertDictionary{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSArray *propertyList = [self getPropertyList];
    for (NSString *key in propertyList) {
        SEL selector = NSSelectorFromString(key);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id value = [self performSelector:selector];
#pragma clang diagnostic pop
        
        if (value == nil) {
            value = [NSNull null];
        }
        [dict setObject:value forKey:key];
    }
    return dict;
}
- (id)initWithDictionary:(NSDictionary *)dict{
    self = [self init];
    if(self)
        [self dictionaryForObject:dict];
    return self;
    
}
- (NSString *)className{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

- (BOOL)checkPropertyName:(NSString *)name {
    unsigned int propCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &propCount);
    for (i = 0; i < propCount; i++) {
        objc_property_t prop = properties[i];
        const char *propName = property_getName(prop);
        if(propName) {
            NSString *_name = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            if ([name isEqualToString:_name]) {
                return YES;
            }
        }
    }
    return NO;
}


- (void)dictionaryForObject:(NSDictionary*) dict{
    for (NSString *key in [dict allKeys]) {
        id value = [dict objectForKey:key];
        
        if (value==[NSNull null]) {
            continue;
        }
        if ([value isKindOfClass:[NSDictionary class]]) {
            id subObj = [self valueForKey:key];
            if (subObj)
                [subObj dictionaryForObject:value];
        }
        else{
            [self setValue:value forKeyPath:key];
        }
    }
}

- (NSString *)toJsonString
{
    if ([NSJSONSerialization isValidJSONObject:self]){
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

@end
