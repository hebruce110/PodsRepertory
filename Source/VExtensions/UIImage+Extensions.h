//
//  UIImage+Extensions.h
//  VExtensions
//
//  Created by yuan on 14-6-6.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (UIImage_Extensions)

/**
 *  重画图片
 *
 *  @param rect 重画的图片大小
 *
 *  @return 图片
 */
- (UIImage*)resizedImage:(CGRect)rect;

/**
 *  创建图片的缩略图，正方形
 *
 *  @param thumbSize 缩略图大小
 *
 *  @return 缩略图
 */
- (UIImage *)createThumbImage:(CGFloat)thumbSize;


/**
 *  创建缩略图，和原来图片是相同比例的
 *
 *  @param maxThumbSize 尺寸
 *
 *  @return 缩略图
 */
- (UIImage *)createScaleThumbImage:(CGSize)maxThumbSize;

/*!
 *  @brief Resized image by given size.
 *  @param size The size to resize.
 *  @return An UIImage object containing a resized image from the image.
 *  @details This method depends on CoreGraphics.
 */
- (UIImage *)imageByResizingToSize:(CGSize)size;

/*!
 *  @brief Color filled image with given color.
 *  @param color The color to fill
 *  @details This method depends on CoreGraphics.
 */
- (UIImage *)imageByFilledWithColor:(UIColor *)color;

/*!
 *  @brief Colored image by given size.
 *  @param color The color to fill.
 *  @param size The image size to create.
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/*!
 *  @brief Clear colored image.
 */
+ (UIImage *)clearImage;

/*!
 *  @brief Image drawn with bazier path.
 *  @param path The bezier path to draw.
 *  @param color The stroke color for bezier path.
 *  @param backgroundColor The fill color for bezier path.
 */
+ (UIImage *)imageWithBezierPath:(UIBezierPath *)path color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;

//将view转成image
+ (UIImage *)convertViewToImage:(UIView*)view;

//解决图片拍完上传后出现旋转
- (UIImage *)fixOrientation;

+ (NSData *)compressImageData:(UIImage *)originImage
              initCompression:(CGFloat)compression
                      maxSize:(int64_t)size;


/**
 *	@brief	merge two images at special zoom
 *
 *	@param 	incoming 	to be merged image
 *	@param 	original 	original image
 *	@param 	zoom 	rect
 *
 *	@return	the merged image
 */
+ (UIImage *)mergeImage:(UIImage*)incoming
                toImage:(UIImage*)original
                 atZoom:(CGRect)zoom;

@end

/*!
 *  @brief [UIImage][1] generator for [UIColor][0].
 *      [0]: http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIImage_Class/Reference/Reference.html
 *      [1]: http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIColor_Class/Reference/Reference.html
 */
@interface UIColor (UIImage)

/*!
 *  @brief Colored image sized as given size.
 *  @param size The image size to create.
 */
- (UIImage *)imageOfSize:(CGSize)size;

/*!
 *  @brief Colored image sized 1x1
 */
- (UIImage *)image;

@end



/*!
 *  @brief [UIBezierPath][0] extension for [UIImage][1] creation.
 *      [0]: http://developer.apple.com/library/ios/#documentation/uikit/reference/UIBezierPath_class/Reference/Reference.html
 *      [1]: http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIImage_Class/Reference/Reference.html
 */
@interface UIBezierPath (UIImage)

/*!
 *  @brief Image drawn with bazier path.
 *  @param strokeColor The stroke color for bezier path.
 *  @param fillColor The fill color for bezier path.
 */
- (UIImage *)imageWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor;

/*!
 *  @brief Image drawn with bazier path.
 *  @param strokeColor The stroke color for bezier path.
 */
- (UIImage *)imageWithStrokeColor:(UIColor *)strokeColor;

/*!
 *  @brief Image drawn with bazier path.
 *  @param fillColor The fill color for bezier path.
 */
- (UIImage *)imageWithFillColor:(UIColor *)fillColor;

@end



