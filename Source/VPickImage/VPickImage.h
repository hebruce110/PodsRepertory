//
//  VPickImage.h
//  Vote
//
//  Created by Yuan on 14-4-17.
//  Copyright (c) 2014年 Yuan.He. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PickImageCallBackBlock)(UIImage *image,NSInteger index);

@interface VPickImage : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

- (void)showActionSheet:(PickImageCallBackBlock)selectedImageBlock delegate:(UIViewController *)vc;

- (void)showActionSheet:(PickImageCallBackBlock)selectedImageBlock
                 isEdit:(BOOL)edit
               delegate:(UIViewController *)vc;

- (void)showEditTimeLineTopImageActionSheet:(PickImageCallBackBlock)selectedImageBlock
                                     isEdit:(BOOL)edit
                                   delegate:(UIViewController *)vc;

+ (VPickImage *)sharedVPickImage;

@end
