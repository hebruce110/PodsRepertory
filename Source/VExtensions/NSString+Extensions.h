//
//  NSString+Extensions.h
//  VExtensions
//
//  Created by yuan on 14-6-6.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(NSString_Extensions)

//去掉空格
-(NSString *)trimmingWhiteSpaceCharacter;

//生成一个唯一的uuid字符串
+(NSString *)createCUID;

//toMd5值
- (NSString *)toMD5;

//所有字符都是数字
- (BOOL)isOnlyDigital;

// contains sub string
- (BOOL)containsSubString:(NSString *)pString;

// range array of string
- (NSArray *)rangesOfString:(NSString *)pString;

// string to array with separated string
- (NSArray *)toArrayWithSeparator:(NSString *)pSeparator;

//解析json字符串，返回id类型（NSArray或NSDictionary）
- (id)toJsonObject;


@end
