//
//  UIColor+Extensions.h
//  VExtensions
//
//  Created by Yuan on 14-6-16.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (UIColor_Extensions)

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;

+ (UIColor *)colorWithStringValue:(NSString *)string;
+(UIColor *) colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)colorWithRGBValue:(int32_t)rgb;
+ (UIColor *)colorWithRGBAValue:(uint32_t)rgba;
- (UIColor *)initWithString:(NSString *)string;
- (UIColor *)initWithRGBValue:(int32_t)rgb;
- (UIColor *)initWithRGBAValue:(uint32_t)rgba;

- (int32_t)RGBValue;
- (uint32_t)RGBAValue;
- (NSString *)stringValue;

- (BOOL)isMonochromeOrRGB;
- (BOOL)isEquivalent:(id)object;
- (BOOL)isEquivalentToColor:(UIColor *)color;

+ (UIColor *)lightRandom;

@end
