//
//  UIControl+Extensions.m
//  VExtensions
//
//  Created by yuan on 14-6-6.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "UIControl+Extensions.h"
#import <objc/runtime.h>

@interface DDBlockActionWrapper : NSObject
@property (nonatomic, copy) void (^blockAction)(void);
- (void) invokeBlock:(id)sender;
@end

@implementation DDBlockActionWrapper
@synthesize blockAction;
- (void) dealloc {
    [self setBlockAction:nil];
}

- (void) invokeBlock:(id)sender {
    [self blockAction]();
}
@end

@implementation UIControl (UIControl_Extensions)

static const char * UIControlDDBlockActions = "UIControlDDBlockActions";

- (void) addEventHandler:(void(^)(void))handler forControlEvents:(UIControlEvents)controlEvents {
    
    NSMutableArray * blockActions = objc_getAssociatedObject(self, &UIControlDDBlockActions);
    if (blockActions == nil) {
        blockActions = [NSMutableArray array];
        objc_setAssociatedObject(self, &UIControlDDBlockActions, blockActions, OBJC_ASSOCIATION_RETAIN);
    }
    
    DDBlockActionWrapper * target = [[DDBlockActionWrapper alloc] init];
    [target setBlockAction:handler];
    [blockActions addObject:target];
    
    [self addTarget:target action:@selector(invokeBlock:) forControlEvents:controlEvents];
}

@end