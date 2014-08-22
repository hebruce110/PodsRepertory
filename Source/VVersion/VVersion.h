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
 *  @param block 回调，返回yes表示有新版本，否则没有
 */

+ (void)check:(NSString *)appId
     finished:(void(^)(BOOL isFinished))block;


@end
