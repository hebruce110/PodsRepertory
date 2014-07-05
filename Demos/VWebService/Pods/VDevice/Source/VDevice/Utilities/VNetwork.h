//
//  PKNetwork.h
//  PKDevice
//
//  Created by yuan on 14-5-22.
//  Copyright (c) 2014年 XXTSTUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VNetwork : NSObject

// Get Cell IP Address
+ (NSString *)cellIPAddress;

// Get WiFi IP Address
+ (NSString *)wiFiIPAddress;

// Connected to WiFi?
+ (BOOL)connectedToWiFi;

// Connected to Cellular Network?
+ (BOOL)connectedToCellNetwork;

@end
