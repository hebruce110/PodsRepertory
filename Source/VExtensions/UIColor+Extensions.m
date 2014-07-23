//
//  UIColor+Extensions.m
//  VExtensions
//
//  Created by Yuan on 14-6-16.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (UIColor_Extensions)

+ (UIColor *)lightRandom
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 );  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


#pragma mark Private

+ (NSDictionary *)standardColors
{
    static NSDictionary *colors = nil;
    if (colors == nil)
    {
        colors = [[NSDictionary alloc] initWithObjectsAndKeys:
                  [UIColor blackColor], @"black", // 0.0 white
                  [UIColor darkGrayColor], @"darkgray", // 0.333 white
                  [UIColor lightGrayColor], @"lightgray", // 0.667 white
                  [UIColor whiteColor], @"white", // 1.0 white
                  [UIColor grayColor], @"gray", // 0.5 white
                  [UIColor redColor], @"red", // 1.0, 0.0, 0.0 RGB
                  [UIColor greenColor], @"green", // 0.0, 1.0, 0.0 RGB
                  [UIColor blueColor], @"blue", // 0.0, 0.0, 1.0 RGB
                  [UIColor cyanColor], @"cyan", // 0.0, 1.0, 1.0 RGB
                  [UIColor yellowColor], @"yellow", // 1.0, 1.0, 0.0 RGB
                  [UIColor magentaColor], @"magenta", // 1.0, 0.0, 1.0 RGB
                  [UIColor orangeColor], @"orange", // 1.0, 0.5, 0.0 RGB
                  [UIColor purpleColor], @"purple", // 0.5, 0.0, 0.5 RGB
                  [UIColor brownColor], @"brown", // 0.6, 0.4, 0.2 RGB
                  [UIColor clearColor], @"clear", // 0.0 white, 0.0 alpha
                  nil];
    }
    return colors;
}

- (void)getColorComponents:(CGFloat *)rgba
{
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    switch (model)
    {
        case kCGColorSpaceModelMonochrome:
        {
            rgba[0] = components[0];
            rgba[1] = components[0];
            rgba[2] = components[0];
            rgba[3] = components[1];
            break;
        }
        case kCGColorSpaceModelRGB:
        {
            rgba[0] = components[0];
            rgba[1] = components[1];
            rgba[2] = components[2];
            rgba[3] = components[3];
            break;
        }
        default:
        {
            
#ifdef DEBUG
            
            //unsupported format
            NSLog(@"Unsupported color model: %i", model);
#endif
            rgba[0] = 0.0f;
            rgba[1] = 0.0f;
            rgba[2] = 0.0f;
            rgba[3] = 1.0f;
            break;
        }
    }
}

#pragma mark Public

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) colorWithHexString:(NSString *) stringToConvert alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)colorWithStringValue:(NSString *)string
{
    //convert to lowercase
    string = [string lowercaseString];
    
    //try standard colors first
    UIColor *color = [[UIColor standardColors] objectForKey:string];
    if (color)
    {
        return color;
    }
    
    //create new instance
    return [[self alloc] initWithString:string];
}

+ (UIColor *)colorWithRGBValue:(NSInteger)rgb
{
    return [[UIColor alloc] initWithRGBValue:rgb];
}

+ (UIColor *)colorWithRGBAValue:(NSUInteger)rgba
{
    return [[UIColor alloc] initWithRGBAValue:rgba];
}

