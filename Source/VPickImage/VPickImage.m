//
//  VPickImage.m
//  Vote
//
//  Created by Yuan on 14-4-17.
//  Copyright (c) 2014年 Yuan.He. All rights reserved.
//

#import "VPickImage.h"
#import "VExtensions.h"

@interface VPickImage()
{
    BOOL isEdit;
}
@property (nonatomic,assign)UIViewController *viewController;
@property (nonatomic, copy) PickImageCallBackBlock callBack;
@end

@implementation VPickImage

SINGLETON_GCD(VPickImage);

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}


//show
- (void)showEditTimeLineTopImageActionSheet:(PickImageCallBackBlock)selectedImageBlock
                                     isEdit:(BOOL)edit
                                   delegate:(UIViewController *)vc
{
    NSArray *titles = @[PDString(@"从相册选择"),PDString(@"去拍照"),PDString(@"恢复默认图片")];
    [self actionSheet:selectedImageBlock isEdit:edit delegate:vc title:PDString(@"更换封面图片") titles:titles];
}

//选择图像
- (void)showActionSheet:(PickImageCallBackBlock)selectedImageBlock
                   isEdit:(BOOL)edit
               delegate:(UIViewController *)vc
{
    NSArray *titles = @[PDString(@"从相册选择"),PDString(@"去拍照")];
    [self actionSheet:selectedImageBlock isEdit:edit delegate:vc title:PDString(@"选择图片") titles:titles];

}

- (void)actionSheet:(PickImageCallBackBlock)selectedImageBlock
             isEdit:(BOOL)edit
           delegate:(UIViewController *)vc
              title:(NSString *)title
             titles:(NSArray *)titles
{
    if (_callBack) {
        [self setCallBack:nil];
    }
    isEdit = YES;
    self.viewController = vc;
    [self setCallBack:selectedImageBlock];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil, nil];
    if (isValidArray(titles)) {
        [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            [actionSheet addButtonWithTitle:title];
        }];
        [actionSheet setCancelButtonIndex:[titles count]];
    }
    [actionSheet addButtonWithTitle:PDString(@"取消")];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

//选择图像
- (void)showActionSheet:(PickImageCallBackBlock)selectedImageBlock delegate:(UIViewController *)vc
{
    isEdit = YES;
    [self showActionSheet:selectedImageBlock isEdit:isEdit delegate:vc];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //从相册选择
        [self openPhotoLibrary];
    }else if(buttonIndex == 1){
        //拍照
        [self takePhoto];
    }else if(buttonIndex == 2){
        _callBack(nil,buttonIndex);
    }
}

#pragma mark Modify avatar and background

-(void)openPhotoLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = isEdit;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [_viewController presentViewController:picker animated:YES completion:^{
        if (isIOS7) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        }
    }];
}

//take a photo from camera
-(void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *iconPickerController = [[UIImagePickerController alloc] init];
        iconPickerController.delegate = self;
        iconPickerController.allowsEditing = isEdit;
        iconPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        iconPickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        iconPickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        iconPickerController.showsCameraControls = YES;
        [_viewController presentViewController:iconPickerController
                           animated:YES completion:^{
                               if (isIOS7) {
                                   [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
                               }
                           }];
	}else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:PDString(@"设备不支持拍照") message:nil delegate:nil cancelButtonTitle:PDString(@"确定") otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image;
    if (isEdit) {   //编辑的图片
         image = [info objectForKey:UIImagePickerControllerEditedImage];
    }else{  //原图片
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (image) {
        _callBack(image,-1);
    }else{
        [UIAlertView showAlertTitle:PDString(@"获取图片失败")];
    }
    [self dismiss:picker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismiss:picker];
}

- (void)dismiss:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}

- (void) dealloc {
    [self setCallBack:nil];
}

@end
