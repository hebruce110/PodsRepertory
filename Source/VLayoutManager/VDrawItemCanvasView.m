//
//  VDrawItemView.m
//  Vote
//
//  Created by Yuan on 14-4-23.
//  Copyright (c) 2014年 Yuan.He. All rights reserved.
//

#import "VDrawItemCanvasView.h"

static CGFloat  kDrawItemOutSetOffSetValue = 2.0;

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
                CGContextSetFillColorWithColor(context, item.handleTouchColor.CGColor);
                CGContextAddRect(context,item.rect);
                CGContextFillPath(context);
            }
            CGContextSetFillColorWithColor(context, textItem.color.CGColor);
            [textItem.string drawInRect:textItem.rect withFont:textItem.font lineBreakMode:textItem.lineBreakMode alignment:textItem.textAlignment];
        }else if([item isKindOfClass:[VDrawItemImage class]]){
            VDrawItemImage *imageItem = (VDrawItemImage *)item;
            /*
             Core Graphics来绘制简单图像，通过UIImage不能访问整个Core Graphics库，但也提供了5个方法来像Core Graphics那样工作：
             drawAsPatternInRect：在矩形内绘制图像，图像不缩放，必要时将平铺
             drawAtPoint：在左上角位于CGPoint指定位置开始绘制图像
             drawAtPoint：blendMode：alpha：drawAtPoint的复杂版本，可以指定图片透明度等
             drawInRect：在CGRect内绘制图像，并相应的缩放
             drawInRect：blendMode：alpha：drawInRect的复杂版本
             */
            if (imageItem.image) {
                [imageItem.image drawInRect:imageItem.rect];
//                [imageItem.image drawAtPoint:imageItem.rect.origin];
            }else{
                UIImage *image = PKImage(imageItem.imageName);
                [image drawInRect:imageItem.rect];
            }
        }else if([item isKindOfClass:[VDrawItemView class]]){
            VDrawItemView *viewItem = (VDrawItemView *)item;
            CGContextSetFillColorWithColor(context,viewItem.backgroundColor.CGColor);
            if (viewItem.cornerRadius >0 ||  viewItem.isFill || viewItem.strokeLineWidth>0) {
                UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:viewItem.rect cornerRadius:viewItem.cornerRadius];
                if (viewItem.isFill){
                    [bezierPath fill];
                }
                if (viewItem.strokeLineWidth>0) {
                    CGContextSetLineWidth(context, viewItem.strokeLineWidth);
                    CGContextSetStrokeColorWithColor(context, viewItem.strokeLineColor.CGColor);
                    [bezierPath stroke];
                }
            }else{
                CGContextAddRect(context,item.rect);
                CGContextFillPath(context);
            }
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
















