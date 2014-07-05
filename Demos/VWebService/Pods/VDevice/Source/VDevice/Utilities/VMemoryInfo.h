//
//  PKMemoryInfo.h
//  PKDevice
//
//  Created by yuan on 14-5-22.
//  Copyright (c) 2014年 XXTSTUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMemoryInfo : NSObject

// Memory Information

// Total Memory
+ (double)totalMemory;

// Free Memory
+ (double)freeMemory:(BOOL)inPercent;

// Used Memory
+ (double)usedMemory:(BOOL)inPercent;

// Active Memory
+ (double)activeMemory:(BOOL)inPercent;

// Inactive Memory
+ (double)inactiveMemory:(BOOL)inPercent;

// Wired Memory
+ (double)wiredMemory:(BOOL)inPercent;

// Purgable Memory
+ (double)purgableMemory:(BOOL)inPercent;


@end
