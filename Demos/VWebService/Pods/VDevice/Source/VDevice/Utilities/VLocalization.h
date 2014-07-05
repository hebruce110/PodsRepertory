//
//  PKLocalization.h
//  PKDevice
//
//  Created by yuan on 14-5-22.
//  Copyright (c) 2014年 XXTSTUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VLocalization : NSObject

+ (NSString *)currency;

// TimeZone
+ (NSString *)timeZone;

// Language
+ (NSString *)language;

// Country
+ (NSString *)country;

@end
