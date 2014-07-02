//
//  PKDrawItemView.m
//  Vote
//
//  Created by yuan on 14-1-15.
//  Copyright (c) 2014年 yuan.he. All rights reserved.
//

#import "VDrawItemView.h"

@implementation VDrawItemView

- (id)init
{
    self = [super init];
    if (self) {
        self.strokeLineColor = [UIColor blackColor];
        self.strokeLineWidth = 0.0f;
        self.cornerRadius = 0.0;
        self.isFill = NO;
    }
    return self;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    if (_cornerRadius >0) {
        self.isFill = YES;
    }else{
        self.isFill = NO;
    }
}

@end
