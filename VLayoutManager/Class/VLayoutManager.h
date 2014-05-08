//
//  PKLayoutManager.h
//  Vote
//
//  Created by yuan on 13-12-30.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLayoutInfo.h"
#import "VDrawItemCanvasView.h"

@interface VLayoutManager : NSObject

@property (nonatomic, strong) NSMutableArray *layoutInfos;

- (void)addlayoutInfo:(VLayoutInfo*)layoutInfo;

- (void)addlayoutInfo:(VLayoutInfo *)layoutInfo insert:(NSUInteger)index;

- (void)addlayoutInfos:(VLayoutInfo*)layoutInfo;

- (void)removelayoutInfoAtIndex:(NSInteger)index;

- (void)removelayoutInfo:(VLayoutInfo*)layoutInfo;

- (void)removeAlllayoutInfo;

- (NSInteger)layoutInfoCount;

- (VLayoutInfo *)layoutInfo:(NSInteger)index;

@end
