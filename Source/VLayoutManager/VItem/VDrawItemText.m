//
//  PKDrawItemText.m
//  Vote
//
//  Created by yuan on 13-12-30.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//

#import "VDrawItemText.h"

@implementation VDrawItemText

- (id)initWithString:(NSString *)string
                font:(UIFont *)font
               color:(UIColor *)color;
{
    self = [super init];
    if (self) {
        [self setString:string font:font color:color];
        self.lineBreakMode = NSLineBreakByCharWrapping;
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (void)setString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;
{
    self.string = string;
    self.font = font;
    self.color = color;
}

@end
