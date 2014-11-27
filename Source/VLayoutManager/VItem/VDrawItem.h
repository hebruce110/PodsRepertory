//
//  PCDrawItem.h
//  Vote
//
//  Created by yuan on 13-12-30.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VDrawItem : NSObject
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) BOOL invalidDraw; //无效的绘制，如果为yes则此item不会被draw出来
@property (nonatomic, assign) BOOL handleTouch;
@property (nonatomic, strong) UIColor *handleTouchColor;
@property (nonatomic, assign) BOOL userInteractionEnabled;
@property (nonatomic) NSInteger tag;
@property (assign) SEL selector;
@property (nonatomic,assign) id target;
@property (nonatomic,strong) id info;

@end

