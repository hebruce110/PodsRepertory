//
//  UIAlertView+AlertUtils.h
//  SmartRebate
//
//  Created by Yuan on 13-2-28.
//  Copyright (c) 2013年 unionpaysmart.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewExtension)

-(CGFloat)x;

-(CGFloat)y;

-(CGFloat)width;

-(CGFloat)height;

-(void)setX:(CGFloat)x;

-(void)setY:(CGFloat)y;

-(void)setWidth:(CGFloat)width;

-(void)setHeight:(CGFloat)height;

//添加圆角
- (void)roundCorners:(UIRectCorner)corners radii:(CGFloat)radii;

//由view获得view所在的cell，没有返回nil
- (UITableViewCell *)parentTableViewCell;

//从view获得view所在的controller
- (UIViewController*)getViewController;

@end

//用typedef定义DismissBlock和CancelBlock
typedef void (^DismissBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (UIAlertView_AlertUtils)

+(void)showAlertTitle:(NSString*)title message:(NSString *)msg;

+(void)showAlertTitle:(NSString*)title message:(NSString *)msg delegate:(id)d;

+(void)showAlertTitle:(NSString*)msg;

+(void)showAlertTitle:(NSString*)msg delegate:(id)d;

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                      otherButtonTitles:(NSArray*)otherButtons
                              onDismiss:(DismissBlock)dismissed
                               onCancel:(CancelBlock)cancelled;

@end

@interface UIButton (UIButton_Utils)

+(UIButton *)createButton:(CGRect)rect action:(SEL)sel delegate:(id)delegate;

+(UIButton *)createButton:(CGRect)rect action:(SEL)sel delegate:(id)delegate type:(UIButtonType)type;

+(UIButton *)createButton:(CGRect)rect action:(SEL)sel delegate:(id)delegate normalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage;

+(UIButton *)createButton:(CGRect)rect action:(SEL)sel delegate:(id)delegate normalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage title:(NSString *)title font:(UIFont *)font color:(UIColor *)color;

+(UIButton *)createButton:(CGRect)rect action:(SEL)sel delegate:(id)delegate normalBackgroundImage:(UIImage *)normalImage
highlightedBackgroundImage:(UIImage *)highlightedImage title:(NSString *)title font:(UIFont *)font color:(UIColor *)color
;

+(UIButton *)createButton:(CGRect)rect action:(SEL)sel delegate:(id)delegate title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color;
@end

@interface UILabel (UILabel_Utils)

+(UILabel *)createLable:(CGRect)rect;
+(UILabel *)createLable:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;
+(UILabel *)createLable:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color  textAlignment:(NSTextAlignment)textAlignment shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)size;
@end

@interface UITextField (UITextField_Utils)

+(UITextField *)createTextField:(CGRect)rect;

+(UITextField *)createTextField:(CGRect)rect placeholder:(NSString *)placeholder delegate:(id)delegate font:(UIFont *)font textColor:(UIColor *)color;
@end

@interface UITextView (UITextView_Utils)

+(UITextView *)createUITextView:(CGRect)rect delegate:(id)delegate font:(UIFont *)font textColor:(UIColor *)color;

@end

@interface UITableView (UITableView_Extension)
/*根据点击的view来获取indexpath*/
- (NSIndexPath *)indexPathForTapedView:(UIView *)tapedView;

/*根据点击的view来获取cell*/
- (UITableViewCell *)cellForTapedView:(UIView *)tapedView;
@end

