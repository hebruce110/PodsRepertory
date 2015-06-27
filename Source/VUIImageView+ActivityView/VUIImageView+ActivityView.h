//
//
//  Created by Bruce on 15/2/10.
//  Copyright (c) 2015年 http://heyuan110.com. All rights reserved.
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

@property (nonatomic, assign) VLoadingViewCategory loadingViewCategory; //set loading view category,default custom
@property (nonatomic, assign) VActivityViewType activityViewType; //set activityview type, default gray

/**
 * Set the imageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param animated       loading animation.
 */
- (void)sd_setImageWithURL:(NSURL *)url
                  animated:(BOOL)animated;

/**
 * Set the imageView `image` with an `url`, placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param placeholder    The image to be set initially, until the image request finishes.
 * @param animated       loading animation.
 */
- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                  animated:(BOOL)animated;

/**
 * Set the imageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrived from the local cache of from the network.
 *                       The forth parameter is the original image url.
 * @param animated       loading animation.
 */
- (void)sd_setImageWithURL:(NSURL *)url
                 completed:(void(^)(BOOL isFinished))completeBlock
                  animated:(BOOL)animated;

/**
 * Set the imageView `image` with an `url`, placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param placeholder    The image to be set initially, until the image request finishes.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrived from the local cache of from the network.
 *                       The forth parameter is the original image url.
 * @param animated       loading animation.
 */
- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                 completed:(void(^)(BOOL isFinished))completeBlock
                  animated:(BOOL)animated;

@end



