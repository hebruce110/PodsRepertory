//
//  UIImage+Extensions.m
//  VExtensions
//
//  Created by yuan on 14-6-6.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "UIImage+Extensions.h"

@implementation UIImage (UIImage_Extensions)

//resize图片
- (UIImage*)resizedImage:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

//创建缩略图
- (UIImage *)createThumbImage:(CGSize)maxThumbSize
{
    CGSize imageSize = self.size;// The image size, for example {1024,768}
    CGFloat thumbAspectRatio = maxThumbSize.width / maxThumbSize.height;
    CGFloat imageAspectRatio = imageSize.width / imageSize.height;
    CGRect rect = CGRectZero;
    if ( imageAspectRatio == thumbAspectRatio ){
        rect.size = maxThumbSize;
        // The aspect ratio is equal
        // Resize image to maxThumbSize
    }else if ( imageAspectRatio > thumbAspectRatio ){
        // The image is wider
        // Thumbnail width: maxThumbSize.width
        // Thumbnail height: maxThumbSize.height / imageAspectRatio
        rect.size.width = maxThumbSize.width;
        rect.size.height = maxThumbSize.height/imageAspectRatio;
    }
    else if ( imageAspectRatio < thumbAspectRatio ){
        // The image is taller
        // Thumbnail width: maxThumbSize.width * imageAspectRatio
        // Thumbnail height: maxThumbSize.height
        rect.size.width = maxThumbSize.width*imageAspectRatio;
        rect.size.height = maxThumbSize.height;
    }
    UIImage *thumbnailImage =[self resizedImage:rect];
    return thumbnailImage;
}


- (UIImage *)imageByResizingToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    [self drawInRect:CGRectMake(.0, .0, size.width, size.height)];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

- (UIImage *)imageByFilledWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, .0);
    [color set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = CGRectZero;
    bounds.size = self.size;
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, bounds, self.CGImage);
    CGContextFillRect(context, bounds);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)clearImage {
    static UIImage *image = nil;
    if (image == nil) {
        image = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(1.0, 1.0)];
    }
    return image;
}

+ (UIImage *)imageWithBezierPath:(UIBezierPath *)path color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor {
    UIGraphicsBeginImageContextWithOptions((CGSizeMake(path.bounds.origin.x * 2 + path.bounds.size.width, path.bounds.origin.y * 2 + path.bounds.size.height)), NO, .0);
    
    if (backgroundColor) {
        [backgroundColor set];
        [path fill];
    }
    if (color) {
        [color set];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)convertViewToImage:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end

@implementation UIColor (UIImage)

- (UIImage *)imageOfSize:(CGSize)size {
    return [UIImage imageWithColor:self size:size];
}

- (UIImage *)image {
    return [self imageOfSize:CGSizeMake(1.0, 1.0)];
}

@end

@implementation UIBezierPath (UIImage)

- (UIImage *)imageWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor {
    return [UIImage imageWithBezierPath:self color:strokeColor backgroundColor:fillColor];
}

- (UIImage *)imageWithStrokeColor:(UIColor *)strokeColor {
    return [self imageWithStrokeColor:strokeColor fillColor:nil];
}

- (UIImage *)imageWithFillColor:(UIColor *)fillColor {
    return [self imageWithStrokeColor:nil fillColor:fillColor];
}

@end





