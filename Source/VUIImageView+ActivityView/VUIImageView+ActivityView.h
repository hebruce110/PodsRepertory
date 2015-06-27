//
//
//  Created by Bruce on 15/2/10.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    VActivityViewTypeWhite,
    VActivityViewTypeWhiteLarge,
    VActivityViewTypeBlack,
    VActivityViewTypeGray
}VActivityViewType;

@interface VActivityView:UIImageView

- (void)setActivityViewType:(VActivityViewType)type;

- (void)beginAnimating;

- (void)endAnimating;

- (void)addSizeConstraint;

@end

#define kUIActivityIndicatorViewTag 99

typedef enum {
    VLoadingViewCategoryCustom,
    VLoadingViewCategorySystem
}VLoadingViewCategory;

@interface UIImageView(UIImageView_Loading)

@property (nonatomic, assign) VLoadingViewCategory loadingViewCategory;
@property (nonatomic, assign) VActivityViewType activityViewType;

- (void)sd_setImageWithURL:(NSURL *)url animated:(BOOL)animated;

- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                  animated:(BOOL)animated;

- (void)sd_setImageWithURL:(NSURL *)url
                 completed:(void(^)(BOOL isFinished))completeBlock
                  animated:(BOOL)animated;

- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                 completed:(void(^)(BOOL isFinished))completeBlock
                  animated:(BOOL)animated;

@end



