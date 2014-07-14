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

//将rgb的字符串转为颜色UIColor,rbg之间用逗号隔开,例如:"244,212,53"
- (UIColor *)rgbToColor;

//将#或0X开头的字符串颜色转换为UIColor，例如:#000000
- (UIColor *)hexToColor;

//是否是邮件
- (BOOL)isEmail;

//字符串转为NSDate,字符串8位,格式必需为:yyyymmdd 例如：20080101
- (NSDate *)toDate;

//计算string的高度，兼容ios7和之前
- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth
                      font:(UIFont *)font
            lineBreakModel:(NSLineBreakMode)mode;

@end
