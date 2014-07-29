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

//根据输入的关键字模糊匹配，中文，拼音都行
- (NSArray *)searchCityWithKey:(NSString *)key;

//获取所有带关系的省市区
- (NSArray *)getAllRelationShipRegion;

//获取所有的省
- (NSArray *)getAllProvince;

//获取省的所有城市
- (NSArray *)getCitysByProvinceId:(NSString *)pid;

//获取城市所有的区
- (NSArray *)getAreassByCityId:(NSString *)cid;

@end
