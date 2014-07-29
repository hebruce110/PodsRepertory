//
//  VHandleAreaHelper.m
//  HandlePlist
//
//  Created by yuan on 14-7-29.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "VRegionHelper.h"

@implementation VRegionHelper

- (void)dealloc
{
    _allDatas = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        _allDatas = [[NSArray alloc]initWithContentsOfFile:PATH(@"region", @"plist")];
    }
    return self;
}

#pragma mark Public Methord

- (NSArray *)getAllRelationShipRegion
{
    NSMutableArray *allProvince = [[NSMutableArray alloc]init];
    if (isValidArray(_allDatas)) {
        for (NSDictionary *province in _allDatas) {
            VProvince *p = [[VProvince alloc]init];
            p.name   = province[@"name"];
            p.pid    = province[@"id"];
            p.sort   = province[@"sort"];
            p.pinyin = province[@"pinyin"];
            p.citys = [self addCitys:province[@"citys"]];;
            [allProvince addObject:p];
        }
    }
    return allProvince;
}

- (NSArray *)getAllProvince
{
    if (isValidArray(_allDatas)) {
        NSMutableArray *allProvince = [[NSMutableArray alloc]init];
        for (NSDictionary *info in _allDatas) {
            VProvince *p = [[VProvince alloc]init];
            p.name   = info[@"name"];
            p.pid    = info[@"id"];
            p.sort   = info[@"sort"];
            p.pinyin = info[@"pinyin"];
            [allProvince addObject:p];
        }
        return allProvince;
    }
    return nil;
}

- (NSArray *)getCitysByProvinceId:(NSString *)pid
{
    if (isValidArray(_allDatas) && isValidString(pid)) {
        for (NSDictionary *info in _allDatas) {
            NSString *_pid = info[@"id"];
            if (isValidString(_pid) && [_pid isEqualToString:pid]) {
                NSArray *citys = info[@"citys"];
                if (isValidArray(citys)) {
                    NSMutableArray *results = [[NSMutableArray alloc]init];
                    for (NSDictionary *info in _allDatas) {
                        VCity *c = [[VCity alloc]init];
                        c.name   = info[@"name"];
                        c.cid    = info[@"id"];
                        c.sort   = info[@"sort"];
                        c.pinyin = info[@"pinyin"];
                        [results addObject:c];
                    }
                    return results;
                }
                break;
            }
        }
    }
    return nil;
}

- (NSArray *)getAreassByCityId:(NSString *)cid
{
    if (isValidArray(_allDatas) && isValidString(cid)) {
        for (NSDictionary *provinceinfo in _allDatas) {
            NSArray *citys = provinceinfo[@"citys"];
            if (isValidArray(citys)) {
                for (NSDictionary *cityinfo in citys) {
                    NSString *_cid = cityinfo[@"id"];
                    if (isValidString(_cid) && [_cid isEqualToString:cid]) {
                        NSArray *areas = cityinfo[@"areas"];
                        if (isValidArray(areas)) {
                            NSMutableArray *results = [[NSMutableArray alloc]init];
                            for (NSDictionary *areainfo in _allDatas) {
                                VArea *a = [[VArea alloc]init];
                                a.name   = areainfo[@"name"];
                                a.aid    = areainfo[@"id"];
                                a.sort   = areainfo[@"sort"];
                                a.pinyin = areainfo[@"pinyin"];
                                [results addObject:a];
                            }
                            return results;
                        }
                        break;
                    }
                }
            }
        }
    }
    return nil;
}


#pragma Private Methord

- (NSArray *)addCitys:(NSArray *)citys
{
    //加载city
    NSMutableArray *_citys = [[NSMutableArray alloc]init];
    if (isValidArray(citys)) {
        for (NSDictionary *city in citys) {
            VCity *c = [[VCity alloc]init];
            c.name   = city[@"name"];
            c.cid    = city[@"id"];
            c.sort   = city[@"sort"];
            c.pinyin = city[@"pinyin"];
            c.areas = [self addAreas:city[@"areas"]];
            [_citys addObject:c];
        }
    }
    return _citys;
}

- (NSArray *)addAreas:(NSArray *)areas
{
    //加载area
    NSMutableArray *_areas = [[NSMutableArray alloc]init];
    if (isValidArray(areas)) {
        for (NSDictionary *areainfo in areas) {
            VArea *a = [[VArea alloc]init];
            a.name   = areainfo[@"name"];
            a.aid    = areainfo[@"id"];
            a.sort   = areainfo[@"sort"];
            a.pinyin = areainfo[@"pinyin"];
            [_areas addObject:a];
        }
    }
    return _areas;
}

@end
