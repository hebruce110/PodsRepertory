//
//  PKLayoutInfo.m
//  Vote
//
//  Created by yuan on 13-12-30.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//

#import "VLayoutInfo.h"

@implementation VLayoutInfo

- (id)init
{
    self =[super init];
    if (self){
        self.rect = CGRectZero;
        self.items = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)addItem:(VDrawItem*)item
{
    [self.items addObject:item];
}

- (void)addItems:(NSArray *)items
{
    [self.items addObjectsFromArray:items];
}

- (void)removeAllItems
{
    [self.items removeAllObjects];
}

- (void)removeItem:(VDrawItem*)item
{
    [self.items removeObject:item];
}

- (VDrawItem *)itemWithTag:(NSInteger)tag
{
    for (VDrawItem *item in self.items) {
        if (item.tag == tag) {
            return item;
        }
    }
    return nil;
}

- (void)increaseHeight:(CGFloat)height
{
    CGRect newRect = self.rect;
    newRect.size.height = self.rect.size.height+height;
    self.rect = newRect;
}

- (void)setHeight:(CGFloat)height
{
    CGRect newRect = self.rect;
    newRect.size.height = height;
    self.rect = newRect;
}

@end
