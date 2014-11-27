//
//  PKLayoutInfo.h
//  Vote
//
//  Created by yuan on 13-12-30.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VDrawItem.h"
#import "VDrawItemText.h"
#import "VDrawItemImage.h"
#import "VDrawItemEmotion.h"
#import "VDrawItemURL.h"
#import "VDrawItemAttatch.h"
#import "VDrawItemCoreText.h"
#import "VDrawItemView.h"

@interface VLayoutInfo : NSObject
{

}
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, strong) id info;

//Public methords
- (void)addItem:(VDrawItem*)item;
- (void)addItems:(NSArray *)items;
- (void)removeAllItems;
- (void)removeItem:(VDrawItem*)item;
- (VDrawItem *)itemWithTag:(NSInteger)tag;
- (void)increaseHeight:(CGFloat)height;
- (void)setHeight:(CGFloat)height;

@end
