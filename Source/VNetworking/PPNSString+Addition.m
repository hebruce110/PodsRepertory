//
//  PPNSString+Addition.m
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPNSString+Addition.h"

@implementation NSString (PPNSString_Addition)

- (BOOL)isValidUrl
{
    if (self && [self isKindOfClass:[NSString class]] && self.length>7 && ([self hasPrefix:@"http"] || [self hasPrefix:@"https"])) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidNSString
{
    return (self && [self isKindOfClass:[NSString class]] && [self length]>0)?YES:NO;
}

@end
