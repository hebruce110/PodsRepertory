//
//  PKDevice.h
//  PKDevice
//
//  Created by yuan on 14-5-22.
//  Copyright (c) 2014年 XXTSTUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VJailbreakCheck.h"
#import "VDiskInfo.h"
#import "VMemoryInfo.h"
#import "VLocalization.h"
#import "VNetwork.h"

@interface VDevice : NSObject

+ (NSString *)infos;

+ (NSString *)systemName;

+ (NSString *)deviceType;

+ (NSString *)deviceModel;

+ (NSString *)systemVersion;

+ (NSString *)screenSize;

+ (NSString *)country;

+ (NSString *)currency;

+ (NSString *)language;

+ (NSString *)timeZone;

+ (BOOL)isJailbroken;

@end
