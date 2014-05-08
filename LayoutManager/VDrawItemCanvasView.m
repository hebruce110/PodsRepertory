//
//  VDrawItemView.m
//  Vote
//
//  Created by Yuan on 14-4-23.
//  Copyright (c) 2014年 Yuan.He. All rights reserved.
//

#import "VDrawItemCanvasView.h"

static CGFloat  kDrawItemOutSetOffSetValue = 2.0;

CGFloat	CGRectMaxX( CGRect rect ){
	return rect.origin.x + rect.size.width;
}

CGFloat CGRectMaxY( CGRect rect ){
	return rect.origin.y + rect.size.height;
}

CGRect	CGRectOutset( CGRect rect ,CGFloat dx, CGFloat dy){
	return CGRectMake( floor(rect.origin.x)-dx, floor(rect.origin.y)-dy, floor(rect.size.width)+2*dx, floor(rect.size.height)+2*dy );
}

BOOL CGRectIsInvalid( CGRect r ){
	return isnan(r.origin.x) || isnan(r.origin.y) || isnan(r.size.width) || isnan(r.size.height);
}

@implementation VDrawItemCanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (VDrawItem *item  in _layoutInfo.items) {
        if (item.invalidDraw)continue;
        if ([item isKindOfClass:[VDrawItemText class]] && ![item isKindOfClass:[VDrawItemCoreText class]]) {
            VDrawItemText *textItem = (VDrawItemText *)item;
            if (textItem.userInteractionEnabled && textItem.handleTouch) {
                UIColor *color = textItem.handleTouchColor?textItem.handleTouchColor:[UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.05];
                CGContextSetFillColorWithColor(context,color.CGColor);
                CGContextAddRect(context,CGRectOutset(item.rect, kDrawItemOutSetOffSetValue, 0));
                CGContextFillPath(context);
            }
            CGContextSetFillColorWithColor(context, textItem.color.CGColor);
            [textItem.string drawInRect:textItem.rect withFont:textItem.font lineBreakMode:textItem.lineBreakMode];
        }else if([item isKindOfClass:[VDrawItemImage class]]){
            VDrawItemImage *imageItem = (VDrawItemImage *)item;
            if (imageItem.image) {
                [imageItem.image drawInRect:imageItem.rect];
            }else{
                UIImage *image = PDImage(imageItem.imageName);
                [image drawInRect:imageItem.rect];
            }
//            [image drawAtPoint:imageItem.rect.origin];
        }else if([item isKindOfClass:[VDrawItemView class]]){
            VDrawItemView *viewItem = (VDrawItemView *)item;
            CGContextSetFillColorWithColor(context,viewItem.backgroundColor.CGColor);
            CGContextAddRect(context,item.rect);
            CGContextFillPath(context);
        }
    }
}

- (void)drawLayout:(VLayoutInfo *)layoutInfo
{
    if (![_layoutInfo isEqual:layoutInfo]) {
        _layoutInfo = layoutInfo;
        [self setNeedsDisplay];
    }
}

- (void)drawLayoutRect:(CGRect)rect layoutInfo:(VLayoutInfo *)layoutInfo
{
    _layoutInfo = layoutInfo;
    [self setNeedsDisplayInRect:rect];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint originalLocation = [touch locationInView:self];
    BOOL touchItem = NO;
    for (VDrawItem *item  in _layoutInfo.items) {
        if (item.userInteractionEnabled && CGRectContainsPoint(item.rect, originalLocation)) {
            item.handleTouch = YES;
            [self setNeedsDisplayInRect:CGRectOutset(item.rect,kDrawItemOutSetOffSetValue,0)];
            touchItem = YES;
            break;
        }
    }
    if (!touchItem) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    BOOL touchItem = NO;
    for (VDrawItem *item  in _layoutInfo.items) {
        if (item.userInteractionEnabled && item.handleTouch) {
            item.handleTouch = NO;
            [self setNeedsDisplayInRect:CGRectOutset(item.rect, kDrawItemOutSetOffSetValue, 0)];
            touchItem = YES;
            break;
        }
    }
    if (!touchItem) {
        [super touchesCancelled:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint originalLocation = [touch locationInView:self];
    BOOL touchItem = NO;
    for (VDrawItem *item  in _layoutInfo.items) {
        if (item.userInteractionEnabled && item.handleTouch) {
            item.handleTouch = NO;
            [self setNeedsDisplayInRect:CGRectOutset(item.rect, kDrawItemOutSetOffSetValue, 0)];
            if (CGRectContainsPoint(item.rect, originalLocation)) {
                id target = item.target;
                SEL sel = item.selector;
                if (target && sel){ //callback
                    if ([target respondsToSelector:sel]) {
                        SuppressPerformSelectorLeakWarning([target performSelector:sel withObject:item withObject:self]);
                    }
                }
            }
            touchItem = YES;
            break;
        }
    }
    if (!touchItem) {
        [super touchesEnded:touches withEvent:event];
    }
}

@end
















