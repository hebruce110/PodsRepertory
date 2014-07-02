//
//  PKLayoutManager.m
//  Vote
//
//  Created by yuan on 13-12-30.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//

#import "VLayoutManager.h"

@implementation VLayoutManager

- (id)init
{
    self =[super init];
    if (self){
        self.layoutInfos = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)addlayoutInfo:(VLayoutInfo*)layoutInfo
{
    [self.layoutInfos addObject:layoutInfo];
}

- (void)addlayoutInfo:(VLayoutInfo *)layoutInfo insert:(NSUInteger)index
{
    [self.layoutInfos insertObject:layoutInfo atIndex:index];
}

- (void)addlayoutInfos:(NSArray *)layoutInfo
{
    [self.layoutInfos addObjectsFromArray:layoutInfo];
}

- (void)removelayoutInfo:(VLayoutInfo*)layoutInfo
{
    [self.layoutInfos removeObject:layoutInfo];
}

- (void)removelayoutInfoAtIndex:(NSInteger)index
{
    [self.layoutInfos removeObjectAtIndex:index];
}

- (void)removeAlllayoutInfo
{
    [self.layoutInfos removeAllObjects];
}

- (NSInteger)layoutInfoCount{
    return self.layoutInfos.count;
}

- (VLayoutInfo *)layoutInfo:(NSInteger)index
{
    if (index<[self layoutInfoCount]) {
        return self.layoutInfos[index];
    }
    return nil;
}

@end
