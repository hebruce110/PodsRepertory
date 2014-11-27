//
//  VDrawItemView.h
//  Vote
//
//  Created by Yuan on 14-4-23.
//  Copyright (c) 2014年 Yuan.He. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLayoutInfo.h"

@interface VDrawItemCanvasView : UIView
{
    VLayoutInfo *_layoutInfo;
}

- (void)drawLayout:(VLayoutInfo *)layoutInfo;

- (void)drawLayoutRect:(CGRect)rect layoutInfo:(VLayoutInfo *)layoutInfo;

@end

