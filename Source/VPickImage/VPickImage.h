//
//  PPPickImage.h
//  PatPat
//
//  Created by patpat on 15/4/26.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PickImageCallBackBlock)(UIImage *image,NSInteger index);

@interface VPickImage : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (void)showActionSheet:(PickImageCallBackBlock)selectedImageBlock
               delegate:(UIViewController *)vc
             sourceView:(UIView*)sourceView;

- (void)showActionSheet:(PickImageCallBackBlock)selectedImageBlock
                 isEdit:(BOOL)edit
               delegate:(UIViewController *)vc
             sourceView:(UIView*)sourceView;

@end
