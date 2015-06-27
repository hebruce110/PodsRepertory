//
//  PPUIView+Extension.m
//  PatPat
//
//  Created by Yuan on 15/2/10.
//  Copyright (c) 2015年 interfocusllc.com. All rights reserved.
//

#import "PPUIView+Extension.h"

@implementation UIImageView(UIImageView_Loading)

- (void)layoutSubviews
{
    [super layoutSubviews];
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[self viewWithTag:kUIActivityIndicatorViewTag];
    if (activityView) {
        [activityView setCenter:CGPointMake(self.width/2, self.height/2)];
    }
}

- (void)loadingImageURL:(NSURL *)url
{
    [self loadingImageURL:url completed:nil];
}

- (void)loadingImageURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
{
    [self loadingImageURL:url placeholderImage:placeholder completed:nil];
}

- (void)loadingImageURL:(NSURL *)url
              completed:(void(^)(BOOL isFinished))completeBlock
{
    [self loadingImageURL:url placeholderImage:nil completed:completeBlock];
}

- (void)loadingImageURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
              completed:(void(^)(BOOL isFinished))completeBlock
{
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[self viewWithTag:kUIActivityIndicatorViewTag];
    if (!activityView) {
        activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.tag = kUIActivityIndicatorViewTag;
        [self addSubview:activityView];
    }
    activityView.hidden = NO;
    [activityView setFrame:CGRectMake((self.frame.size.width - activityView.frame.size.width) / 2 , (self.frame.size.height - activityView.frame.size.height) / 2 , activityView.frame.size.width , activityView.frame.size.width)];
    [activityView startAnimating];
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
                       [activityView stopAnimating];
                       [activityView setHidden:YES];
                   }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
