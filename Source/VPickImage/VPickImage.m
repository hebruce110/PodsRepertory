//
//  PPPickImage.m
//  PatPat
//
//  Created by patpat on 15/4/26.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "VPickImage.h"
#import "VExtensions.h"

@interface VPickImage()<UIPopoverPresentationControllerDelegate>
{
    BOOL isEdit;
}
@property (nonatomic,assign)UIViewController *viewController;
@property (nonatomic, copy) PickImageCallBackBlock callBack;
@property(nonatomic,strong) UIAlertController* alertController;

@end

@implementation VPickImage

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}


//选择图像
- (void)showActionSheet:(PickImageCallBackBlock)selectedImageBlock
                 isEdit:(BOOL)edit
               delegate:(UIViewController *)vc
             sourceView:(UIView*)sourceView
{
    NSArray *titles = @[@"从相册选择",@"去拍照",@"恢复默认图片"];
    [self actionSheet:selectedImageBlock isEdit:edit delegate:vc sourceView:sourceView title:@"Select Photo" titles:titles];
    
}

- (void)actionSheet:(PickImageCallBackBlock)selectedImageBlock
             isEdit:(BOOL)edit
           delegate:(UIViewController *)vc
         sourceView:(UIView*)sourceView
              title:(NSString *)title
             titles:(NSArray *)titles
{
    if (_callBack) {
        [self setCallBack:nil];
    }
    
    isEdit = edit;
    self.viewController = vc;
    [self setCallBack:selectedImageBlock];
    _alertController = [UIAlertController alertControllerWithTitle:title  message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (titles) {
        [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            UIAlertAction* action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                switch (idx) {
                    case 0:
                        [self openPhotoLibrary:sourceView];
                        break;
                    case 1:
                        [self takePhoto];
                        break;
                    case 2:
                        _callBack(nil,idx);
                        break;
                    default:
                        break;
                }
            }];
            [_alertController addAction:action];
        }];
    }
    UIPopoverPresentationController* ppc = self.alertController.popoverPresentationController;
    ppc.sourceView = self.viewController.view;
    ppc.sourceRect = [sourceView convertRect:sourceView.bounds toView:sourceView];
    ppc.sourceView = sourceView;
    [self.viewController presentViewController:self.alertController animated:YES completion:nil];
}

//选择图像
- (void)showActionSheet:(PickImageCallBackBlock)selectedImageBlock delegate:(UIViewController *)vc sourceView:(UIView*)sourceView
{
    [self showActionSheet:selectedImageBlock isEdit:NO delegate:vc sourceView:sourceView];
}

#pragma mark Modify avatar and background

-(void)openPhotoLibrary:(UIView*)sourceView
{
    if (isiPhone) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = isEdit;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [_viewController presentViewController:picker animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        }];
    }else {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = isEdit;//是否允许编辑
        picker.sourceType = sourceType;
        UIPopoverController *_popover = [[UIPopoverController alloc]initWithContentViewController:picker];
        [_popover presentPopoverFromRect:sourceView.bounds inView:sourceView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
   }
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"设备不支持拍照"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
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
        UIImage *resultImage = [image fixOrientation];
        if (resultImage.size.width>1000) { //width > 1000px就压缩到宽为960px
            CGSize size = CGSizeMake(960.0, 960.0*resultImage.size.height/resultImage.size.width);
            resultImage = [resultImage  createScaleThumbImage:size];
        }
        _callBack(resultImage,-1);
    }else{
        [UIAlertView showAlertTitle:@"获取图片失败"];
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