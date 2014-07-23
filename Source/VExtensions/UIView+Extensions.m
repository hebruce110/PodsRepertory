//
//  UIAlertView+AlertUtils.m
//  SmartRebate
//
//  Created by Yuan on 13-2-28.
//  Copyright (c) 2013年 unionpaysmart.com. All rights reserved.
//

#import "UIView+Extensions.h"


@implementation UIView (UIViewExtension)

-(CGFloat)x
{
    return self.frame.origin.x;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setX:(CGFloat)x
{
    CGRect f = self.frame;
    f.origin.x = x;
    self.frame = f;
}

-(void)setY:(CGFloat)y
{
    CGRect f = self.frame;
    f.origin.y = y;
    self.frame = f;
}

- (CGFloat)left {
    return self.frame.origin.x;
}


- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)top {
    return self.frame.origin.y;
}


- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)centerX {
    return self.center.x;
}


- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)centerY {
    return self.center.y;
}


- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height {
    return self.frame.size.height;
}


- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGFloat)screenX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


- (CGFloat)screenY {
    CGFloat y = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}


- (CGFloat)screenViewX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


- (CGPoint)origin {
    return self.frame.origin;
}


- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)size {
    return self.frame.size;
}


- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (CGFloat)orientationWidth {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.height : self.width;
}


- (CGFloat)orientationHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.width : self.height;
}


- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0.0f, y = 0.0f;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}


#pragma mark 给View添加圆角

//给view添加圆角效果
- (void)roundCorners:(UIRectCorner)corners radii:(CGFloat)radii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (UITableViewCell *)parentTableViewCell;
{
    UITableViewCell *cell = nil;
    UIView *view = self;
    while(view != nil) {
        if([view isKindOfClass:[UITableViewCell class]]) {
            cell = (UITableViewCell *)view;
            break;
        }
        view = [view superview];
    }
    return cell;
}

- (UIViewController*)getViewController{
    for (UIView* next = [self superview]; next; next = next.superview){
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void) stringTag:(NSString *)tag
{
    [self setTag:[tag hash]];
}

-(UIView *)viewWithStringTag:(NSString *)tag
{
    return [self viewWithTag:[tag hash]];
}

@end


#define UIView_FONT_NORMAL [UIFont systemFontOfSize:16.0]

//为块声明静态存储空间
static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;

@implementation UIAlertView (UIAlertView_AlertUtils)

#pragma mark 显示UIAlertView的不同方法

+(void)showAlertTitle:(NSString*)title
              message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
    [alert show];
}

+(void)showAlertTitle:(NSString*)title
              message:(NSString *)msg
             delegate:(id)d
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
    alert.delegate = d;
    [alert show];
}

+(void)showAlertTitle:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
    [alert show];
}

+(void)showAlertTitle:(NSString*)msg
             delegate:(id)d
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
    alert.delegate = d;
    [alert show];
}

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                      otherButtonTitles:(NSArray*)otherButtons
                              onDismiss:(DismissBlock)dismissed
                               onCancel:(CancelBlock)cancelled
{
    _cancelBlock  = [cancelled copy];
    _dismissBlock  = [dismissed copy];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self self]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    for(NSString *buttonTitle in otherButtons){
        [alert addButtonWithTitle:buttonTitle];
    }
    [alert show];
    return alert;
}

//处理UIAlertViewDelegate
+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [alertView cancelButtonIndex]){
        _cancelBlock();
    }else{
        _dismissBlock(buttonIndex - 1); // cancel button is button 0
    }
}


@end


@implementation UIButton (UIButton_Utils)

#pragma mark 创建UIButton的不同方法

//创建UIButton
+(UIButton *)createButton:(CGRect)rect
                   action:(SEL)sel
                 delegate:(id)delegate
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:UIView_FONT_NORMAL];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+(UIButton *)createButton:(CGRect)rect
                   action:(SEL)sel
                 delegate:(id)delegate
              normalImage:(UIImage *)normalImage
         highlightedImage:(UIImage *)highlightedImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor clearColor];
    [btn setFrame:rect];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+(UIButton *)createButton:(CGRect)rect
                   action:(SEL)sel
                 delegate:(id)delegate
              normalImage:(UIImage *)normalImage
         highlightedImage:(UIImage *)highlightedImage
                    title:(NSString *)title
                     font:(UIFont *)font
                    color:(UIColor *)color

