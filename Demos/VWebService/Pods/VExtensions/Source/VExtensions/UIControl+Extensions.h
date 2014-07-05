//
//  UIControl+Extensions.h
//  VExtensions
//
//  Created by yuan on 14-6-6.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (UIControl_Extensions)

- (void) addEventHandler:(void(^)(void))handler forControlEvents:(UIControlEvents)controlEvents;

@end