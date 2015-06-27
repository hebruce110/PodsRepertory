//
//  Created by Bruce on 15/2/10.
//  Copyright (c) 2015年 http://heyuan110.com. All rights reserved.
//

#import "VUIImageView+ActivityView.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

static CGFloat const kActivityViewWidth = 30.0f;
static NSString * const kUIImageViewLoadingAnimationKey = @"rotationAnimation";
#define kUIActivityIndicatorViewTag 99

@implementation VActivityView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfigure];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigure];
    }
    return self;
}

- (void)initConfigure
{
    [self addSizeConstraint];
    [self setActivityViewType:VActivityViewTypeGray];
    [self addObserver];
}

- (void)setActivityViewType:(VActivityViewType)type
{
    switch (type) {
        case VActivityViewTypeBlack:
            self.image =[UIImage imageNamed:@"loading_black"];
            break;
        case VActivityViewTypeGray:
            self.image =[UIImage imageNamed:@"loading_gray"];
            break;
        case VActivityViewTypeWhite:
            self.image =[UIImage imageNamed:@"loading_white"];
            break;
        default:
            self.image =[UIImage imageNamed:@"loading_white"];
            break;
    }
}

- (void)beginAnimating
{
    CAAnimation *animation = [self.layer animationForKey:kUIImageViewLoadingAnimationKey];
    if (animation) {
        return;
    }
    [self.layer removeAnimationForKey:kUIImageViewLoadingAnimationKey];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * -2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    [self.layer addAnimation:rotationAnimation forKey:kUIImageViewLoadingAnimationKey];
}

- (void)endAnimating
{
    [self.layer removeAnimationForKey:kUIImageViewLoadingAnimationKey];
    [self removeFromSuperview];
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginAnimating) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addSizeConstraint
{
    [self removeConstraints:self.constraints];
    
    //disable AutoresizingMask to constraints
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *currentView = self;
    NSArray *heightConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[currentView(==kActivityViewWidth@999)]" options:0 metrics:@{@"kActivityViewWidth":@(kActivityViewWidth)} views:NSDictionaryOfVariableBindings(currentView)];
    NSArray *widthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[currentView(==kActivityViewWidth@999)]" options:0 metrics:@{@"kActivityViewWidth":@(kActivityViewWidth)} views:NSDictionaryOfVariableBindings(currentView)];
    [self addConstraints:heightConstraints];
    [self addConstraints:widthConstraints];
    [self layoutIfNeeded];
}

@end

@implementation UIImageView(UIImageView_Loading)
@dynamic loadingViewCategory;
@dynamic activityViewType;

- (VLoadingViewCategory )loadingViewCategory {
    id objc = objc_getAssociatedObject(self, @selector(loadingViewCategory));
    if (!objc) {
        return VLoadingViewCategoryCustom;
    }
    return (VLoadingViewCategory)[objc intValue];
}

- (void)setLoadingViewCategory:(VLoadingViewCategory)type {
    objc_setAssociatedObject(self, @selector(loadingViewCategory), @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (VActivityViewType )activityViewType {
    id objc = objc_getAssociatedObject(self, @selector(activityViewType));
    if (!objc) {
        return VActivityViewTypeGray;
    }
    return (VActivityViewType)[objc intValue];
}

- (void)setActivityViewType:(VActivityViewType)type {
    objc_setAssociatedObject(self, @selector(activityViewType), @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)sd_setImageWithURL:(NSURL *)url animated:(BOOL)animated
{
    [self sd_setImageWithURL:url completed:nil animated:animated];
}

- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                  animated:(BOOL)animated
{
    [self sd_setImageWithURL:url placeholderImage:placeholder completed:nil animated:animated];
}

- (void)sd_setImageWithURL:(NSURL *)url
                 completed:(void(^)(BOOL isFinished))completeBlock
                  animated:(BOOL)animated
{
    [self sd_setImageWithURL:url placeholderImage:nil completed:completeBlock animated:animated];
}

- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                 completed:(void(^)(BOOL isFinished))completeBlock
                  animated:(BOOL)animated
{
    UIView *activityView = [self viewWithTag:kUIActivityIndicatorViewTag];
    VLoadingViewCategory loadingViewType = self.loadingViewCategory;
    if (animated) {
        VActivityViewType type = self.activityViewType;
        if (!activityView) {
            if (loadingViewType == VLoadingViewCategoryCustom) {
                activityView = [[VActivityView alloc]initWithFrame:CGRectZero];
                [(VActivityView *)activityView setActivityViewType:type];
            }else {
                UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleGray;
                if (type == VActivityViewTypeGray) {
                    style = UIActivityIndicatorViewStyleGray;
                }else if(type == VActivityViewTypeWhite) {
                    style = UIActivityIndicatorViewStyleWhite;
                }else if(type == VActivityViewTypeWhiteLarge) {
                    style = UIActivityIndicatorViewStyleWhiteLarge;
                }
                activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:style];
                activityView.translatesAutoresizingMaskIntoConstraints = NO;
            }
            activityView.tag = kUIActivityIndicatorViewTag;
            [self addSubview:activityView];
            
            //add constrain and set activity view to center
            NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:activityView
                                                                                 attribute:NSLayoutAttributeCenterY
                                                                                multiplier:1
                                                                                  constant:0];
            
            NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:activityView
                                                                                 attribute:NSLayoutAttributeCenterX
                                                                                multiplier:1
                                                                                  constant:0];
            [self addConstraints:@[centerYConstraint,centerXConstraint]];
            [self layoutIfNeeded]; //update layout
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (loadingViewType == VLoadingViewCategoryCustom) {
                [(VActivityView *)activityView beginAnimating];
            }else{
                [(UIActivityIndicatorView *)activityView startAnimating];
            }
        });
    }
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (image && cacheType == SDImageCacheTypeNone) {
                           self.alpha = 0.0;
                           [UIView animateWithDuration:0.35 animations:^{
                               self.alpha = 1.0;
                           }completion:^(BOOL finished) {
                               if (completeBlock) {
                                   completeBlock(finished);
                               }
                           }];
                       }else{
                           if (completeBlock) {
                               completeBlock(YES);
                           }
                       }
                       dispatch_async(dispatch_get_main_queue(), ^{
                           if (animated) {
                               if (loadingViewType == VLoadingViewCategoryCustom) {
                                   [(VActivityView *)activityView endAnimating];
                               }else{
                                   [(UIActivityIndicatorView *)activityView stopAnimating];
                               }
                           }
                       });
                   }];
}

@end
