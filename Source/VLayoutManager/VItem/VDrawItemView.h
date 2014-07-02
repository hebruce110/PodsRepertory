//
//  PKDrawItemView.h
//  Vote
//
//  Created by yuan on 14-1-15.
//  Copyright (c) 2014年 yuan.he. All rights reserved.
//

#import "VDrawItem.h"

@interface VDrawItemView : VDrawItem
@property (nonatomic, strong)  UIColor *backgroundColor;
@property (nonatomic)BOOL isFill;
@property (nonatomic)CGFloat cornerRadius;
@property (nonatomic)CGFloat strokeLineWidth;
@property (nonatomic, strong)UIColor *strokeLineColor;
@end
