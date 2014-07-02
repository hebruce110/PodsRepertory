//
//  NSArray+Extensions.h
//  Vote
//
//  Created by yuan on 13-11-19.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//  将数组或字典存到本地，以data的形式,这个可以解决出现null无法保存的情况

#import <Foundation/Foundation.h>

@interface NSArray(NSArray_Extensions)
- (BOOL)writeToFile:(NSString *)path;
+(NSArray*)readFile:(NSString*)path;
@end

@interface NSDictionary(NSDictionary_Extensions)
- (BOOL)writeToFile:(NSString *)path;
+(NSDictionary*)readFile:(NSString*)path;
@end
