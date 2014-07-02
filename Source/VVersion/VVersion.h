//
//  VVersion.h
//  VVersion
//
//  Created by Yuan on 14-7-2.
//  Copyright (c) 2014年 heyuan110.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVersion : NSObject


/**
 *  检查新版本
 *
 *  @param appId appstore的应用id号，例如684198097
 */
+ (void)check:(NSString *)appId;


@end