{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor clearColor];
    [btn setFrame:rect];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font=font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateHighlighted];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+(UIButton *)createButton:(CGRect)rect
                   action:(SEL)sel
                 delegate:(id)delegate
    normalBackgroundImage:(UIImage *)normalImage
highlightedBackgroundImage:(UIImage *)highlightedImage
                    title:(NSString *)title
                     font:(UIFont *)font
                    color:(UIColor *)color

{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor clearColor];
    [btn setFrame:rect];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    btn.titleLabel.font=font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateHighlighted];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+(UIButton *)createButton:(CGRect)rect
                   action:(SEL)sel
                 delegate:(id)delegate
                    title:(NSString *)title
                     font:(UIFont *)font
               titleColor:(UIColor *)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor clearColor];
    [btn setFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    btn.titleLabel.font=font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateHighlighted];
    if (delegate && [delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

//创建UIButton
+(UIButton *)createButton:(CGRect)rect
                   action:(SEL)sel
                 delegate:(id)delegate
                     type:(UIButtonType)type
{
    UIButton *btn = [UIButton buttonWithType:type];
    [btn setFrame:rect];
    [btn.titleLabel setFont:UIView_FONT_NORMAL];
    if ([delegate respondsToSelector:sel]) {
        [btn addTarget:delegate action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

@end


@implementation UILabel (UILabel_Utils)

#pragma mark 创建UILabel

//创建UILabel
+(UILabel *)createLable:(CGRect)rect
{
    UILabel *lbl = [[UILabel alloc]initWithFrame:rect];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = UIView_FONT_NORMAL;
    lbl.textColor = [UIColor blackColor];
    return lbl;
}

+(UILabel *)createLable:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label=[[UILabel alloc] initWithFrame:rect];
    label.text=text;
    label.font=font;
    label.textColor=color;
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=textAlignment;
    return label;
}

+(UILabel *)createLable:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color  textAlignment:(NSTextAlignment)textAlignment shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)size
{
    UILabel *label=[[UILabel alloc] initWithFrame:rect];
    label.text=text;
    label.font=font;
    label.textColor=color;
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=textAlignment;
    label.shadowColor=shadowColor;
    label.shadowOffset=size;
    return label;
}

@end


@implementation UITextField (UITextField_Utils)

#pragma mark 创建UITextField

//创建UITextField
+(UITextField *)createTextField:(CGRect)rect
{
    UITextField *txtField = [[UITextField alloc]initWithFrame:rect];
    txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtField.borderStyle = UITextBorderStyleRoundedRect;
    txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtField.font = UIView_FONT_NORMAL;
    txtField.textColor = [UIColor blackColor];
    return txtField;
}

+(UITextField *)createTextField:(CGRect)rect placeholder:(NSString *)placeholder delegate:(id)delegate font:(UIFont *)font textColor:(UIColor *)color
{
    UITextField *textField = [[UITextField alloc]initWithFrame:rect];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = font;
    textField.textColor = color;
    textField.placeholder=placeholder;
    textField.delegate=delegate;
    return textField;
}

@end

@implementation UITextView (UITextView_Utils)

#pragma mark 创建UITextView

//创建UITextView
+(UITextView *)createUITextView:(CGRect)rect delegate:(id)delegate font:(UIFont *)font textColor:(UIColor *)color
{
    UITextView *textView=[[UITextView alloc] initWithFrame:rect];
    textView.delegate=delegate;
    textView.font=font;
    textView.textColor=color;
    textView.backgroundColor=[UIColor clearColor];
    return textView;
}

@end


@implementation UITableView(UITableView_Extension)

- (NSIndexPath *)indexPathForTapedView:(UIView *)tapedView
{
    CGPoint correctedPoint = [tapedView convertPoint:tapedView.bounds.origin
                                              toView:self];
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:correctedPoint];
    return indexPath;
}

- (UITableViewCell *)cellForTapedView:(UIView *)tapedView
{
    return [self cellForRowAtIndexPath:[self indexPathForTapedView:tapedView]];
}

@end









