//
//  PPUIView+Extension.h
//  PatPat
//
//  Created by Yuan on 15/2/10.
//  Copyright (c) 2015年 interfocusllc.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUIActivityIndicatorViewTag 99

@interface UIImageView(UIImageView_Loading)

- (void)loadingImageURL:(NSURL *)url;

- (void)loadingImageURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder;

- (void)loadingImageURL:(NSURL *)url
              completed:(void(^)(BOOL isFinished))completeBlock;

- (void)loadingImageURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
              completed:(void(^)(BOOL isFinished))completeBlock;

@end
