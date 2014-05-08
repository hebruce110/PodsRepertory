//
//  VDrawItemView.h
//  Vote
//
//  Created by Yuan on 14-4-23.
//  Copyright (c) 2014年 Yuan.He. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLayoutInfo.h"

//用performSelector出现performSelector may cause a leak because its selector is unknown警告解决的办法

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


CGFloat	CGRectMaxX( CGRect rect ); //x+width

CGFloat	CGRectMaxY( CGRect rect ); //y+height

CGRect	CGRectOutset( CGRect rect ,CGFloat dx,CGFloat dy);

BOOL	CGRectIsInvalid( CGRect rect ); //is valid rect

@interface VDrawItemCanvasView : UIView
{
    VLayoutInfo *_layoutInfo;
}

- (void)drawLayout:(VLayoutInfo *)layoutInfo;

- (void)drawLayoutRect:(CGRect)rect layoutInfo:(VLayoutInfo *)layoutInfo;

@end

