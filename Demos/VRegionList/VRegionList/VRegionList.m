//
//  VRegionList.m
//  VRegionList
//
//  Created by yuan on 14-7-29.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "VRegionList.h"

@implementation VRegionList

- (id)init
{
    self = [super init];
    if (self) {
        VRegionHelper *helper = [[VRegionHelper alloc]init];
        HYLog(@"%@",[helper getAllRelationShipRegion]);
    }
    return self;
}

@end
