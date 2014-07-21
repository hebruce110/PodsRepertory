//
//  NSData+Extensions.m
//  VExtensions
//
//  Created by yuan on 14-7-19.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "NSData+Extensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData(NSData_Extensions)

/*
文件的md5校验，e.g:
NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"mp3"];
NSData *data = [NSData dataWithContentsOfFile:path];
if(data)
NSLog(@"data md5 %@", [data MD5]);
*/
- (NSString*)MD5
{
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(self.bytes, self.length, md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}


@end
