//
//  VHandleAreaHelper.h
//  HandlePlist
//
//  Created by yuan on 14-7-29.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "VExtensions.h"
#import "VProvince.h"
#import "VCity.h"
#import "VArea.h"

@interface VRegionHelper : NSObject
{
    NSArray *_allDatas;
}

- (NSArray *)getAllRelationShipRegion;

- (NSArray *)getAllProvince;

- (NSArray *)getCitysByProvinceId:(NSString *)pid;

- (NSArray *)getAreassByCityId:(NSString *)cid;

@end
