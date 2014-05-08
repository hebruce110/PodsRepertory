//
//  PKDrawItemCoreText.h
//  Vote
//
//  Created by yuan on 14-1-15.
//  Copyright (c) 2014年 yuan.he. All rights reserved.
//

#import "VDrawItemText.h"
#import <CoreText/CoreText.h>

@interface VDrawItemCoreText : VDrawItemText
@property (nonatomic, assign) CTFrameRef textFrame;
@property (nonatomic, strong) NSMutableAttributedString *attributedString;
@property (nonatomic, assign) CGSize size;
@end
