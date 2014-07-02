//
//  NSString+Extensions.m
//  VExtensions
//
//  Created by yuan on 14-6-6.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "NSString+Extensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSString_Extensions)

-(NSString *)trimmingWhiteSpaceCharacter
{
    if (self == nil || [self length]<1)return nil;
    NSString *newstr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    newstr = [newstr stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    newstr = [newstr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return newstr;
}

+(NSString *)createCUID
{
    NSString *prefix = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    uuid = CFUUIDCreate(NULL);
    uuidStr = CFUUIDCreateString(NULL, uuid);
    result =[NSString stringWithFormat:@"%@-%@",prefix,uuidStr];
    CFRelease(uuidStr);
    CFRelease(uuid);
    return [result toMD5];
}

- (NSString *)toMD5
{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

/****是否全是数字****/
- (BOOL)isOnlyDigital
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if (numberOfMatches > 0) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)containsSubString:(NSString *)pString{
    BOOL _ret = NO;
    
    // define range
    NSRange _range = [[self lowercaseString] rangeOfString:[pString lowercaseString]];
    
    if (NSNotFound != _range.location) {
        _ret = YES;
    }
    
    return _ret;
}


- (NSArray *)rangesOfString:(NSString *)pString{
    NSMutableArray *_ret = [[NSMutableArray alloc] init];
    
    // define parent string
    NSString *_parentString = self;
    
    // define parent string location in self string
    NSInteger _parentStringLocation = 0;
    
    // define range of paramter string in parent string
    NSRange _range = NSMakeRange(0, 0);
    
    // get ranges
    do {
        // reset range
        _range = [_parentString rangeOfString:pString];
        
        // parameter string found in parent string
        if (NSNotFound != _range.location) {
            // reset parent string
            _parentString = [_parentString substringFromIndex:_range.location + _range.length];
            
            // add ranges to return result
            [_ret addObject:NSStringFromRange(NSMakeRange(_parentStringLocation + _range.location, _range.length))];
            
            // save parent string location in self string
            _parentStringLocation += _range.location + _range.length;
        }
    } while (0 != _range.length && _range.length <= _parentString.length);
    
    return _ret;
}

- (NSArray *)toArrayWithSeparator:(NSString *)pSeparator{
    NSMutableArray *_ret = [[NSMutableArray alloc] init];
    
    // check separator
    if (!pSeparator || [pSeparator isEqualToString:@""]) {
        // traversal the string
        for (NSInteger _index = 0; _index < self.length; _index++) {
            [_ret addObject:[self substringWithRange:NSMakeRange(_index, 1)]];
        }
    }
    else {
        [_ret addObjectsFromArray:[self componentsSeparatedByString:pSeparator]];
    }
    
    return _ret;
}

- (id)toJsonObject
{
    if (self && [self isKindOfClass:[NSString class]] && self.length>0){
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        id dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        return dict;;
    }
    return nil;
}


@end