- (UIColor *)initWithString:(NSString *)string
{
    //convert to lowercase
    string = [string lowercaseString];
    
    //try standard colors
    UIColor *color = [[UIColor standardColors] objectForKey:string];
    if (color)
    {
        //        self = [color retain];
        return self;
    }
    
    //try hex
    string = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    switch ([string length])
    {
        case 0:
        {
            string = @"00000000";
            break;
        }
        case 3:
        {
            NSString *red = [string substringWithRange:NSMakeRange(0, 1)];
            NSString *green = [string substringWithRange:NSMakeRange(1, 1)];
            NSString *blue = [string substringWithRange:NSMakeRange(2, 1)];
            string = [NSString stringWithFormat:@"%1$@%1$@%2$@%2$@%3$@%3$@ff", red, green, blue];
            break;
        }
        case 6:
        {
            string = [string stringByAppendingString:@"ff"];
            break;
        }
        case 8:
        {
            //do nothing
            break;
        }
        default:
        {
            
#ifdef DEBUG
            
            //unsupported format
            NSLog(@"Unsupported color string format: %@", string);
#endif
            return nil;
        }
    }
    uint32_t rgba;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanHexInt:&rgba];
    return [self initWithRGBAValue:rgba];
}

- (UIColor *)initWithRGBValue:(NSInteger)rgb
{
    CGFloat red = ((rgb & 0xFF0000) >> 16) / 255.0f;
	CGFloat green = ((rgb & 0x00FF00) >> 8) / 255.0f;
	CGFloat blue = (rgb & 0x0000FF) / 255.0f;
	return [self initWithRed:red green:green blue:blue alpha:1.0f];
}

- (UIColor *)initWithRGBAValue:(NSUInteger)rgba
{
    CGFloat red = ((rgba & 0xFF000000) >> 24) / 255.0f;
    CGFloat green = ((rgba & 0x00FF0000) >> 16) / 255.0f;
	CGFloat blue = ((rgba & 0x0000FF00) >> 8) / 255.0f;
	CGFloat alpha = (rgba & 0x000000FF) / 255.0f;
	return [self initWithRed:red green:green blue:blue alpha:alpha];
}

- (NSInteger)RGBValue
{
    CGFloat rgba[4];
    [self getColorComponents:rgba];
    uint8_t red = rgba[0]*255;
    uint8_t green = rgba[1]*255;
    uint8_t blue = rgba[2]*255;
    return (red << 16) + (green << 8) + blue;
}

- (NSUInteger)RGBAValue
{
    CGFloat rgba[4];
    [self getColorComponents:rgba];
    uint8_t red = rgba[0]*255;
    uint8_t green = rgba[1]*255;
    uint8_t blue = rgba[2]*255;
    uint8_t alpha = rgba[3]*255;
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

- (NSString *)stringValue
{
    //try standard colors
    NSInteger index = [[[UIColor standardColors] allValues] indexOfObject:self];
    if (index != NSNotFound)
    {
        return [[[UIColor standardColors] allKeys] objectAtIndex:index];
    }
    
    //convert to hex
    if (self.alpha < 1.0f)
    {
        //include alpha component
        return [NSString stringWithFormat:@"#%.8x", self.RGBAValue];
    }
    else
    {
        //don't include alpha component
        return [NSString stringWithFormat:@"#%.6x", self.RGBValue];
    }
}

- (CGFloat)red
{
    CGFloat rgba[4];
    [self getColorComponents:rgba];
	return rgba[0];
}

- (CGFloat)green
{
    CGFloat rgba[4];
    [self getColorComponents:rgba];
	return rgba[1];
}

- (CGFloat)blue
{
    CGFloat rgba[4];
    [self getColorComponents:rgba];
	return rgba[2];
}

- (CGFloat)alpha
{
    return CGColorGetAlpha(self.CGColor);
}

- (BOOL)isMonochromeOrRGB
{
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    return model == kCGColorSpaceModelMonochrome || model == kCGColorSpaceModelRGB;
}

- (BOOL)isEquivalent:(id)object
{
    if ([object isKindOfClass:[UIColor class]])
    {
        return [self isEquivalentToColor:object];
    }
    return NO;
}

- (BOOL)isEquivalentToColor:(UIColor *)color;
{
    if ([self isMonochromeOrRGB] && [color isMonochromeOrRGB])
    {
        return self.RGBAValue == color.RGBAValue;
    }
    return [self isEqual:color];
}

@end
